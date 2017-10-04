<?php
/*********************************************************************
    ajax.tickets.php

    AJAX interface for tickets

    Peter Rotich <peter@osticket.com>
    Copyright (c)  2006-2013 osTicket
    http://www.osticket.com

    Released under the GNU General Public License WITHOUT ANY WARRANTY.
    See LICENSE.TXT for details.

    vim: expandtab sw=4 ts=4 sts=4:
**********************************************************************/

if(!defined('INCLUDE_DIR')) die('403');

include_once(INCLUDE_DIR.'class.equipment.php');
require_once(INCLUDE_DIR.'class.ajax.php');
require_once(INCLUDE_DIR.'class.note.php');
include_once INCLUDE_DIR.'class.thread_actions.php';

class EquipmentAjaxAPI extends AjaxController {

    function lookup() {
        global $thisstaff;

        $limit = isset($_REQUEST['limit']) ? (int) $_REQUEST['limit']:25;
        $tickets=array();
        // Bail out of query is empty
        if (!$_REQUEST['q'])
            return $this->json_encode($tickets);

        $visibility = Q::any(array(
            'staff_id' => $thisstaff->getId(),
            'team_id__in' => $thisstaff->teams->values_flat('team_id'),
        ));

        if (!$thisstaff->showAssignedOnly() && ($depts=$thisstaff->getDepts())) {
            $visibility->add(array('dept_id__in' => $depts));
        }

        $hits = TicketModel::objects()
            ->filter($visibility)
            ->values('user__default_email__address')
            ->annotate(array(
                'number' => new SqlCode('null'),
                'tickets' => SqlAggregate::COUNT('ticket_id', true)))
            ->limit($limit);

        $q = $_REQUEST['q'];

        if (strlen($q) < 3)
            return $this->encode(array());

        global $ost;
        $hits = $ost->searcher->find($q, $hits)
            ->order_by(new SqlCode('__relevance__'), QuerySet::DESC);

        if (preg_match('/\d{2,}[^*]/', $q, $T = array())) {
            $hits = TicketModel::objects()
                ->values('user__default_email__address', 'number')
                ->annotate(array(
                    'tickets' => new SqlCode('1'),
                    '__relevance__' => new SqlCode(1)
                ))
                ->filter($visibility)
                ->filter(array('number__startswith' => $q))
                ->limit($limit)
                ->union($hits);
        }
        elseif (!count($hits) && preg_match('`\w$`u', $q)) {
            // Do wild-card fulltext search
            $_REQUEST['q'] = $q.'*';
            return $this->lookup();
        }

        foreach ($hits as $T) {
            $email = $T['user__default_email__address'];
            $count = $T['tickets'];
            if ($T['number']) {
                $tickets[] = array('id'=>$T['number'], 'value'=>$T['number'],
                    'info'=>"{$T['number']} — {$email}",
                    'matches'=>$_REQUEST['q']);
            }
            else {
                $tickets[] = array('email'=>$email, 'value'=>$email,
                    'info'=>"$email ($count)", 'matches'=>$_REQUEST['q']);
            }
        }

        return $this->json_encode($tickets);
    }

    function acquireLock($eid) {
        global $cfg, $thisstaff;

        if(!$cfg || !$cfg->getLockTime() || $cfg->getTicketLockMode() == Lock::MODE_DISABLED)
            Http::response(418, $this->encode(array('id'=>0, 'retry'=>false)));

        if(!$eid || !is_numeric($eid) || !$thisstaff)
            return 0;

        if (!($equipment = Equipment::lookup($eid)))
            return $this->encode(array('id'=>0, 'retry'=>false, 'msg'=>__('Lock denied!')));

        //is the ticket already locked?
        if ($equipment->isLocked() && ($lock=$equipment->getLock()) && !$lock->isExpired()) {
            /*Note: Ticket->acquireLock does the same logic...but we need it here since we need to know who owns the lock up front*/
            //Ticket is locked by someone else.??
            if ($lock->getStaffId() != $thisstaff->getId())
                return $this->json_encode(array('id'=>0, 'retry'=>false,
                    'msg' => sprintf(__('Currently locked by %s'),
                        $lock->getStaff()->getAvatarAndName())
                    ));

            //Ticket already locked by staff...try renewing it.
            $lock->renew(); //New clock baby!
        } elseif(!($lock=$equipment->acquireLock($thisstaff->getId(),$cfg->getLockTime()))) {
            //unable to obtain the lock..for some really weired reason!
            //Client should watch for possible loop on retries. Max attempts?
            return $this->json_encode(array('id'=>0, 'retry'=>true));
        }

        return $this->json_encode(array(
            'id'=>$lock->getId(), 'time'=>$lock->getTime(),
            'code' => $lock->getCode()
        ));
    }

