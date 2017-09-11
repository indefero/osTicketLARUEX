<?php
/*************************************************************************
    tickets.php

    Handles all tickets related actions.

    Peter Rotich <peter@osticket.com>
    Copyright (c)  2006-2013 osTicket
    http://www.osticket.com

    Released under the GNU General Public License WITHOUT ANY WARRANTY.
    See LICENSE.TXT for details.

    vim: expandtab sw=4 ts=4 sts=4:
**********************************************************************/

require('staff.inc.php');
require_once(INCLUDE_DIR.'class.equipment.php');
require_once(INCLUDE_DIR.'class.export.php');       // For paper sizes

$page='';
$equipment = $user = null; //clean start.
$redirect = false;
//LOCKDOWN...See if the id provided is actually valid and if the user has access.
if($_REQUEST['id']) {
    if($_REQUEST['id'] && !($equipment= Equipment::lookup($_REQUEST['id'])))
         $errors['err']=sprintf(__('%s: Unknown or invalid ID.'), __('ticket'));
}

if (!$equipment) {
    $queue_key = sprintf('::Q:%s', ObjectModel::OBJECT_TYPE_EQUIPMENT);
    $queue_name = strtolower($_GET['a'] ?: $_GET['status']); //Status is overloaded
    if (!$queue_name && isset($_SESSION[$queue_key]))
        $queue_name = $_SESSION[$queue_key];

    // Stash current queue view
    $_SESSION[$queue_key] = $queue_name;

    // Set queue as status
    if (@!isset($_REQUEST['advanced'])
            && @$_REQUEST['a'] != 'search'
            && !isset($_GET['status'])
            && $queue_name)
        $_GET['status'] = $_REQUEST['status'] = $queue_name;
}

// Configure form for file uploads
$response_form = new SimpleForm(array(
    'attachments' => new FileUploadField(array('id'=>'attach',
        'name'=>'attach:response',
        'configuration' => array('extensions'=>'')))
));
$note_form = new SimpleForm(array(
    'attachments' => new FileUploadField(array('id'=>'attach',
        'name'=>'attach:note',
        'configuration' => array('extensions'=>'')))
));

