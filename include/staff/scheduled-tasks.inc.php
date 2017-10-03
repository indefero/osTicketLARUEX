<?php
global $thisstaff, $cfg;

$schedules = TaskSchedule::objects()->order_by('start');

$count = $schedules->count();
$pageNav = new Pagenate($count,1, 100000); //TODO: support ajax based pages
$showing = $pageNav->showing().' '._N('item', 'items', $count);

?>
<div id="task_schedule_content" style="display:block;">
<div class="pull-left">
   <?php
    if ($count) {
        echo '<strong>'.$showing.'</strong>';
    } else {
        echo sprintf('No hay ninguna programación de tareas');
    }
   ?>
</div>
<div class="pull-right">
    <a class="green button action-button task-schedule-action"
            data-url="tasks.php?#reservations"
            data-dialog-config='{"size":"large"}'
            href="#tasks/add-schedule">
        <i class="icon-plus-sign"></i> <?php
        print 'Nueva programación'; ?></a>
    <?php
    if ($count)
        TaskSchedule::getAgentActions($thisstaff, array(
                    'container' => '#task_schedule_content',
                    'callback_url' => sprintf('ajax.php/tasks/schedules'),
                    'morelabel' => __('Options')));
    ?>
</div>
<div class="clear"></div>
<div>
<?php
if ($count) { ?>
<form action="#tasks/schedules" method="POST"
    name='schedules' id="schedules" style="padding-top:7px;">
<?php csrf_token(); ?>
 <input type="hidden" name="a" value="mass_process" >
 <input type="hidden" name="do" id="action" value="" >
 <table class="list" border="0" cellspacing="1" cellpadding="2" width="940">
    <thead>
        <tr>
            <?php
            if (1) {?>
            <th width="8px">&nbsp;</th>
            <?php
            } ?>
            <th width="40"><?php echo __('Number'); ?></th>
            <th width="300"><?php echo __('Title'); ?></th>
            <th width="70"><?php echo 'Periodicidad'; ?></th>
            <th width="70"><?php echo __('Inicio'); ?></th>
            <th width="70"><?php echo __('Created'); ?></th>
        </tr>
    </thead>
    <tbody class="reservations">
    <?php
    foreach($schedules as $schedule) {
        $id = $schedule->getId();
        ?>
        <tr id="<?php echo $id; ?>">
            <td class="nohover">
                <input class="ckb" type="checkbox" name="tids[]"
                       value="<?php echo $id; ?>" <?php echo $sel?'checked="checked"':''; ?>>
            </td>
            <td nowrap>
                <a class="preview"
                   href="stasks.php?id=<?php echo $id; ?>"
                    data-preview="#task-schedule/<?php echo $id; ?>/preview"
                ><?php echo sprintf('<b>%s</b>', str_pad($id, 6, "0", STR_PAD_LEFT)); ?></a>
            </td>
            <td nowrap>
                <a href="stasks.php?id=<?php echo $id; ?>"><?php echo $schedule->getTitle(); ?></a>
            </td>
            <td nowrap><?php echo $schedule->regularity; ?></td>
            <td nowrap><?php echo
            Format::datetime($schedule->start); ?></td>
            <td nowrap><?php echo
            Format::datetime($schedule->created); ?></td>
        </tr>
   <?php
    }
    ?>
    </tbody>
</table>
</form>
<?php
 } ?>
</div>
</div>
<div id="schedule_content" style="display:none;">
</div>
<script type="text/javascript">
$(function() {
    
    $(document).off('click.taskv');
    $(document).on('click.taskv', 'tbody.tasks a, a#reload-task', function(e) {
        e.preventDefault();
        e.stopImmediatePropagation();
        if ($(this).attr('href').length > 1) {
            var url = 'ajax.php/'+$(this).attr('href').substr(1);
            var $container = $('div#schedule_content');
            var $stop = $('ul#ticket_tabs').offset().top;
            $.pjax({url: url, container: $container, push: false, scrollTo: $stop})
            .done(
                function() {
                $container.show();
                $('.tip_box').remove();
                $('div#task_schedule_content').hide();
                });
        } else {
            $(this).trigger('mouseenter');
        }

        return false;
     });
    
    // Scheduled tasks
    $(document).off('.task-schedule-action');
    $(document).on('click.task-schedule-action', 'a.task-schedule-action', function(e) {
        e.preventDefault();
        var url = 'ajax.php/'
        +$(this).attr('href').substr(1)
        +'?_uid='+new Date().getTime();
        var $redirect = $(this).data('href');
        var $options = $(this).data('dialogConfig');
        $.dialog(url, [201], function (xhr) {
            var tid = parseInt(xhr.responseText);
            if (tid) {
                var url = 'ajax.php/tasks/schedules';
                var $container = $('div#schedule_content');
                $container.load(url+'/schedules', function () {
                    $.pjax({url: url, container: '#task_schedule_content', push: false});
                }).show();
            } else {
                window.location.href = $redirect ? $redirect : window.location.href;
            }
        }, $options);
        return false;
    });
});
</script>
