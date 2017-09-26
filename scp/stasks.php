<?php
/*************************************************************************
    stasks.php

    Copyright (c)  2006-2013 osTicket
    http://www.osticket.com

    Released under the GNU General Public License WITHOUT ANY WARRANTY.
    See LICENSE.TXT for details.

    vim: expandtab sw=4 ts=4 sts=4:
**********************************************************************/

require('staff.inc.php');
require_once(INCLUDE_DIR.'class.task.php');
require_once(INCLUDE_DIR.'class.task_schedule.php');
require_once(INCLUDE_DIR.'class.export.php');

$page = '';
$task = null; //clean start.
if ($_REQUEST['id']) {
    if (!($task=TaskSchedule::lookup($_REQUEST['id'])))
         $errors['err'] = sprintf(__('%s: Unknown or invalid ID.'), __('Programación de tareas'));
    elseif (!$task->checkStaffPerm($thisstaff)) {
        $errors['err'] = __('Access denied. Contact admin if you believe this is in error');
        $task = null;
    }
}

// Configure form for file uploads
$note_attachments_form = new SimpleForm(array(
    'attachments' => new FileUploadField(array('id'=>'attach',
        'name'=>'attach:note',
        'configuration' => array('extensions'=>'')))
));

//At this stage we know the access status. we can process the post.
if($_POST && !$errors):

    if ($task) {
        //More coffee please.
        $errors=array();
        $role = $thisstaff->getRole($task->getDeptId());
        switch(strtolower($_POST['a'])):
        case 'postnote': /* Post Internal Note */
            $vars = $_POST;
            $attachments = $note_attachments_form->getField('attachments')->getClean();
            $vars['cannedattachments'] = array_merge(
                $vars['cannedattachments'] ?: array(), $attachments);

            if(($note=$task->postNote($vars, $errors, $thisstaff))) {

                $msg=__('Internal note posted successfully');
                // Clear attachment list
                $note_attachments_form->setSource(array());
                $note_attachments_form->getField('attachments')->reset();

                // Task is still open -- clear draft for the note
                Draft::deleteForNamespace('schedule.note.'.$task->getId(),
                    $thisstaff->getId());

            } else {
                if(!$errors['err'])
                    $errors['err'] = __('Unable to post internal note - missing or invalid data.');

                $errors['postnote'] = sprintf('%s %s',
                    __('Unable to post the note.'),
                    __('Correct any errors below and try again.'));
            }
            break;
        default:
            $errors['err']=__('Unknown action');
        endswitch;
    }
    if(!$errors)
        $thisstaff->resetStats(); //We'll need to reflect any changes just made!
endif;

/*... Quick stats ...*/
$stats= $thisstaff->getTasksStats();

// Clear advanced search upon request
if (isset($_GET['clear_filter']))
    unset($_SESSION['advsearch:tasks']);


if (!$task) {
    $queue_key = sprintf('::Q:%s', ObjectModel::OBJECT_TYPE_TASK);
    $queue_name = strtolower($_GET['status'] ?: $_GET['a']);
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

//Navigation
$nav->setTabActive('tasks');
$open_name = _P('queue-name',
    /* This is the name of the open tasks queue */
    'Open');

$nav->addSubMenu(array('desc'=>$open_name.' ('.number_format($stats['open']).')',
                       'title'=>__('Open Tasks'),
                       'href'=>'tasks.php?status=open',
                       'iconclass'=>'Ticket'),
                    false);

if ($stats['assigned']) {

    $nav->addSubMenu(array('desc'=>__('My Tasks').' ('.number_format($stats['assigned']).')',
                           'title'=>__('Assigned Tasks'),
                           'href'=>'tasks.php?status=assigned',
                           'iconclass'=>'assignedTickets'),
                        false);
}

if ($stats['overdue']) {
    $nav->addSubMenu(array('desc'=>__('Overdue').' ('.number_format($stats['overdue']).')',
                           'title'=>__('Stale Tasks'),
                           'href'=>'tasks.php?status=overdue',
                           'iconclass'=>'overdueTickets'),
                        false);

    if(!$sysnotice && $stats['overdue']>10)
        $sysnotice=sprintf(__('%d overdue tasks!'), $stats['overdue']);
}

if ($stats['closed']) {
    $nav->addSubMenu(array('desc' => __('Completed').' ('.number_format($stats['closed']).')',
                           'title'=>__('Completed Tasks'),
                           'href'=>'tasks.php?status=closed',
                           'iconclass'=>'closedTickets'),
                        false);
}

if ($thisstaff->hasPerm(TaskScheduleModel::PERM_CREATE, false)) {
    $nav->addSubMenu(array('desc'=>__('Programación'),
                           'title'=>__('Programación de tareas'),
                           'href'=>'stasks.php',
                           'iconclass'=>'assignedTickets'),
                            true);
}

$ost->addExtraHeader('<script type="text/javascript" src="js/ticket.js?d2ef3b1"></script>');
$ost->addExtraHeader('<script type="text/javascript" src="js/thread.js?d2ef3b1"></script>');
$ost->addExtraHeader('<meta name="tip-namespace" content="schedule.queue" />',
    "$('#content').data('tipNamespace', 'schedule.queue');");

if($task) {
    $ost->setPageTitle(sprintf(__('Programación de tareas #%s'),str_pad($task->id, 6, "0", STR_PAD_LEFT)));
    $nav->setActiveSubMenu(-1);
    $inc = 'scheduled-task-view.inc.php';
    if ($_REQUEST['a']=='edit'
            && $task->checkStaffPerm($thisstaff, TaskModel::PERM_EDIT)) {
        $inc = 'task-edit.inc.php';
        if (!$forms) $forms=DynamicFormEntry::forObject($task->getId(), 'A');
        // Auto add new fields to the entries
        foreach ($forms as $f) $f->addMissingFields();
    } elseif($_REQUEST['a'] == 'print' && !$task->pdfExport($_REQUEST['psize']))
        $errors['err'] = __('Unable to print to PDF.')
            .' '.__('Internal error occurred');
} else {
    $inc = 'scheduled-tasks.inc.php';
    if ($_REQUEST['a']=='open' &&
            $thisstaff->hasPerm(Task::PERM_CREATE, false))
        $inc = 'task-open.inc.php';
    elseif($_REQUEST['a'] == 'export') {
        $ts = strftime('%Y%m%d');
        if (!($query=$_SESSION[':Q:tasks']))
            $errors['err'] = __('Query token not found');
        elseif (!Export::saveTasks($query, "tasks-$ts.csv", 'csv'))
            $errors['err'] = __('Unable to dump query results.')
                .' '.__('Internal error occurred');
    }

    //Clear active submenu on search with no status
    if($_REQUEST['a']=='search' && !$_REQUEST['status'])
        $nav->setActiveSubMenu(-1);

    //set refresh rate if the user has it configured
    if(!$_POST && !$_REQUEST['a'] && ($min=$thisstaff->getRefreshRate())) {
        $js = "clearTimeout(window.task_refresh);
               window.task_refresh = setTimeout($.refreshTaskView,"
            .($min*60000).");";
        $ost->addExtraHeader('<script type="text/javascript">'.$js.'</script>',
            $js);
    }
}

require_once(STAFFINC_DIR.'header.inc.php');
require_once(STAFFINC_DIR.$inc);
require_once(STAFFINC_DIR.'footer.inc.php');