    function renewLock($id, $equipmentId) {
        global $thisstaff;

        if (!$id || !is_numeric($id) || !$thisstaff)
            Http::response(403, $this->encode(array('id'=>0, 'retry'=>false)));
        if (!($lock = Lock::lookup($id)))
            Http::response(404, $this->encode(array('id'=>0, 'retry'=>'acquire')));
        if (!($equipment = Equipment::lookup($equipmentId)) || $equipment->lock_id != $lock->lock_id)
            // Ticket / Lock mismatch
            Http::response(400, $this->encode(array('id'=>0, 'retry'=>false)));

        if (!$lock->getStaffId() || $lock->isExpired())
            // Said lock doesn't exist or is is expired — fetch a new lock
            return self::acquireLock($equipment->getId());

        if ($lock->getStaffId() != $thisstaff->getId())
            // user doesn't own the lock anymore??? sorry...try to next time.
            Http::response(403, $this->encode(array('id'=>0, 'retry'=>false,
                'msg' => sprintf(__('Currently locked by %s'),
                    $lock->getStaff->getAvatarAndName())
            ))); //Give up...

        // Renew the lock.
        // Failure here is not an issue since the lock is not expired yet.. client need to check time!
        $lock->renew();

        return $this->encode(array('id'=>$lock->getId(), 'time'=>$lock->getTime(),
            'code' => $lock->getCode()));
    }

    function releaseLock($id) {
        global $thisstaff;

        if (!$id || !is_numeric($id) || !$thisstaff)
            Http::response(403, $this->encode(array('id'=>0, 'retry'=>true)));
        if (!($lock = Lock::lookup($id)))
            Http::response(404, $this->encode(array('id'=>0, 'retry'=>true)));

        // You have to own the lock
        if ($lock->getStaffId() != $thisstaff->getId()) {
            return 0;
        }
        // Can't be expired
        if ($lock->isExpired()) {
            return 1;
        }
        return $lock->release() ? 1 : 0;
    }

    function previewEquipment ($tid) {
        global $thisstaff;

        if(!$thisstaff || !($equipment=Equipment::lookup($tid))
                || !$equipment->checkStaffPerm($thisstaff))
            Http::response(404, __('No such equipment'));

        include STAFFINC_DIR . 'templates/equipment-preview.tmpl.php';
    }

    function viewUser($tid) {
        global $thisstaff;

        if(!$thisstaff
                || !($ticket=Ticket::lookup($tid))
                || !$ticket->checkStaffPerm($thisstaff))
            Http::response(404, 'No such ticket');


        if(!($user = User::lookup($ticket->getOwnerId())))
            Http::response(404, 'Unknown user');


        $info = array(
            'title' => sprintf(__('Ticket #%s: %s'), $ticket->getNumber(),
                Format::htmlchars($user->getName()))
            );

        ob_start();
        include(STAFFINC_DIR . 'templates/user.tmpl.php');
        $resp = ob_get_contents();
        ob_end_clean();
        return $resp;

    }

    function updateUser($tid) {

        global $thisstaff;

        if(!$thisstaff
                || !($ticket=Ticket::lookup($tid))
                || !$ticket->checkStaffPerm($thisstaff)
                || !($user = User::lookup($ticket->getOwnerId())))
            Http::response(404, 'No such ticket/user');

        $errors = array();
        if($user->updateInfo($_POST, $errors, true))
             Http::response(201, $user->to_json());

        $forms = $user->getForms();

        $info = array(
            'title' => sprintf(__('Ticket #%s: %s'), $ticket->getNumber(),
                Format::htmlchars($user->getName()))
            );

        ob_start();
        include(STAFFINC_DIR . 'templates/user.tmpl.php');
        $resp = ob_get_contents();
        ob_end_clean();
        return $resp;
    }

    function changeUserForm($tid) {
        global $thisstaff;

        if(!$thisstaff
                || !($ticket=Ticket::lookup($tid))
                || !$ticket->checkStaffPerm($thisstaff))
            Http::response(404, 'No such ticket');


        $user = User::lookup($ticket->getOwnerId());

        $info = array(
                'title' => sprintf(__('Change user for ticket #%s'), $ticket->getNumber())
                );

        return self::_userlookup($user, null, $info);
    }

    function _userlookup($user, $form, $info) {
        global $thisstaff;

        ob_start();
        include(STAFFINC_DIR . 'templates/user-lookup.tmpl.php');
        $resp = ob_get_contents();
        ob_end_clean();
        return $resp;

    }

    function manageForms($ticket_id) {
        global $thisstaff;

        if (!$thisstaff)
            Http::response(403, "Login required");
        elseif (!($ticket = Ticket::lookup($ticket_id)))
            Http::response(404, "No such ticket");
        elseif (!$ticket->checkStaffPerm($thisstaff, Ticket::PERM_EDIT))
            Http::response(403, "Access Denied");

        $forms = DynamicFormEntry::forTicket($ticket->getId());
        $info = array('action' => '#tickets/'.$ticket->getId().'/forms/manage');
        include(STAFFINC_DIR . 'templates/form-manage.tmpl.php');
    }

