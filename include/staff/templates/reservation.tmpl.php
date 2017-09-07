<?php

if (!$info['title'])
    $info['title'] = __('Nueva Reserva');

$namespace = 'reservation.add';
if ($equipment)
    $namespace = sprintf('equipment.%d.reservation', $equipment->getId());

?>
<div id="reservation-form">
<h3 class="drag-handle"><?php echo $info['title']; ?></h3>
<b><a class="close" href="#"><i class="icon-remove-circle"></i></a></b>
<hr/>
<?php

if ($info['error']) {
    echo sprintf('<p id="msg_error">%s</p>', $info['error']);
} elseif ($info['warning']) {
    echo sprintf('<p id="msg_warning">%s</p>', $info['warning']);
} elseif ($info['msg']) {
    echo sprintf('<p id="msg_notice">%s</p>', $info['msg']);
} ?>
<div id="new-reservation-form" style="display:block;">
<form method="post" class="org" action="<?php echo $info['action'] ?: '#reservations/add'; ?>">
    <?php
        $form = $form ?: ReservationForm::getInstance();
        echo $form->getForm()->asTable(' ',
                array('draft-namespace' => $namespace)
                );

        $iform = $iform ?: ReservationForm::getInternalForm();
        echo $iform->asTable(__("Detalles de la reserva"));
?>
    <hr>
    <p class="full-width">
        <span class="buttons pull-left">
            <input type="reset" value="<?php echo __('Reset'); ?>">
            <input type="button" name="cancel" class="close"
                value="<?php echo __('Cancel'); ?>">
        </span>
        <span class="buttons pull-right">
            <input type="submit" value="<?php echo __('Reservar'); ?>">
        </span>
     </p>
</form>
</div>
<div class="clear"></div>
</div>
