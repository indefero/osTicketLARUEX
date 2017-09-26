<?php
if (!defined('OSTSCPINC')
    || !$thisstaff || !$task
    || !($role = $thisstaff->getRole($task->getDeptId())))
    die('Invalid path');

global $cfg;

$id = $task->getId();
$dept = $task->getDept();
$thread = $task->getThread();

$actions = array();

if ($role->hasPerm(TaskSchedule::PERM_ASSIGN)) {

    if ($task->getStaffId() != $thisstaff->getId()
            && (!$dept->assignMembersOnly()
                || $dept->isMember($thisstaff))) {
        $actions += array(
                'claim' => array(
                    'href' => sprintf('#task-schedule/%d/claim', $task->getId()),
                    'icon' => 'icon-user',
                    'label' => __('Claim'),
                    'redirect' => 'stasks.php'
                ));
    }

    $actions += array(
            'assign/agents' => array(
                'href' => sprintf('#task-schedule/%d/assign/agents', $task->getId()),
                'icon' => 'icon-user',
                'label' => __('Assign to Agent'),
                'redirect' => 'stasks.php'
            ));
}

if ($role->hasPerm(TaskSchedule::PERM_TRANSFER)) {
    $actions += array(
            'transfer' => array(
                'href' => sprintf('#task-schedule/%d/transfer', $task->getId()),
                'icon' => 'icon-share',
                'label' => __('Transfer'),
                'redirect' => 'stasks.php'
            ));
}

$actions += array(
        'print' => array(
            'href' => sprintf('stasks.php?id=%d&a=print', $task->getId()),
            'class' => 'no-pjax',
            'icon' => 'icon-print',
            'label' => __('Print')
        ));

if ($role->hasPerm(TaskSchedule::PERM_EDIT)) {
    $actions += array(
            'edit' => array(
                'href' => sprintf('#task-schedule/%d/edit', $task->getId()),
                'icon' => 'icon-edit',
                'dialog' => '{"size":"large"}',
                'label' => __('Edit')
            ));
}

if ($role->hasPerm(TaskSchedule::PERM_DELETE)) {
    $actions += array(
            'delete' => array(
                'href' => sprintf('#task-schedule/%d/delete', $task->getId()),
                'icon' => 'icon-trash',
                'class' => 'red button',
                'label' => __('Delete'),
                'redirect' => 'stasks.php'
            ));
}

$info=($_POST && $errors)?Format::input($_POST):array();

?>
<div>
    <div class="sticky bar">
       <div class="content">
        <div class="pull-left flush-left">
            <h2>
            <a  id="reload-task"
                href="stasks.php?id=<?php echo $task->getId(); ?>"><i
                class="icon-refresh"></i>&nbsp;<?php
                echo sprintf('Programación de tareas #%s', str_pad($task->getId(), 6, "0", STR_PAD_LEFT)); ?></a>
            </h2>
        </div>
        <div class="flush-right">
            <?php
            // Assign
            unset($actions['claim'], $actions['assign/agents'], $actions['assign/teams']);
            if ($role->hasPerm(TaskSchedule::PERM_ASSIGN)) {?>
            <span class="action-button"
                data-dropdown="#action-dropdown-assign"
                data-placement="bottom"
                data-toggle="tooltip"
                title=" <?php echo $task->isAssigned() ? __('Reassign') : __('Assign'); ?>"
                >
                <i class="icon-caret-down pull-right"></i>
                <a class="task-action" id="task-assign"
                    data-redirect="stasks.php"
                    href="#task-schedule/<?php echo $task->getId(); ?>/assign"><i class="icon-user"></i></a>
            </span>
            <div id="action-dropdown-assign" class="action-dropdown anchor-right">
              <ul>
                <?php
                // Agent can claim team assigned ticket
                if ($task->getStaffId() != $thisstaff->getId()
                        && (!$dept->assignMembersOnly()
                            || $dept->isMember($thisstaff))
                        ) { ?>
                 <li><a class="no-pjax task-action"
                    data-redirect="stasks.php"
                    href="#task-schedule/<?php echo $task->getId(); ?>/claim"><i
                    class="icon-chevron-sign-down"></i> <?php echo __('Claim'); ?></a>
                <?php
                } ?>
                 <li><a class="no-pjax task-action"
                    data-redirect="stasks.php"
                    href="#task-schedule/<?php echo $task->getId(); ?>/assign/agents"><i
                    class="icon-user"></i> <?php echo __('Agent'); ?></a>
              </ul>
            </div>
            <?php
            } ?>
            <?php
            foreach ($actions as $action) {?>
            <span class="action-button <?php echo $action['class'] ?: ''; ?>">
                <a class="task-action"
                    <?php
                    if ($action['dialog'])
                        echo sprintf("data-dialog-config='%s'", $action['dialog']);
                    if ($action['redirect'])
                        echo sprintf("data-redirect='%s'", $action['redirect']);
                    ?>
                    href="<?php echo $action['href']; ?>"
                    data-placement="bottom"
                    data-toggle="tooltip"
                    title="<?php echo $action['label']; ?>">
                    <i class="<?php
                    echo $action['icon'] ?: 'icon-tag'; ?>"></i>
                </a>
            </span>
            <?php
                }
            ?>
        </div>
    </div>
   </div>