    function updateForms($ticket_id) {
        global $thisstaff;

        if (!$thisstaff)
            Http::response(403, "Login required");
        elseif (!($ticket = Ticket::lookup($ticket_id)))
            Http::response(404, "No such ticket");
        elseif (!$ticket->checkStaffPerm($thisstaff, Ticket::PERM_EDIT))
            Http::response(403, "Access Denied");
        elseif (!isset($_POST['forms']))
            Http::response(422, "Send updated forms list");

        // Add new forms
        $forms = DynamicFormEntry::forTicket($ticket_id);
        foreach ($_POST['forms'] as $sort => $id) {
            $found = false;
            foreach ($forms as $e) {
                if ($e->get('form_id') == $id) {
                    $e->set('sort', $sort);
                    $e->save();
                    $found = true;
                    break;
                }
            }
            // New form added
            if (!$found && ($new = DynamicForm::lookup($id))) {
                $f = $new->instanciate();
                $f->set('sort', $sort);
                $f->setTicketId($ticket_id);
                $f->save();
            }
        }

        // Deleted forms
        foreach ($forms as $idx => $e) {
            if (!in_array($e->get('form_id'), $_POST['forms']))
                $e->delete();
        }

        Http::response(201, 'Successfully managed');
    }

    function cannedResponse($tid, $cid, $format='text') {
        global $thisstaff, $cfg;

        if (!($ticket = Ticket::lookup($tid))
                || !$ticket->checkStaffPerm($thisstaff))
            Http::response(404, 'Unknown ticket ID');


        if ($cid && !is_numeric($cid)) {
            if (!($response=$ticket->getThread()->getVar($cid)))
                Http::response(422, 'Unknown ticket variable');

            // Ticket thread variables are assumed to be quotes
            $response = "<br/><blockquote>{$response->asVar()}</blockquote><br/>";

            //  Return text if html thread is not enabled
            if (!$cfg->isRichTextEnabled())
                $response = Format::html2text($response, 90);
            else
                $response = Format::viewableImages($response);

            // XXX: assuming json format for now.
            return Format::json_encode(array('response' => $response));
        }

        if (!$cfg->isRichTextEnabled())
            $format.='.plain';

        $varReplacer = function (&$var) use($ticket) {
            return $ticket->replaceVars($var);
        };

        include_once(INCLUDE_DIR.'class.canned.php');
        if (!$cid || !($canned=Canned::lookup($cid)) || !$canned->isEnabled())
            Http::response(404, 'No such premade reply');

        return $canned->getFormattedResponse($format, $varReplacer);
    }

    function transfer($tid) {
        global $thisstaff;

        if (!($equipment=Equipment::lookup($tid)))
            Http::response(404, __('No such equipment'));

        if (!$equipment->checkStaffPerm($thisstaff, Equipment::PERM_TRANSFER))
            Http::response(403, __('Permission denied'));

        $errors = array();

        $info = array(
                ':title' => sprintf('Equipamiento #%s: %s',
                    $equipment->getId(),
                    __('Transfer')),
                ':action' => sprintf('#equipments/%d/transfer',
                    $equipment->getId())
                );

        $form = $equipment->getTransferForm($_POST);
        if ($_POST && $form->isValid()) {
            if ($equipment->transfer($form, $errors)) {
                $_SESSION['::sysmsgs']['msg'] = sprintf(
                        __('%s successfully'),
                        sprintf(
                            __('%s transferred to %s department'),
                            'Equipamiento',
                            $equipment->getDept()
                            )
                        );
                Http::response(201, $equipment->getId());
            }

            $form->addErrors($errors);
            $info['error'] = $errors['err'] ?: __('Unable to transfer ticket');
        }

        $info['dept_id'] = $info['dept_id'] ?: $equipment->getDeptId();

        include STAFFINC_DIR . 'templates/transfer.tmpl.php';
    }


    function assign($tid, $target=null) {
        global $thisstaff;

        if (!($ticket=Ticket::lookup($tid)))
            Http::response(404, __('No such ticket'));

        if (!$ticket->checkStaffPerm($thisstaff, Ticket::PERM_ASSIGN)
                || !($form = $ticket->getAssignmentForm($_POST,
                        array('target' => $target))))
            Http::response(403, __('Permission denied'));

        $errors = array();
        $info = array(
                ':title' => sprintf(__('Ticket #%s: %s'),
                    $ticket->getNumber(),
                    sprintf('%s %s',
                        $ticket->isAssigned() ?
                            __('Reassign') :  __('Assign'),
                        !strcasecmp($target, 'agents') ?
                            __('to an Agent') : __('to a Team')
                    )),
                ':action' => sprintf('#tickets/%d/assign%s',
                    $ticket->getId(),
                    ($target  ? "/$target": '')),
                );

        if ($ticket->isAssigned()) {
            if ($ticket->getStaffId() == $thisstaff->getId())
                $assigned = __('you');
            else
                $assigned = $ticket->getAssigned();

            $info['notice'] = sprintf(__('%s is currently assigned to <b>%s</b>'),
                    __('This ticket'),
                    Format::htmlchars($assigned)
                    );
        }

        if ($_POST && $form->isValid()) {
            if ($ticket->assign($form, $errors)) {
                $_SESSION['::sysmsgs']['msg'] = sprintf(
                        __('%s successfully'),
                        sprintf(
                            __('%s assigned to %s'),
                            __('Ticket'),
                            $form->getAssignee())
                        );
                Http::response(201, $ticket->getId());
            }

            $form->addErrors($errors);
            $info['error'] = $errors['err'] ?: __('Unable to assign ticket');
        }

        include STAFFINC_DIR . 'templates/assign.tmpl.php';
    }

