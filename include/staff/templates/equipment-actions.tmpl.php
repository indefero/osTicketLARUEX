<?php
// Equipment mass actions

// Status change
if ($agent->canManageEquipment())
    echo EquipmentStatus::status_options($options);

// Mass Transfer
if ($agent->hasPerm(Equipment::PERM_TRANSFER, false)) {?>
<span class="action-button">
 <a class="equipments-action" id="equipments-transfer" data-placement="bottom"
    data-toggle="tooltip" title="<?php echo __('Transfer'); ?>"
    href="#equipments/mass/transfer"><i class="icon-share"></i></a>
</span>
<?php
}

// Mass Delete
if ($agent->hasPerm(Equipment::PERM_DELETE, false)) {?>
<span class="red button action-button">
 <a class="equipments-action" id="equipments-delete" data-placement="bottom"
    data-toggle="tooltip" title="<?php echo __('Delete'); ?>"
    href="#equipments/mass/delete"><i class="icon-trash"></i></a>
</span>
<?php
}

?>
<script type="text/javascript">
$(function() {

    $(document).off('.equipments');
    $(document).on('click.equipments', 'a.equipments-action', function(e) {
        e.preventDefault();
        var $form = $('form#equipments');
        var count = checkbox_checker($form, 1);
        if (count) {
            var tids = $('.ckb:checked', $form).map(function() {
                    return this.value;
                }).get();
            var url = 'ajax.php/'
            +$(this).attr('href').substr(1)
            +'?count='+count
            +'&tids='+tids.join(',')
            +'&_uid='+new Date().getTime();
            console.log(tids);
            $.dialog(url, [201], function (xhr) {
                $.pjax.reload('#pjax-container');
            });
        }
        return false;
    });
});
</script>