</div>

<div class="clear tixTitle has_bottom_border">
    <h3>
    <?php
        $title = TaskScheduleForm::getInstance()->getField('title');
        echo $title->display($task->getTitle());
    ?>
    </h3>
</div>
<table class="ticket_info" cellspacing="0" cellpadding="0" width="940" border="0">
    <tr>
        <td width="50%">
            <table border="0" cellspacing="" cellpadding="4" width="100%">
                <tr>
                    <th><?php echo 'Periodicidad';?>:</th>
                    <td><?php echo $task->regularity; ?></td>
                </tr>
                <tr>
                    <th><?php echo 'Tiempo de resolución';?>:</th>
                    <td><?php echo $task->period." días"; ?></td>
                </tr>
                <?php if ($task->last_created_task) { ?>
                    <tr>
                        <th><?php echo 'Última tarea creada';?>:</th>
                        <td><?php echo Format::datetime($task->last_created_task); ?></td>
                    </tr>
                <?php } ?>
                <tr>
                    <th><?php echo 'Inicio (fecha creación de primera tarea)';?>:</th>
                    <td><?php echo Format::datetime($task->start); ?></td>
                </tr>
                <tr>
                    <th><?php echo __('Created');?>:</th>
                    <td><?php echo Format::datetime($task->getCreateDate()); ?></td>
                </tr>
            </table>
        </td>
        <td width="50%" style="vertical-align:top">
            <table cellspacing="0" cellpadding="4" width="100%" border="0">

                <tr>
                    <th><?php echo __('Department');?>:</th>
                    <td><?php echo Format::htmlchars($task->dept->getName()); ?></td>
                </tr>
                
                <tr>
                    <th width="100"><?php echo __('Assigned To');?>:</th>
                    <td>
                        <?php
                        if ($assigned=$task->getAssigned())
                            echo Format::htmlchars($assigned);
                        else
                            echo '<span class="faded">&mdash; '.__('Unassigned').' &mdash;</span>';
                        ?>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<br>
<br>
<table class="ticket_info" cellspacing="0" cellpadding="0" width="940" border="0">
<?php
$idx = 0;
foreach (DynamicFormEntry::forObject($task->getId(),
            ObjectModel::OBJECT_TYPE_TASK_SCHEDULE) as $form) {
    $answers = $form->getAnswers()->exclude(Q::any(array(
        'field__flags__hasbit' => DynamicFormField::FLAG_EXT_STORED,
        'field__name__in' => array('title')
    )));
    if (!$answers || count($answers) == 0)
        continue;

    ?>
        <tr>
        <td colspan="2">
            <table cellspacing="0" cellpadding="4" width="100%" border="0">
            <?php foreach($answers as $a) {
                if (!($v = $a->display())) continue; ?>
                <tr>
                    <th width="100"><?php
                        echo $a->getField()->get('label');
                    ?>:</th>
                    <td><?php
                        echo $v;
                    ?></td>
                </tr>
                <?php
            } ?>
            </table>
        </td>
        </tr>
    <?php
    $idx++;
} ?>
</table>
<div class="clear"></div>
<div id="task_thread_container">
    <div id="task_thread_content" class="tab_content">
     <?php
     $task->getThread()->render(array('M', 'R', 'N'),
             array(
                 'mode' => Thread::MODE_STAFF,
                 'container' => 'taskThread',
                 'sort' => $thisstaff->thread_view_order
                 )
             );
     ?>
   </div>