    function claim($tid) {

        global $thisstaff;

        if (!($ticket=Ticket::lookup($tid)))
            Http::response(404, __('No such ticket'));

        // Check for premissions and such
        if (!$ticket->checkStaffPerm($thisstaff, Ticket::PERM_ASSIGN)
                || !$ticket->isOpen() // Claim only open
                || $ticket->getStaff() // cannot claim assigned ticket
                || !($form = $ticket->getClaimForm($_POST)))
            Http::response(403, __('Permission denied'));

        $errors = array();
        $info = array(
                ':title' => sprintf(__('Ticket #%s: %s'),
                    $ticket->getNumber(),
                    __('Claim')),
                ':action' => sprintf('#tickets/%d/claim',
                    $ticket->getId()),

                );

        if ($ticket->isAssigned()) {
            if ($ticket->getStaffId() == $thisstaff->getId())
                $assigned = __('you');
            else
                $assigned = $ticket->getAssigned();

            $info['error'] = sprintf(__('%s is currently assigned to <b>%s</b>'),
                    __('This ticket'),
                    $assigned);
        } else {
            $info['warn'] = sprintf(__('Are you sure you want to CLAIM %s?'),
                    __('this ticket'));
        }

        if ($_POST && $form->isValid()) {
            if ($ticket->claim($form, $errors)) {
                $_SESSION['::sysmsgs']['msg'] = sprintf(
                        __('%s successfully'),
                        sprintf(
                            __('%s assigned to %s'),
                            __('Ticket'),
                            __('you'))
                        );
                Http::response(201, $ticket->getId());
            }

            $form->addErrors($errors);
            $info['error'] = $errors['err'] ?: __('Unable to claim ticket');
        }

        $verb = sprintf('%s, %s', __('Yes'), __('Claim'));

        include STAFFINC_DIR . 'templates/assign.tmpl.php';

    }

    function massProcess($action, $w=null)  {
        global $thisstaff, $cfg;

        $actions = array(
                'transfer' => array(
                    'verbed' => __('transferred'),
                    ),
                'delete' => array(
                    'verbed' => __('deleted'),
                    ),
                'retire' => array(
                    'verbed' => 'retirado',
                    ),
                );

        if (!isset($actions[$action]))
            Http::response(404, __('Unknown action'));


        $info = $errors = $e = array();
        $inc = null;
        $i = $count = 0;
        if ($_POST) {
            if (!$_POST['tids'] || !($count=count($_POST['tids'])))
                $errors['err'] = sprintf(
                        __('You must select at least %s.'),
                        'un item');
        } else {
            $count  =  $_REQUEST['count'];
        }
        switch ($action) {
        case 'transfer':
            $inc = 'transfer.tmpl.php';
            $info[':action'] = '#equipments/mass/transfer';
            $info[':title'] = sprintf(__('Transfer %s'),
                    _N('selected item', 'selected items', $count));
            
            $form = TransferForm::instantiate($_POST);
            if ($_POST && $form->isValid()) {
                foreach ($_POST['tids'] as $tid) {
                    if (($t=Equipment::lookup($tid))
                            // Make sure the agent is allowed to
                            // access and transfer the task.
                            && $t->checkStaffPerm($thisstaff, Equipment::PERM_TRANSFER)
                            // Do the transfer
                            && $t->transfer($form, $e)
                            )
                        $i++;
                }

                if (!$i) {
                    $info['error'] = sprintf(
                            __('Unable to %1$s %2$s'),
                            __('transfer'),
                            _N('selected item', 'selected items', $count));
                }
            }
            break;
        case 'delete':
            $inc = 'delete.tmpl.php';
            $info[':action'] = '#equipments/mass/delete';
            $info[':title'] = sprintf(__('Delete %s'),
                    _N('selected item', 'selected items', $count));

            $info[':placeholder'] = sprintf(__(
                        'Optional reason for deleting %s'),
                    _N('selected item', 'selected items', $count));
            $info['warn'] = sprintf(__(
                        'Are you sure you want to DELETE %s?'),
                    _N('selected item', 'selected items', $count));
            $info[':extra'] = sprintf('<strong>%s</strong>',
                        __('Deleted items CANNOT be recovered, including any associated attachments.')
                        );

            // Generic permission check.
            if (!$thisstaff->hasPerm(Equipment::PERM_DELETE, false))
                $errors['err'] = sprintf(
                        __('You do not have permission %s'),
                        'para eliminar equipamiento');

            if ($_POST && !$errors) {
                foreach ($_POST['tids'] as $tid) {
                    if (($t=Equipment::lookup($tid))
                            && $t->checkStaffPerm($thisstaff, Equipment::PERM_DELETE)
                            && $t->delete($_POST['comments'], $e)
                            )
                        $i++;
                }

                if (!$i) {
                    $info['error'] = sprintf(
                            __('Unable to %1$s %2$s'),
                            __('delete'),
                            _N('selected item', 'selected items', $count));
                }
            }
            break;
        default:
            Http::response(404, __('Unknown action'));
        }

        if ($_POST && $i) {

            // Assume success
            if ($i==$count) {
                $msg = sprintf(__('Successfully %1$s %2$s.'),
                        $actions[$action]['verbed'],
                        sprintf('%1$d %2$s',
                            $count,
                            _N('selected item', 'selected items', $count))
                        );
                $_SESSION['::sysmsgs']['msg'] = $msg;
            } else {
                $warn = sprintf(
                        __('%1$d of %2$d %3$s %4$s'
                        /* Tokens are <x> of <y> <selected ticket(s)> <actioned> */),
                        $i, $count,
                        _N('selected item', 'selected items',
                            $count),
                        $actions[$action]['verbed']);
                $_SESSION['::sysmsgs']['warn'] = $warn;
            }
            Http::response(201, 'processed');
        } elseif($_POST && !isset($info['error'])) {
            $info['error'] = $errors['err'] ?: sprintf(
                    __('Unable to %1$s %2$s'),
                    __('process'),
                    _N('selected item', 'selected items', $count));
        }

        if ($_POST)
            $info = array_merge($info, Format::htmlchars($_POST));

        include STAFFINC_DIR . "templates/$inc";
        //  Copy checked tickets to the form.
        echo "
        <script type=\"text/javascript\">
        $(function() {
            $('form#equipments input[name=\"tids[]\"]:checkbox:checked')
            .each(function() {
                $('<input>')
                .prop('type', 'hidden')
                .attr('name', 'tids[]')
                .val($(this).val())
                .appendTo('form.mass-action');
            });
        });
        </script>";

    }

