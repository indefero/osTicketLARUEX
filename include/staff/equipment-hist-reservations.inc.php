<?php
global $thisstaff;

$count = 0;

$sql='SELECT start, end, staff_id FROM '.HIST_RESERVATION_TABLE.' T1 '
        .' WHERE equipment_id = '.$equipment->getId()
        .' ORDER BY start';
if ($res = db_query($sql)) {
    $count=db_num_rows($res);
}

$pageNav = new Pagenate($count,1, 100000); //TODO: support ajax based pages
$showing = $pageNav->showing().' '._N('item', 'items', $count);

?>
<div id="equipment_hist_reservations_content" style="display:block;">
<div class="pull-left">
   <?php
    if ($count) {
        echo '<strong>'.$showing.'</strong>';
    } else {
        echo sprintf(__('%s no tiene ninguna reserva archivada'), $equipment? 'Este equipamiento' :
                'System');
    }
   ?>
</div>
<div class="pull-right">
</div>
<div class="clear"></div>
<div>
<?php
if ($count) { ?>
 <table class="list" border="0" cellspacing="1" cellpadding="2" width="940">
    <thead>
        <tr>
            <th width="300"><?php echo __('Agente'); ?></th>
            <th width="70"><?php echo __('Inicio'); ?></th>
            <th width="70"><?php echo __('Fin'); ?></th>
        </tr>
    </thead>
    <tbody class="reservations">
    <?php
    while (list($start, $end, $staff_id) = db_fetch_row($res)) {
        ?>
        <tr>
            <td nowrap><?php if ($staff = Staff::lookup($staff_id)) echo $staff->getName(); ?></td>
            <td nowrap><?php echo
            Format::datetime($start); ?></td>
            <td nowrap><?php echo
            Format::datetime($end); ?></td>
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
<div id="hist_reservation_content" style="display:none;">
</div>
<script type="text/javascript">
$(function() {
    
    $(document).off('click.taskv');
    $(document).on('click.taskv', 'tbody.tasks a, a#reload-task', function(e) {
        e.preventDefault();
        e.stopImmediatePropagation();
        if ($(this).attr('href').length > 1) {
            var url = 'ajax.php/'+$(this).attr('href').substr(1);
            var $container = $('div#reservation_content');
            var $stop = $('ul#ticket_tabs').offset().top;
            $.pjax({url: url, container: $container, push: false, scrollTo: $stop})
            .done(
                function() {
                $container.show();
                $('.tip_box').remove();
                $('div#equipment_reservations_content').hide();
                });
        } else {
            $(this).trigger('mouseenter');
        }

        return false;
     });
    
    // Equipment Reservations
    $(document).off('.equipment-reservation-action');
    $(document).on('click.equipment-reservation-action', 'a.equipment-reservation-action', function(e) {
        e.preventDefault();
        var url = 'ajax.php/'
        +$(this).attr('href').substr(1)
        +'?_uid='+new Date().getTime();
        var $redirect = $(this).data('href');
        var $options = $(this).data('dialogConfig');
        $.dialog(url, [201], function (xhr) {
            var tid = parseInt(xhr.responseText);
            if (tid) {
                var url = 'ajax.php/equipments/'+<?php echo $equipment->getId();
                ?>+'/reservations';
                var $container = $('div#reservation_content');
                $container.load(url+'/reservations', function () {
                    $.pjax({url: url, container: '#equipment_reservations_content', push: false});
                }).show();
            } else {
                window.location.href = $redirect ? $redirect : window.location.href;
            }
        }, $options);
        return false;
    });

    $('#equipment-hist-reservations-count').html(<?php echo $count; ?>);
});
</script>