//At this stage we know the access status. we can process the post.
if($_POST && !$errors):

    if($equipment && $equipment->getId()) {
        //More coffee please.
        $errors=array();
        $lock = $equipment->getLock(); //Ticket lock if any
        switch(strtolower($_POST['a'])):
        case 'reply':
            $vars = $_POST;
            $vars['cannedattachments'] = $response_form->getField('attachments')->getClean();
            $vars['response'] = ThreadEntryBody::clean($vars['response']);
            if(!$vars['response'])
                $errors['response']=__('Response required');

            if ($cfg->getLockTime()) {
                if (!$lock) {
                    $errors['err'] = sprintf('%s %s', __('This action requires a lock.'), __('Please try again!'));
                }
                // Use locks to avoid double replies
                elseif ($lock->getStaffId()!=$thisstaff->getId()) {
                    $errors['err'] = __('Action Denied. Equipment is locked by someone else!');
                }
                // Attempt to renew the lock if possible
                elseif (($lock->isExpired() && !$lock->renew())
                    ||($lock->getCode() != $_POST['lockCode'])
                ) {
                    $errors['err'] = sprintf('%s %s', __('Your lock has expired.'), __('Please try again!'));
                }
            }

            if(!$errors && ($response=$equipment->postReply($vars, $errors, $_POST['emailreply']))) {
                $msg = sprintf(__('%s: Reply posted successfully'),
                        sprintf(__('Equipment #%s'),
                            sprintf('<a href="tickets.php?id=%d"><b>%s</b></a>',
                                $equipment->getId(), $equipment->getName()))
                        );

                // Clear attachment list
                $response_form->setSource(array());
                $response_form->getField('attachments')->reset();

                // Remove staff's locks
                $equipment->releaseLock($thisstaff->getId());

                // Cleanup response draft for this user
                Draft::deleteForNamespace(
                    'equipment.response.' . $equipment->getId(),
                    $thisstaff->getId());

                // Go back to the ticket listing page on reply
                $equipment = null;
                $redirect = 'tickets.php';

            } elseif(!$errors['err']) {
                $errors['err']=sprintf('%s %s',
                    __('Unable to post the reply.'),
                    __('Correct any errors below and try again.'));
            }
            break;
        case 'postnote': /* Post Internal Note */
            $vars = $_POST;
            $attachments = $note_form->getField('attachments')->getClean();
            $vars['cannedattachments'] = array_merge(
                $vars['cannedattachments'] ?: array(), $attachments);
            $vars['note'] = ThreadEntryBody::clean($vars['note']);

            if ($cfg->getLockTime()) {
                if (!$lock) {
                    $errors['err'] = sprintf('%s %s', __('This action requires a lock.'), __('Please try again!'));
                }
                // Use locks to avoid double replies
                elseif ($lock->getStaffId()!=$thisstaff->getId()) {
                    $errors['err'] = __('Action Denied. Equipment is locked by someone else!');
                }
                elseif ($lock->getCode() != $_POST['lockCode']) {
                    $errors['err'] = sprintf('%s %s', __('Your lock has expired.'), __('Please try again!'));
                }
            }

            $wasNew = ($equipment->isNew());
            if(($note=$equipment->postNote($vars, $errors, $thisstaff))) {

                $msg=__('Internal note posted successfully');
                // Clear attachment list
                $note_form->setSource(array());
                $note_form->getField('attachments')->reset();

                // Remove staff's locks
                $equipment->releaseLock($thisstaff->getId());

                if($wasNew && $equipment->isRetired())
                    $equipment = null; //Going back to main listing.
                else
                    // Equipment is still open -- clear draft for the note
                    Draft::deleteForNamespace('equipment.note.'.$equipment->getId(),
                        $thisstaff->getId());

                 $redirect = 'equipment.php';
            } else {

                if(!$errors['err'])
                    $errors['err'] = __('Unable to post internal note - missing or invalid data.');

                $errors['postnote'] = sprintf('%s %s',
                    __('Unable to post the note.'),
                    __('Correct any errors below and try again.'));
            }
            break;
        case 'edit':
        case 'update':
            if(!$ticket || !$role->hasPerm(TicketModel::PERM_EDIT))
                $errors['err']=__('Permission Denied. You are not allowed to edit tickets');
            elseif($ticket->update($_POST,$errors)) {
                $msg=__('Ticket updated successfully');
                $redirect = 'tickets.php?id='.$ticket->getId();
                $_REQUEST['a'] = null; //Clear edit action - going back to view.
                //Check to make sure the staff STILL has access post-update (e.g dept change).
                if(!$ticket->checkStaffPerm($thisstaff))
                    $ticket=null;
            } elseif(!$errors['err']) {
                $errors['err']=sprintf('%s %s',
                    sprintf(__('Unable to update %s.'), __('this ticket')),
                    __('Correct any errors below and try again.')
                );
            }
            break;
        case 'process':
            switch(strtolower($_POST['do'])):
                case 'release':
                    if(!$ticket->isAssigned() || !($assigned=$ticket->getAssigned())) {
                        $errors['err'] = __('Ticket is not assigned!');
                    } elseif($ticket->release()) {
                        $msg=sprintf(__(
                            /* 1$ is the current assignee, 2$ is the agent removing the assignment */
                            'Ticket released (unassigned) from %1$s by %2$s'),
                            $assigned, $thisstaff->getName());
                        $ticket->logActivity(__('Ticket unassigned'),$msg);
                    } else {
                        $errors['err'] = sprintf('%s %s', __('Problems releasing the ticket.'), __('Please try again!'));
                    }
                    break;
                case 'answered':
                    $dept = $ticket->getDept();
                    if(!$dept || !$dept->isManager($thisstaff)) {
                        $errors['err']=__('Permission Denied. You are not allowed to flag tickets');
                    } elseif($ticket->markAnswered()) {
                        $msg=sprintf(__('Ticket flagged as answered by %s'),$thisstaff->getName());
                        $ticket->logActivity(__('Ticket Marked Answered'),$msg);
                    } else {
                        $errors['err']=sprintf('%s %s', __('Problems marking the ticket answered.'), __('Please try again!'));
                    }
                    break;
                case 'unanswered':
                    $dept = $ticket->getDept();
                    if(!$dept || !$dept->isManager($thisstaff)) {
                        $errors['err']=__('Permission Denied. You are not allowed to flag tickets');
                    } elseif($ticket->markUnAnswered()) {
                        $msg=sprintf(__('Ticket flagged as unanswered by %s'),$thisstaff->getName());
                        $ticket->logActivity(__('Ticket Marked Unanswered'),$msg);
                    } else {
                        $errors['err']=sprintf('%s %s', __('Problems marking the ticket unanswered.'), __('Please try again!'));
                    }
                    break;
                case 'changeuser':
                    if (!$role->hasPerm(TicketModel::PERM_EDIT)) {
                        $errors['err']=__('Permission Denied. You are not allowed to edit tickets');
                    } elseif (!$_POST['user_id'] || !($user=User::lookup($_POST['user_id']))) {
                        $errors['err'] = __('Unknown user selected');
                    } elseif ($ticket->changeOwner($user)) {
                        $msg = sprintf(__('Ticket ownership changed to %s'),
                            Format::htmlchars($user->getName()));
                    } else {
                        $errors['err'] = sprintf('%s %s', __('Unable to change ticket ownership.'), __('Please try again!'));
                    }
                    break;
                default:
                    $errors['err']=__('You must select action to perform');
            endswitch;
            break;
        default:
            $errors['err']=__('Unknown action');
        endswitch;
    }elseif($_POST['a']) {

        switch($_POST['a']) {
            case 'open':
                $equipment=null;
                if (!$thisstaff) {
                     $errors['err'] = sprintf('%s %s',
                             sprintf(__('You do not have permission %s'),
                                 __('to create tickets')),
                             __('Contact admin for such access'));
                } else {
                    $vars = $_POST;

                    $vars['cannedattachments'] = $response_form->getField('attachments')->getClean();

                    if(($equipment=Equipment::open($vars, $errors))) {
                        $msg=__('Equipamiento añadido correctamente');
                        $_REQUEST['a']=null;
                        Draft::deleteForNamespace('equipment.staff%', $thisstaff->getId());
                        // Drop files from the response attachments widget
                        $response_form->setSource(array());
                        $response_form->getField('attachments')->reset();
                        unset($_SESSION[':form-data']);
                    } elseif(!$errors['err']) {
                        $errors['err']=sprintf('%s %s',
                            __('No se puede añadir el equipamiento.'),
                            __('Correct any errors below and try again.'));
                    }
                }
                break;
        }
    }
    if(!$errors)
        $thisstaff ->resetStats(); //We'll need to reflect any changes just made!