    function changeEquipmentStatus($tid, $status, $id=0) {
        global $thisstaff;

        if (!$thisstaff)
            Http::response(403, 'Access denied');
        elseif (!$tid
                || !($equipment=Equipment::lookup($tid)))
            Http::response(404, 'Unknown equipment #');
        
        $role = $thisstaff->getRole($equipment->getDeptId());

        $info = array();
        $state = null;
        switch($status) {
            case 'activate':
                $state = 'active';
                break;
            case 'deactivate':
                $state = 'inactive';
                break;
            case 'retire':
                if (!$role->hasPerm(EquipmentModel::PERM_RETIRE))
                    Http::response(403, 'Access denied');
                $state = 'retired';
                break;
            case 'delete':
                if (!$role->hasPerm(EquipmentModel::PERM_DELETE))
                    Http::response(403, 'Access denied');
                $state = 'deleted';
                break;
            default:
                $state = $equipment->getStatus()->getState();
                $info['warn'] = sprintf(__('%s: Unknown or invalid'),
                        __('status'));
        }

        $info['status_id'] = $id ?: $equipment->getStatusId();

        return self::_changeEquipmentStatus($equipment, $state, $info);
    }

    function setEquipmentStatus($tid) {
        global $thisstaff, $ost;

        if (!$thisstaff)
            Http::response(403, 'Access denied');
        elseif (!$tid
                || !($equipment=Equipment::lookup($tid)))
            Http::response(404, 'Unknown equipment #');

        $errors = $info = array();
        if (!$_POST['status_id']
                || !($status= EquipmentStatus::lookup($_POST['status_id'])))
            $errors['status_id'] = sprintf('%s %s',
                    __('Unknown or invalid'), __('status'));
        elseif ($status->getId() == $equipment->getStatusId())
            $errors['err'] = sprintf(__('Equipamiento ya en estado %s'),
                    __($status->getName()));
        elseif (($role = $thisstaff->getRole($equipment->getDeptId()))) {
            // Make sure the agent has permission to set the status
            switch(mb_strtolower($status->getState())) {
                case 'active':
                    break;
                case 'inactive':
                    break;
                case 'retired':
                    if (!$role->hasPerm(EquipmentModel::PERM_RETIRE))
                        $errors['err'] = sprintf(__('You do not have permission %s'),
                                'para retirar equipamiento');
                    break;
                case 'deleted':
                    if (!$role->hasPerm(TicketModel::PERM_DELETE))
                        $errors['err'] = sprintf(__('You do not have permission %s'),
                                'para eliminar equipamiento');
                    break;
                default:
                    $errors['err'] = sprintf('%s %s',
                            __('Unknown or invalid'), __('status'));
            }
        }

        $state = strtolower($status->getState());

        if (!$errors && $equipment->setStatus($status, $_REQUEST['comments'], $errors)) {

            if ($state == 'deleted') {
                $msg = sprintf('%s %s',
                        sprintf(__('Equipamiento %s'), $equipment->getName()),
                        __('deleted sucessfully')
                        );
            } elseif ($state != 'open') {
                 $msg = sprintf(__('%s status changed to %s'),
                         sprintf(__('Equipamiento %s'), $equipment->getName()),
                         $status->getName());
            } else {
                $msg = sprintf(
                        __('Estado del equipamiento cambiado a %s'),
                        $status->getName());
            }

            $_SESSION['::sysmsgs']['msg'] = $msg;

            Http::response(201, 'Successfully processed');
        } elseif (!$errors['err']) {
            $errors['err'] =  __('Error updating equipment status');
        }

        $state = $state ?: $equipment->getStatus()->getState();
        $info['status_id'] = $status
            ? $status->getId() : $equipment->getStatusId();

        return self::_changeEquipmentStatus($equipment, $state, $info, $errors);
    }

