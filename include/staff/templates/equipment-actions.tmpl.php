<?php
// Equipment mass actions

echo EquipmentStatus::status_options($options);

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
