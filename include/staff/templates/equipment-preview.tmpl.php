<?php
/*
 * Equipment Preview popup template
 *
 */

$lock=$equipment->getLock();
$role=$thisstaff->getRole($equipment->getDeptId());
$error=$msg=$warn=null;
$thread = $equipment->getThread();

if($lock && $lock->getStaffId()==$thisstaff->getId())
    $warn.='&nbsp;<span class="Icon lockedTicket">'
    .sprintf(__('Equipment is locked by %s'), $lock->getStaffName()).'</span>';

echo sprintf(
        '<div style="width:600px; padding: 2px 2px 0 5px;" id="t%s">
         <h2>Equipamiento #%s: %s</h2>',
         $equipment->getId(),
         str_pad($equipment->getId(), 6, "0", STR_PAD_LEFT),
         Format::htmlchars($equipment->getName()));

if($error)
    echo sprintf('<div id="msg_error">%s</div>',$error);
elseif($msg)
    echo sprintf('<div id="msg_notice">%s</div>',$msg);
elseif($warn)
    echo sprintf('<div id="msg_warning">%s</div>',$warn);

echo '<ul class="tabs" id="equipment-preview">';

echo '
        <li class="active"><a id="preview_tab" href="#preview"
            ><i class="icon-list-alt"></i>&nbsp;Resumen Equipamiento</a></li>';

echo '</ul>';
echo '<div id="equipment-preview_container">';
echo '<div class="tab_content" id="preview">';
echo '<table border="0" cellspacing="" cellpadding="1" width="100%" class="ticket_info">';

$equipment_state=sprintf('<span>%s</span>',ucfirst($equipment->getStatus()));
echo sprintf('
        <tr>
            <th width="100">'.__('State').':</th>
            <td>%s</td>
        </tr>
        <tr>
            <th>'.__('Created').':</th>
            <td>%s</td>
        </tr>',$equipment_state,
        Format::datetime($equipment->getCreateDate()));
if($equipment->isActive()) {
    echo sprintf('
            <tr>
                <th>Activo desde:</th>
                <td>%s</td>
            </tr>',
            Format::datetime($equipment->getActivationDate())
            );
} elseif($equipment->getIsInactive()) {
    echo sprintf('
            <tr>
                <th>Inactivo desde:</th>
                <td>%s</td>
            </tr>',
            Format::datetime($equipment->getDeactivationDate()));
}
echo '</table>';


echo '<hr>
    <table border="0" cellspacing="" cellpadding="1" width="100%" class="ticket_info">';

echo sprintf(
    '
        <tr>
            <th width="100">'.__('Department').':</th>
            <td>%s</td>
        </tr>',
    Format::htmlchars($equipment->getDeptName()));

echo '
    </table>';
echo '</div>'; // ticket preview content.
?>
</div>
</div>