    function changeSelectedEquipmentStatus($status, $id=0) {
        global $thisstaff, $cfg;

        if (!$thisstaff)
            Http::response(403, 'Access denied');

        $state = null;
        $info = array();
        switch($status) {
            case 'create':
                $state = 'new';
                break;
            case 'retire':
                if (!$thisstaff->hasPerm(EquipmentModel::PERM_RETIRE, false))
                    Http::response(403, 'Access denied');
                $state = 'retired';
                break;
            case 'activate':
                $state = 'active';
                break;
            case 'deactivate':
                $state = 'inactive';
                break;
            default:
                $info['warn'] = sprintf('%s %s',
                        __('Unknown or invalid'), __('status'));
        }

        $info['status_id'] = $id;

        return self::_changeSelectedEquipmentStatus($state, $info);
    }

    function setSelectedEquipmentStatus($state) {
        global $thisstaff, $ost;
        
        $errors = $info = array();
        if (!$thisstaff)
            $errors['err'] = sprintf('%s %s',
                    sprintf(__('You do not have permission %s'),
                        __('to mass manage equipment')),
                    __('Contact admin for such access'));
        elseif (!$_REQUEST['tids'] || !count($_REQUEST['tids']))
            $errors['err']=sprintf(__('You must select at least %s.'),
                    __('one ticket'));
        elseif (!($status=EquipmentStatus::lookup($_REQUEST['status_id'])))
            $errors['status_id'] = sprintf('%s %s',
                    __('Unknown or invalid'), __('status'));
        elseif (!$errors) {
            // Make sure the agent has permission to set the status
            switch(mb_strtolower($status->getState())) {
                case 'new':
                case 'active':
                case 'inactive':
                    break;
                case 'retired':
                    if (!$thisstaff->hasPerm(EquipmentModel::PERM_RETIRE, false))
                        $errors['err'] = sprintf(__('You do not have permission %s'),
                                'para retirar equipamiento');
                    break;
                default:
                    $errors['err'] = sprintf('%s %s',
                            __('Unknown or invalid'), __('status'));
            }
        }

        $count = count($_REQUEST['tids']);
        if (!$errors) {
            $i = 0;
            $comments = $_REQUEST['comments'];
            foreach ($_REQUEST['tids'] as $tid) {

                if (($equipment=Equipment::lookup($tid))
                        && $equipment->getStatusId() != $status->getId()
                        && $equipment->setStatus($status, $comments, $errors))
                    $i++;
            }

            if (!$i) {
                $errors['err'] = $errors['err']
                    ?: sprintf(__('Unable to change status for %s'),
                        _N('item seleccionado', 'items seleccionados', $count));
            }
            else {
                // Assume success
                if ($i==$count) {

                    if (!strcasecmp($status->getState(), 'deleted')) {
                        $msg = sprintf(__( 'Successfully deleted %s.'),
                                _N('item seleccionado', 'items seleccionados', $count));
                    } else {
                       $msg = sprintf(
                            __(
                                /* 1$ will be 'selected ticket(s)', 2$ is the new status */
                                'Successfully changed status of %1$s to %2$s'),
                            _N('item seleccionado', 'items seleccionados', $count),
                            $status->getName());
                    }

                    $_SESSION['::sysmsgs']['msg'] = $msg;
                } else {

                    if (!strcasecmp($status->getState(), 'deleted')) {
                        $warn = sprintf(__('Successfully deleted %s.'),
                                sprintf(__('%1$d of %2$d selected tickets'),
                                    $i, $count)
                                );
                    } else {

                        $warn = sprintf(
                                __('%1$d of %2$d %3$s status changed to %4$s'),$i, $count,
                                _N('item seleccionado', 'items seleccionados', $count),
                                $status->getName());
                    }

                    $_SESSION['::sysmsgs']['warn'] = $warn;
                }

                Http::response(201, 'Successfully processed');
            }
        }

        return self::_changeSelectedEquipmentStatus($state, $info, $errors);
    }