endif;

if ($redirect) {
    if ($msg)
        Messages::success($msg);
    Http::redirect($redirect);
}

/*... Quick stats ...*/
$stats= $thisstaff->getEquipmentStats();

// Clear advanced search upon request
if (isset($_GET['clear_filter']))
    unset($_SESSION['advsearch']);

//Navigation
$nav->setTabActive('equipment');
$open_name = _P('queue-name',
    /* This is the name of the open ticket queue */
    'Open');

if($stats['new']) {
    $nav->addSubMenu(array('desc'=>__('Nuevo').' ('.number_format($stats['new']).')',
                           'title'=>__('Equipamiento adquirido recientemente'),
                           'href'=>'equipment.php?status=new',
                           'iconclass'=>'assignedTickets'),
                        ($_REQUEST['status']=='new'));
}

//if($stats['available']) {
    $nav->addSubMenu(array('desc'=>__('Operativo').' ('.number_format($stats['available']).')',
                            'title'=>__('Equipamiento en funcionamiento'),
                            'href'=>'equipment.php?status=available',
                            'iconclass'=>'Ticket'),
                         (!$_REQUEST['status'] && !isset($_SESSION['advsearch'])) 
                            || ($_REQUEST['status']=='available')
                            || ($_REQUEST['status']=='open'));
//}

