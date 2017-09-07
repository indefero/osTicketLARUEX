<?php
global $thisstaff;

$reservations = EquipmentReservation::objects()
    ->order_by('start');

$reservations->filter(array(
            'equipment_id' => $equipment->getId()));

$count = $reservations->count();
$pageNav = new Pagenate($count,1, 100000); //TODO: support ajax based pages
$showing = $pageNav->showing().' '._N('item', 'items', $count);

?>
<div id="equipment_reservations_content" style="display:block;">
<div class="pull-left">
   <?php
    if ($count) {
        echo '<strong>'.$showing.'</strong>';
    } else {
        echo sprintf(__('%s no tiene ninguna reserva'), $equipment? 'Este equipamiento' :
                'System');
    }
   ?>
</div>
<div class="pull-right">
    <?php if ($equipment->isActive()) { ?>
        <a class="green button action-button equipment-reservation-action"
                data-url="equipment.php?id=<?php echo $equipment->getId(); ?>#reservations"
                data-dialog-config='{"size":"large"}'
                href="#equipments/<?php
            echo $equipment->getId(); ?>/add-reservation">
            <i class="icon-plus-sign"></i> <?php
            print __('Añadir nueva reserva'); ?></a>
    <?php
    }
    if ($count)
        EquipmentReservation::getAgentActions($thisstaff, array(
                    'container' => '#equipment_reservations_content',
                    'callback_url' => sprintf('ajax.php/equipments/%d/reservations',
                        $equipment->getId()),
                    'morelabel' => __('Options')));
    ?>
</div>
<div class="clear"></div>
<div>
<?php
if ($count) { ?>
<form action="#equipments/<?php echo $equipment->getId(); ?>/reservations" method="POST"
    name='reservations' id="reservations" style="padding-top:7px;">
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
            <th width="300"><?php echo __('Agente'); ?></th>
            <th width="70"><?php echo __('Inicio'); ?></th>
            <th width="70"><?php echo __('Fin'); ?></th>
        </tr>
    </thead>
    <tbody class="reservations">
    <?php
    foreach($reservations as $reservation) {
        $id = $reservation->getId();
        ?>
        <tr id="<?php echo $id; ?>">
            <td class="nohover">
                <input class="ckb" type="checkbox" name="tids[]"
                       value="<?php echo $id; ?>" <?php echo $sel?'checked="checked"':''; 
                            if ($reservation->getStaff()->getId() != $thisstaff->getId()) {
                                echo ' disabled=""'; 
                                echo 'title="La reserva no le pertenece"'; } 
                            ?>>
            </td>
            <td nowrap><?php echo $reservation->getStaff()->getName(); ?></td>
            <td nowrap><?php echo
            Format::datetime($reservation->start); ?></td>
            <td nowrap><?php echo
            Format::datetime($reservation->end); ?></td>
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
<div id="reservation_content" style="display:none;">
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

    $('#equipment-reservations-count').html(<?php echo $count; ?>);
});
</script>