    function triggerThreadAction($ticket_id, $thread_id, $action) {
        $thread = ThreadEntry::lookup($thread_id);
        if (!$thread)
            Http::response(404, 'No such ticket thread entry');
        if ($thread->getThread()->getObjectId() != $ticket_id)
            Http::response(404, 'No such ticket thread entry');

        $valid = false;
        foreach ($thread->getActions() as $group=>$list) {
            foreach ($list as $name=>$A) {
                if ($A->getId() == $action) {
                    $valid = true; break;
                }
            }
        }
        if (!$valid)
            Http::response(400, 'Not a valid action for this thread');

        $thread->triggerAction($action);
    }

    private function _changeSelectedEquipmentStatus($state, $info=array(), $errors=array()) {

        $count = $_REQUEST['count'] ?:
            ($_REQUEST['tids'] ?  count($_REQUEST['tids']) : 0);

        $info['title'] = sprintf(__('Change Status &mdash; %1$d %2$s selected'),
                 $count,
                 _N('item', 'items', $count)
                 );

        if (!strcasecmp($state, 'deleted')) {

            $info['warn'] = sprintf(__(
                        'Are you sure you want to DELETE %s?'),
                        _N('item', 'items', $count)
                    );

            $info['extra'] = sprintf('<strong>%s</strong>', __(
                        'Deleted items CANNOT be recovered, including any associated attachments.')
                    );

            $info['placeholder'] = sprintf(__(
                        'Optional reason for deleting %s'),
                        _N('item', 'items', $count)
                    );
        }

        $info['status_id'] = $info['status_id'] ?: $_REQUEST['status_id'];
        $info['comments'] = Format::htmlchars($_REQUEST['comments']);

        return self::_changeStatus($state, $info, $errors);
    }

    private function _changeEquipmentStatus($equipment, $state, $info=array(), $errors=array()) {

        $verb = EquipmentStateField::getVerb($state);

        $info['action'] = sprintf('#equipments/%d/status', $equipment->getId());
        $info['title'] = sprintf(__(
                    /* 1$ will be a verb, like 'open', 2$ will be the ticket number */
                    '%1$s %2$s'),
                $verb ?: $state,
                $equipment->getName()
                );

        // Deleting?
        if (!strcasecmp($state, 'deleted')) {

            $info['placeholder'] = sprintf(__(
                        'Optional reason for deleting %s'),
                    __('este equipamiento'));
            $info[ 'warn'] = sprintf(__(
                        'Are you sure you want to DELETE %s?'),
                        __('este equipamiento'));
            //TODO: remove message below once we ship data retention plug
            $info[ 'extra'] = sprintf('<strong>%s</strong>',
                        __('Deleted items CANNOT be recovered, including any associated attachments.')
                        );
        }

        $info['status_id'] = $info['status_id'] ?: $equipment->getStatusId();
        $info['comments'] = Format::htmlchars($_REQUEST['comments']);

        return self::_changeStatus($state, $info, $errors);
    }

    private function _changeStatus($state, $info=array(), $errors=array()) {

        if ($info && isset($info['errors']))
            $errors = array_merge($errors, $info['errors']);

        if (!$info['error'] && isset($errors['err']))
            $info['error'] = $errors['err'];

        include(STAFFINC_DIR . 'templates/equipment-status.tmpl.php');
    }

    function reservations($tid) {
        global $thisstaff;

        if (!($equipment=equipment::lookup($tid)))
            Http::response(404, 'Unknown equipment');

         include STAFFINC_DIR . 'equipment-reservations.inc.php';
    }
    
    function histReservations($tid) {
        global $thisstaff;

        if (!($equipment=equipment::lookup($tid)))
            Http::response(404, 'Unknown equipment');

         include STAFFINC_DIR . 'equipment-hist-reservations.inc.php';
    }

