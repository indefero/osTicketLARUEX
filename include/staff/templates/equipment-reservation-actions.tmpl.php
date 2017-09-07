<?php
// Reservations' mass actions based on logged in agent

$actions = array();

$actions += array(
        'delete' => array(
            'class' => 'danger',
            'icon' => 'icon-trash',
            'action' => __('Delete')
        ));

if ($actions && !isset($options['status'])) {
    $more = $options['morelabel'] ?: __('More');
    ?>
    <span
        class="action-button"
        data-dropdown="#action-dropdown-moreoptions">
        <i class="icon-caret-down pull-right"></i>
        <a class="reservations-action"
            href="#moreoptions"><i
            class="icon-reorder"></i> <?php
            echo $more; ?></a>
    </span>
    <div id="action-dropdown-moreoptions"
        class="action-dropdown anchor-right">
        <ul>
    <?php foreach ($actions as $a => $action) { ?>
            <li <?php
                if ($action['class'])
                    echo sprintf("class='%s'", $action['class']); ?> >
                <a class="no-pjax reservations-action"
                    <?php
                    if ($action['dialog'])
                        echo sprintf("data-dialog-config='%s'", $action['dialog']);
                    if ($action['redirect'])
                        echo sprintf("data-redirect='%s'", $action['redirect']);
                    ?>
                    href="<?php
                    echo sprintf('#reservations/mass/%s', $a); ?>"
                    ><i class="icon-fixed-width <?php
                    echo $action['icon'] ?: 'icon-tag'; ?>"></i> <?php
                    echo $action['action']; ?></a>
            </li>
        <?php
        } ?>
        </ul>
    </div>
 <?php
 } else {
    // Mass Delete ?>
    <!--<span class="red button action-button">
     <a class="reservations-action" id="reservations-delete" data-placement="bottom"
        data-toggle="tooltip" title="<?php echo __('Delete'); ?>"
        href="#reservations/mass/delete"><i class="icon-trash"></i></a>
    </span>-->
<?php
} ?>


<script type="text/javascript">
$(function() {
    $(document).off('.reservations-actions');
    $(document).on('click.reservations-actions', 'a.reservations-action', function(e) {
        e.preventDefault();
        var $form = $('form#reservations');
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
            var $redirect = $(this).data('redirect');
            $.dialog(url, [201], function (xhr) {
                if (!!$redirect) {
                    $.pjax({url: $redirect, container:'#pjax-container'});
                } else {
                  <?php
                  if (isset($options['callback_url']))
                    echo sprintf("$.pjax({url: '%s', container: '%s', push: false});",
                           $options['callback_url'],
                           @$options['container'] ?: '#pjax-container'
                           );
                  else
                    echo sprintf("$.pjax.reload('%s');",
                            @$options['container'] ?: '#pjax-container');
                 ?>
                }
             });
        }
        return false;
    });
});
</script>