</div>
<div class="clear"></div>
<?php if($errors['err']) { ?>
    <div id="msg_error"><?php echo $errors['err']; ?></div>
<?php }elseif($msg) { ?>
    <div id="msg_notice"><?php echo $msg; ?></div>
<?php }elseif($warn) { ?>
    <div id="msg_warning"><?php echo $warn; ?></div>
<?php }

$action = 'stasks.php?id='.$task->getId();
?>
<div id="task_response_options" class="<?php echo $ticket ? 'ticket_task_actions' : ''; ?> sticky bar stop actions">
    <ul class="tabs">
        <?php
        if ($role->hasPerm(TaskScheduleModel::PERM_REPLY)) { ?>
        <li><a href="#task_note"><?php echo __('Post Internal Note');?></a></li>
        <?php
        }?>
    </ul>
    <?php
    if ($role->hasPerm(TaskScheduleModel::PERM_REPLY)) { ?>
    <form id="task_note"
        action="<?php echo $action; ?>"
        class="tab_content spellcheck save <?php
            echo $role->hasPerm(TaskScheduleModel::PERM_REPLY) ? 'hidden' : ''; ?>"
        name="task_note"
        method="post" enctype="multipart/form-data">
        <?php csrf_token(); ?>
        <input type="hidden" name="id" value="<?php echo $task->getId(); ?>">
        <input type="hidden" name="a" value="postnote">
        <table width="100%" border="0" cellspacing="0" cellpadding="3">
            <tr>
                <td>
                    <div><span class='error'><?php echo $errors['note']; ?></span></div>
                    <textarea name="note" id="task-note" cols="80"
                        placeholder="<?php echo __('Internal Note details'); ?>"
                        rows="9" wrap="soft" data-draft-namespace="task.note"
                        data-draft-object-id="<?php echo $task->getId(); ?>"
                        class="richtext ifhtml draft draft-delete"><?php
                        echo $info['note'];
                        ?></textarea>
                    <div class="attachments">
                    <?php
                        if ($note_attachments_form)
                            print $note_attachments_form->getField('attachments')->render();
                    ?>
                    </div>
                </td>
            </tr>
        </table>
       <p  style="text-align:center;">
           <input class="save pending" type="submit" value="<?php echo __('Post Note');?>">
           <input type="reset" value="<?php echo __('Reset');?>">
       </p>
    </form>
    <?php
    }?>
 </div>

<script type="text/javascript">
$(function() {
    $(document).off('.tasks-content');
    $(document).on('click.tasks-content', '#all-ticket-tasks', function(e) {
        e.preventDefault();
        $('div#task_content').hide().empty();
        $('div#tasks_content').show();
        return false;
     });

    $(document).off('.task-action');
    $(document).on('click.task-action', 'a.task-action', function(e) {
        e.preventDefault();
        var url = 'ajax.php/'
        +$(this).attr('href').substr(1)
        +'?_uid='+new Date().getTime();
        var $options = $(this).data('dialogConfig');
        var $redirect = $(this).data('redirect');
        $.dialog(url, [201], function (xhr) {
            if (!!$redirect)
                window.location.href = $redirect;
            else
                $.pjax.reload('#pjax-container');
        }, $options);

        return false;
    });

    $(document).off('.tf');
    $(document).on('submit.tf', '.ticket_task_actions form', function(e) {
        e.preventDefault();
        var $form = $(this);
        var $container = $('div#task_content');
        $.ajax({
            type:  $form.attr('method'),
            url: 'ajax.php/'+$form.attr('action').substr(1),
            data: $form.serialize(),
            cache: false,
            success: function(resp, status, xhr) {
                $container.html(resp);
                $('#msg_notice, #msg_error',$container)
                .delay(5000)
                .slideUp();
            }
        })
        .done(function() { })
        .fail(function() { });
     });
    <?php
    if ($ticket) { ?>
    $('#ticket-tasks-count').html(<?php echo $ticket->getNumTasks(); ?>);
   <?php
    } ?>
});
</script>