    function addReservation($tid) {
        global $thisstaff;

        if (!($equipment=Equipment::lookup($tid)))
            Http::response(404, 'Unknown equipment');

        $info=$errors=array();

        if ($_POST) {
            Draft::deleteForNamespace(
                    sprintf('equipment.%d.reservation', $equipment->getId()),
                    $thisstaff->getId());
            // Default form
            $form = ReservationForm::getInstance();
            $form->setSource($_POST);
            // Internal form
            $iform = ReservationForm::getInternalForm($_POST);
            
            // Se añade un validador de fechas de comienzo y fin de reserva
            // que compruebe que una es posterior a la otra
            $iform->addValidator(function($form) use ($equipment) {
                $reservations = EquipmentReservation::objects()->order_by('start');
                $reservations->filter(array('equipment_id' => $equipment->getId()));
                $start=$form->getField('start');
                $startStr=substr($start->getValue(), 0, 19);
                $end=$form->getField('end');
                $endStr=substr($end->getValue(), 0, 19);
                
                // Primero se comprueba que la fecha de comienzo sea posterior a
                // la actual
                if (strcmp($start->getValue(), date("Y-m-d H:i:s")) < 0) {
                    $start->addError('El comienzo de la reserva debe ser posterior al actual');
                    return;
                }
                
                // Después se comprueba que el final sea posterior al comienzo
                if (strcmp($start->getValue(), $end->getValue()) >= 0) {
                    $start->addError('El comienzo de la reserva debe ser anterior al final');
                    $end->addError('El final de la reserva debe ser posterior al comienzo');
                    return;
                }
                
                // Después que no se solape con otra reserva actual
                $error = false;
                foreach($reservations as $reservation) {
                    if (strcmp($reservation->getStartDate(), $startStr) <= 0
                            && strcmp($reservation->getEndDate(), $startStr) > 0) {
                        $start->addError('El comienzo se solapa con otro periodo ya reservado. Revise las reservas actuales.');
                        $error = true;
                    }
                    if (strcmp($reservation->getStartDate(), $endStr) < 0
                            && strcmp($reservation->getEndDate(), $endStr) >= 0) {
                        $end->addError('El final se solapa con otro periodo ya reservado. Revise las reservas actuales.');
                        $error = true;
                    }
                    if (!$error && strcmp($reservation->getStartDate(), $startStr) > 0
                            && strcmp($reservation->getEndDate(), $endStr) < 0) {
                        $start->addError('El periodo solicitado contiene otro ya reservado. Revise las reservas actuales');
                        $end->addError('El periodo solicitado contiene otro ya reservado. Revise las reservas actuales');
                    }
                    if ($error) {
                        break;
                    }
                }
            });
            
            $isvalid = true;
            if (!$iform->isValid())
                $isvalid = false;
            if (!$form->isValid())
                $isvalid = false;

            if ($isvalid) {
                $vars = $_POST;
                $vars['equipment_id'] = $equipment->getId();
                $vars['default_formdata'] = $form->getClean();
                $vars['internal_formdata'] = $iform->getClean();
                /*$desc = $form->getField('description');
                if ($desc
                        && $desc->isAttachmentsEnabled()
                        && ($attachments=$desc->getWidget()->getAttachments()))
                    $vars['cannedattachments'] = $attachments->getClean();*/
                $vars['staff_id'] = $thisstaff->getId();
                $vars['poster'] = $thisstaff;
                $vars['ip_address'] = $_SERVER['REMOTE_ADDR'];
                if (($reservation= EquipmentReservation::create($vars, $errors))) {
                    Http::response(201, $reservation->getId());
                }
            }

            $info['error'] = sprintf('%s - %s', __('Error en la reserva'), __('Corrija los errores'));
        }

        $info['action'] = sprintf('#equipments/%d/add-reservation', $equipment->getId());
        $info['title'] = sprintf(
                __( '%1$s: %2$s'),
                $equipment->getName(),
                __('Reservar')
                );

         include STAFFINC_DIR . 'templates/reservation.tmpl.php';
    }

    function task($tid, $id) {
        global $thisstaff;

        if (!($ticket=Ticket::lookup($tid))
                || !$ticket->checkStaffPerm($thisstaff))
            Http::response(404, 'Unknown ticket');

        // Lookup task and check access
        if (!($task=Task::lookup($id))
                || !$task->checkStaffPerm($thisstaff))
            Http::response(404, 'Unknown task');

        $info = $errors = array();
        $note_attachments_form = new SimpleForm(array(
            'attachments' => new FileUploadField(array('id'=>'attach',
                'name'=>'attach:note',
                'configuration' => array('extensions'=>'')))
        ));

        $reply_attachments_form = new SimpleForm(array(
            'attachments' => new FileUploadField(array('id'=>'attach',
                'name'=>'attach:reply',
                'configuration' => array('extensions'=>'')))
        ));

        if ($_POST) {
            $vars = $_POST;
            switch ($_POST['a']) {
            case 'postnote':
                $attachments = $note_attachments_form->getField('attachments')->getClean();
                $vars['cannedattachments'] = array_merge(
                    $vars['cannedattachments'] ?: array(), $attachments);
                if (($note=$task->postNote($vars, $errors, $thisstaff))) {
                    $msg=__('Note posted successfully');
                    // Clear attachment list
                    $note_attachments_form->setSource(array());
                    $note_attachments_form->getField('attachments')->reset();
                    Draft::deleteForNamespace('task.note.'.$task->getId(),
                            $thisstaff->getId());
                } else {
                    if (!$errors['err'])
                        $errors['err'] = __('Unable to post the note - missing or invalid data.');
                }
                break;
            case 'postreply':
                $attachments = $reply_attachments_form->getField('attachments')->getClean();
                $vars['cannedattachments'] = array_merge(
                    $vars['cannedattachments'] ?: array(), $attachments);
                if (($response=$task->postReply($vars, $errors))) {
                    $msg=__('Update posted successfully');
                    // Clear attachment list
                    $reply_attachments_form->setSource(array());
                    $reply_attachments_form->getField('attachments')->reset();
                    Draft::deleteForNamespace('task.reply.'.$task->getId(),
                            $thisstaff->getId());
                } else {
                    if (!$errors['err'])
                        $errors['err'] = __('Unable to post the reply - missing or invalid data.');
                }
                break;
            default:
                $errors['err'] = __('Unknown action');
            }
        }

        include STAFFINC_DIR . 'templates/task-view.tmpl.php';
    }
}
?>
