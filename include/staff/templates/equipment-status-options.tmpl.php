<?php
global $thisstaff, $equipment;
// Map states to actions
$actions= array(
        'retired' => array(
            'icon'  => 'icon-minus-sign',
            'action' => 'retire',
            'href' => 'equipment.php'
            ),
        'inactive' => array(
            'icon'  => 'icon-warning-sign',
            'action' => 'deactivate',
            'href' => 'equipment.php'
            ),
        'active' => array(
            'icon'  => 'icon-ok-sign',
            'action' => 'activate'
            ),
        );

$statuses = EquipmentStatus::objects();

// Excluimos ciertas transiciones de estados en función del actual
// El propio estado
$excludedEquipmentStates[] = $options['status'];
// Nunca se puede volver al estado inicial
$excludedEquipmentStates[] = "new";
// El estado 'deleted' es un estado interno
$excludedEquipmentStates[] = "deleted";
switch ($options['status']) {
    case "new":
        $excludedEquipmentStates[] = "inactive";
        $excludedEquipmentStates[] = "retired";
        break;
    case "retired":
        $excludedEquipmentStates[] = "inactive";
        break;
}

if (!$thisstaff->getRole($options['dept_id'])->hasPerm(EquipmentModel::PERM_RETIRE)) {
    $excludedEquipmentStates[] = "retired";
}

$nextStatuses = array();
foreach ($statuses as $status) {
    if (in_array($status->ht['state'], $excludedEquipmentStates))
        continue;
    $nextStatuses[] = $status;
}

if (!$nextStatuses)
    return;
?>

<span
    class="action-button"
    data-dropdown="#action-dropdown-statuses" data-placement="bottom" data-toggle="tooltip" title="<?php echo __('Change Status'); ?>">
    <i class="icon-caret-down pull-right"></i>
    <a class="equipments-action"
        href="#statuses"><i
        class="icon-flag"></i></a>
</span>
<div id="action-dropdown-statuses"
    class="action-dropdown anchor-right">
    <ul>
<?php foreach ($nextStatuses as $status) { ?>
        <li>
            <a class="no-pjax <?php
                echo $equipment? 'equipment-action' : 'equipments-action'; ?>"
                href="<?php
                    echo sprintf('#%s/status/%s/%d',
                            $equipment ? ('equipments/'.$equipment->getId()) : 'equipments',
                            $actions[$status->ht['state']]['action'],
                            $status->ht['id']); ?>"
                <?php
                if (isset($actions[$status->ht['state']]['href']))
                    echo sprintf('data-redirect="%s"',
                            $actions[$status->ht['state']]['href']);

                ?>
                ><i class="<?php
                        echo $actions[$status->ht['state']]['icon'] ?: 'icon-tag';
                    ?>"></i> <?php
                        echo __($status->ht['name']); ?></a>
        </li>
    <?php
    } ?>
    </ul>
</div>