if($stats['inactive']) {
    $nav->addSubMenu(array('desc'=>__('Mantenimiento').' ('.number_format($stats['inactive']).')',
                            'title'=>__('Equipamiento en mantenimiento'),
                            'href'=>'equipment.php?status=inactive',
                            'iconclass'=>'Ticket'),
                         ($_REQUEST['status']=='inactive'));
}

if($stats['reserved']) {
    $nav->addSubMenu(array('desc'=>__('Mis reservas').' ('.number_format($stats['reserved']).')',
                           'title'=>__('Equipamiento reservado'),
                           'href'=>'equipment.php?status=reserved',
                           'iconclass'=>'assignedTickets'),
                        ($_REQUEST['status']=='reserved'));
}

if (isset($_SESSION['advsearch'])) {
    // XXX: De-duplicate and simplify this code
//    TicketForm::ensureDynamicDataView();
//    $search = SavedSearch::create();
//    $form = $search->getFormFromSession('advsearch');
//    $tickets = TicketModel::objects();
//    $tickets = $search->mangleQuerySet($tickets, $form);
//    $count = $tickets->count();
//    $nav->addSubMenu(array('desc' => __('Search').' ('.number_format($count).')',
//                           'title'=>__('Advanced Ticket Search'),
//                           'href'=>'tickets.php?status=search',
//                           'iconclass'=>'Ticket'),
//                        (!$_REQUEST['status'] || $_REQUEST['status']=='search'));
}

if($stats['retired']) {
    $nav->addSubMenu(array('desc'=>__('Retirado').' ('.number_format($stats['retired']).')',
                           'title'=>__('Equipamiento Retirado'),
                           'href'=>'equipment.php?status=retired',
                           'iconclass'=>'assignedTickets'),
                        ($_REQUEST['status']=='retired'));
}

$nav->addSubMenu(array('desc'=>__('Nuevo equipamiento'),
                        'title'=> __('Añadir equipamiento'),
                        'href'=>'equipment.php?a=open',
                        'iconclass'=>'newTicket',
                        'id' => 'new-equipment'),
                     ($_REQUEST['a']=='open'));

$ost->addExtraHeader('<script type="text/javascript" src="js/equipment.js?d2ef3b1"></script>');
$ost->addExtraHeader('<script type="text/javascript" src="js/thread.js?d2ef3b1"></script>');
$ost->addExtraHeader('<meta name="tip-namespace" content="equipment.queue" />',
    "$('#content').data('tipNamespace', 'equipment.queue');");

if($equipment) {
    $ost->setPageTitle(sprintf(__('#%s'),$equipment->getName()));
    $nav->setActiveSubMenu(-1);
    $inc = 'equipment-view.inc.php';
    if($_REQUEST['a'] == 'print' && !$ticket->pdfExport($_REQUEST['psize'], $_REQUEST['notes']))
        $errors['err'] = __('Unable to export the ticket to PDF for print.')
            .' '.__('Internal error occurred');
} else {
    $inc = 'equipments.inc.php';
    if ($_REQUEST['a']=='open')
        $inc = 'equipment-open.inc.php';
    elseif($_REQUEST['a'] == 'export') {
        $ts = strftime('%Y%m%d');
        if (!($query=$_SESSION[':Q:tickets']))
            $errors['err'] = __('Query token not found');
        elseif (!Export::saveTickets($query, "tickets-$ts.csv", 'csv'))
            $errors['err'] = __('Unable to dump query results.')
                .' '.__('Internal error occurred');
    }

    //Clear active submenu on search with no status
    if($_REQUEST['a']=='search' && !$_REQUEST['status'])
        $nav->setActiveSubMenu(-1);

    //set refresh rate if the user has it configured
    if(!$_POST && !$_REQUEST['a'] && ($min=(int)$thisstaff->getRefreshRate())) {
        $js = "+function(){ var qq = setInterval(function() { if ($.refreshEquipmentView === undefined) return; clearInterval(qq); $.refreshEquipmentView({$min}*60000); }, 200); }();";
        $ost->addExtraHeader('<script type="text/javascript">'.$js.'</script>',
            $js);
    }
}

require_once(STAFFINC_DIR.'header.inc.php');
require_once(STAFFINC_DIR.$inc);
print $response_form->getMedia();
require_once(STAFFINC_DIR.'footer.inc.php');
