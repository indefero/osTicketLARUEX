<?php
$search = SavedSearch::create();
$equipments = EquipmentModel::objects();
$clear_button = false;
$view_all_equipment = $date_header = $date_col = false;
// Figure out REFRESH url — which might not be accurate after posting a
// response
list($path,) = explode('?', $_SERVER['REQUEST_URI'], 2);
$args = array();
parse_str($_SERVER['QUERY_STRING'], $args);

// Remove commands from query
unset($args['id']);
if ($args['a'] !== 'search') unset($args['a']);

$refresh_url = $path . '?' . http_build_query($args);

$sort_options = array(
    'created' =>            __('Adquirido más recientemente'),
    'updated' =>            __('Most Recently Updated'),
    'activation' =>         __('Puesto en funcionamiento más recientemente'),
    'deactivation' =>       __('Puesto en mantenimiento más recientemente'),
    'retirement' =>         __('Retirado más recientemente')
);

// Queues columns

$queue_columns = array(
        'name' => array(
            'width' => '80%',
            'heading' => __('Name'),
            'sort_col' => 'name',
            ),
        'date' => array(
            'width' => '20%',
            'heading' => __('Date Created'),
            'sort_col' => 'created',
            ),
        'updated' => array(
            'width' => '20%',
            'heading' => __('Fecha de actualización'),
            'sort_col' => 'updated',
            )
        );

$use_subquery = true;

// Figure out the queue we're viewing
$queue_key = sprintf('::Q:%s', ObjectModel::OBJECT_TYPE_EQUIPMENT);
$queue_name = $_SESSION[$queue_key] ?: '';

switch ($queue_name) {
case 'inactive':
    $status='inactive';
    $results_type=__('Mantenimiento');
    $queue_sort_options = array('deactivation','updated');
    break;
case 'retired':
    $status='retired';
    $results_type=__('Retirado');
    $queue_sort_options = array('retirement','updated');
    break;
case 'new':
    $status='new';
    $queue_name = $queue_name ?: 'new';
    $results_type=__('Nuevo');
    $queue_sort_options = array('created','updated');
    break;
default:
case 'search':
    $queue_sort_options = array('created');
    // Consider basic search
    if ($_REQUEST['query']) {
        $results_type=__('Search Results');
        // Use an index if possible
        if ($_REQUEST['search-type'] == 'typeahead') {
            if ($_REQUEST['query']) {
                $tickets = $tickets->filter(array(
                    'number' => $_REQUEST['query'],
                ));
            }
        }
        elseif (isset($_REQUEST['query'])
            && ($q = trim($_REQUEST['query']))
            && strlen($q) > 2
        ) {
            // [Search] click, consider keywords
            $__tickets = $ost->searcher->find($q, $tickets);
            if (!count($__tickets) && preg_match('`\w$`u', $q)) {
                // Do wildcard search if no hits
                $__tickets = $ost->searcher->find($q.'*', $tickets);
            }
            $tickets = $__tickets;
            $has_relevance = true;
        }
        // Clear sticky search queue
        unset($_SESSION[$queue_key]);
        break;
    } elseif (isset($_SESSION['advsearch'])) {
        $form = $search->getFormFromSession('advsearch');
        $tickets = $search->mangleQuerySet($tickets, $form);
        $results_type=__('Advanced Search')
            . '<a class="action-button" style="font-size: 15px;" href="?clear_filter"><i style="top:0" class="icon-ban-circle"></i> <em>' . __('clear') . '</em></a>';
        foreach ($form->getFields() as $sf) {
            if ($sf->get('name') == 'keywords' && $sf->getClean()) {
                $has_relevance = true;
                break;
            }
        }
        break;
    }
    // Este será el estado por defecto (cuando no se ha seleccionado una lista del submenú en la sesión actual)
case 'available':
    $status='active';
    $results_type=__('Operativo');
    $queue_sort_options = array('activation','updated');
    break;
}

// Apply primary ticket status
if ($status)
    $equipments->filter(array('status__state'=>$status));

// TODO :: Apply requested quick filter

// Apply requested pagination
$page=($_GET['p'] && is_numeric($_GET['p']))?$_GET['p']:1;
$count = $equipments->count();
$pageNav = new Pagenate($count, $page, PAGE_LIMIT);
$pageNav->setURL('equipment.php', $args);
$equipments = $pageNav->paginate($equipments);

// Apply requested sorting
$queue_sort_key = sprintf(':Q%s:%s:sort', ObjectModel::OBJECT_TYPE_EQUIPMENT, $queue_name);

if (isset($_GET['sort'])) {
    $_SESSION[$queue_sort_key] = array($_GET['sort'], $_GET['dir']);
}
elseif (!isset($_SESSION[$queue_sort_key])) {
    $_SESSION[$queue_sort_key] = array($queue_sort_options[0], 0);
}

list($sort_cols, $sort_dir) = $_SESSION[$queue_sort_key];
$orm_dir = $sort_dir ? QuerySet::ASC : QuerySet::DESC;
$orm_dir_r = $sort_dir ? QuerySet::DESC : QuerySet::ASC;

switch ($sort_cols) {
case 'created':
    $queue_columns['date']['heading'] = __('Fecha adquisición');
    $queue_columns['date']['sort_col'] = $date_col = 'created';
    $equipments->values('created');
    $equipments->order_by($sort_dir ? 'created' : '-created');
    break;
case 'activation':
    $queue_columns['date']['heading'] = __('Fecha inicio operación');
    $queue_columns['date']['sort'] = $sort_cols;
    $queue_columns['date']['sort_col'] = $date_col = 'activation';
    $queue_columns['date']['sort_dir'] = $sort_dir;
    $equipments->values('activation');
    $equipments->order_by('activation', $orm_dir);
    break;
case 'deactivation':
    $queue_columns['date']['heading'] = __('Fecha entrada mantenimiento');
    $queue_columns['date']['sort'] = $sort_cols;
    $queue_columns['date']['sort_col'] = $date_col = 'deactivation';
    $queue_columns['date']['sort_dir'] = $sort_dir;
    $equipments->values('deactivation');
    $equipments->order_by('deactivation', $orm_dir);
    break;
case 'retirement':
    $queue_columns['date']['heading'] = __('Fecha retirada');
    $queue_columns['date']['sort'] = $sort_cols;
    $queue_columns['date']['sort_col'] = $date_col = 'retirement';
    $queue_columns['date']['sort_dir'] = $sort_dir;
    $equipments->values('retirement');
    $equipments->order_by('retirement', $orm_dir);
    break;
default:
    if ($sort_cols && isset($queue_columns[$sort_cols])) {
        $queue_columns[$sort_cols]['sort_dir'] = $sort_dir;
        if (isset($queue_columns[$sort_cols]['sort_col']))
            $sort_cols = $queue_columns[$sort_cols]['sort_col'];
        $equipments->order_by($sort_cols, $orm_dir);
        break;
    }
}

if (in_array($sort_cols, array('created', 'due', 'updated')))
    $queue_columns['date']['sort_dir'] = $sort_dir;

// Rewrite $tickets to use a nested query, which will include the LIMIT part
// in order to speed the result
$orig_equipment = clone $equipments;
$equipments2 = EquipmentModel::objects();
$equipments2->values = $equipments->values;
$equipments2->filter(array('id__in' => $equipments->values_flat('id')));

// Transfer the order_by from the original tickets
$equipments2->order_by($orig_equipment->getSortFields());
$equipments = $equipments2;

// Save the query to the session for exporting
$_SESSION[':Q:equipments'] = $equipments;

TicketForm::ensureDynamicDataView();

// Select pertinent columns
// ------------------------------------------------------------
$equipments->values('lock__staff_id', 'id', 'name', 'description',
'status_id', 'status__name', 'status__state', 'updated');


// Make sure we're only getting active locks
$equipments->constrain(array('lock' => array(
                'lock__expire__gt' => SqlFunction::NOW())));

?>

<!-- SEARCH FORM START -->
<div id='basic_search'>
  <div class="pull-right" style="height:25px">
    <span class="valign-helper"></span>
    <?php
    require STAFFINC_DIR.'templates/queue-sort.tmpl.php';
    ?>
  </div>
    <form action="equipment.php" method="get" onsubmit="javascript:
  $.pjax({
    url:$(this).attr('action') + '?' + $(this).serialize(),
    container:'#pjax-container',
    timeout: 2000
  });
return false;">
    <input type="hidden" name="a" value="search">
    <input type="hidden" name="search-type" value=""/>
    <div class="attached input">
      <input type="text" class="basic-search" data-url="ajax.php/equipment/lookup" name="query"
        autofocus size="30" value="<?php echo Format::htmlchars($_REQUEST['query'], true); ?>"
        autocomplete="off" autocorrect="off" autocapitalize="off">
      <button type="submit" class="attached button"><i class="icon-search"></i>
      </button>
    </div>
    <a href="#" onclick="javascript:
        $.dialog('ajax.php/equipment/search', 201);"
        >[<?php echo __('Advanced Search'); ?>]</a>
        <i class="help-tip icon-question-sign" href="#advanced"></i>
    </form>
</div>
<!-- SEARCH FORM END -->
<div class="clear"></div>
<div style="margin-bottom:20px; padding-top:5px;">
    <div class="sticky bar opaque">
        <div class="content">
            <div class="pull-left flush-left">
                <h2><a href="<?php echo $refresh_url; ?>"
                    title="<?php echo __('Refresh'); ?>"><i class="icon-refresh"></i> <?php echo
                    $results_type; ?></a></h2>
            </div>
            <div class="pull-right flush-right">
            <?php
            if ($count) {
                Equipment::agentActions(array('status' => $status));
            }?>
            </div>
        </div>
    </div>
</div>
<div class="clear"></div>
<form action="equipment.php" method="POST" name="equipments" id="equipments">
<?php csrf_token(); ?>
 <input type="hidden" name="a" value="mass_process" >
 <input type="hidden" name="do" id="action" value="" >
 <input type="hidden" name="status" value="<?php echo
 Format::htmlchars($_REQUEST['status'], true); ?>" >
 <table class="list" border="0" cellspacing="1" cellpadding="2" width="940">
    <thead>
        <tr>
	    <th width="2%">&nbsp;</th>

            <?php
            if ($search && !$status)
                unset($queue_columns['priority']);
            else
                unset($queue_columns['status']);

            // Query string
            unset($args['sort'], $args['dir'], $args['_pjax']);
            $qstr = Http::build_query($args);
            // Show headers
            foreach ($queue_columns as $k => $column) {
                echo sprintf( '<th width="%s"><a href="?sort=%s&dir=%s&%s"
                        class="%s">%s</a></th>',
                        $column['width'],
                        $column['sort'] ?: $k,
                        $column['sort_dir'] ? 0 : 1,
                        $qstr,
                        isset($column['sort_dir'])
                        ? ($column['sort_dir'] ? 'asc': 'desc') : '',
                        $column['heading']);
            }
            ?>
        </tr>
     </thead>
     <tbody>
        <?php
        // Setup Subject field for display
        $subject_field = TicketForm::getInstance()->getField('subject');
        $class = "row1";
        $total=0;
        $ids=($errors && $_POST['tids'] && is_array($_POST['tids']))?$_POST['tids']:null;
        foreach ($equipments as $E) {
            $total += 1;
            $flag=null;
            if($E['lock__staff_id'] && $E['lock__staff_id'] != $thisstaff->getId())
                $flag='locked';

            $lc='';
            $tid=$E['name'];
            ?>
            <tr id="<?php echo $E['id']; ?>">
                <?php

                    $sel=false;
                    if($ids && in_array($E['id'], $ids))
                        $sel=true;
                    ?>
                <td align="center" class="nohover">
                    <input class="ckb" type="checkbox" name="tids[]"
                        value="<?php echo $E['id']; ?>" <?php echo $sel?'checked="checked"':''; ?>>
                </td>
                <td title="<?php echo $E['name']; ?>" nowrap>
                  <a class="Icon <?php echo strtolower($E['source']); ?>Equipment preview"
                    title="Preview Equipment"
                    href="equipment.php?id=<?php echo $E['id']; ?>"
                    data-preview="#equipment/<?php echo $E['id']; ?>/preview"
                    ><?php echo $tid; ?></a></td>
                <td align="center" nowrap><?php 
                    echo Format::datetime($E[$date_col ?: 'updated']) ?: $date_fallback;
                ?></td>
                <td align="center" nowrap><?php 
                    echo Format::datetime($E['updated']) ?: $date_fallback;
                ?></td>
            </tr>
            <?php
            } //end of foreach
        if (!$total)
            $ferror=__('There are no tickets matching your criteria.');
        ?>
    </tbody>
    <tfoot>
     <tr>
        <td colspan="7">
            <?php if($total && $thisstaff->canManageTickets()){ ?>
            <?php echo __('Select');?>:&nbsp;
            <a id="selectAll" href="#ckb"><?php echo __('All');?></a>&nbsp;&nbsp;
            <a id="selectNone" href="#ckb"><?php echo __('None');?></a>&nbsp;&nbsp;
            <a id="selectToggle" href="#ckb"><?php echo __('Toggle');?></a>&nbsp;&nbsp;
            <?php }else{
                echo '<i>';
                echo $ferror?Format::htmlchars($ferror):__('Query returned 0 results.');
                echo '</i>';
            } ?>
        </td>
     </tr>
    </tfoot>
    </table>
    <?php
    if ($total>0) { //if we actually had any tickets returned.
?>      <div>
            <span class="faded pull-right"><?php echo $pageNav->showing(); ?></span>
<?php
        echo __('Page').':'.$pageNav->getPageLinks().'&nbsp;';
        echo sprintf('<a class="export-csv no-pjax" href="?%s">%s</a>',
                Http::build_query(array(
                        'a' => 'export', 'h' => $hash,
                        'status' => $_REQUEST['status'])),
                __('Export'));
        echo '&nbsp;<i class="help-tip icon-question-sign" href="#export"></i></div>';
    } ?>
    </form>
</div>

<div style="display:none;" class="dialog" id="confirm-action">
    <h3><?php echo __('Please Confirm');?></h3>
    <a class="close" href=""><i class="icon-remove-circle"></i></a>
    <hr/>
    <p class="confirm-action" style="display:none;" id="mark_overdue-confirm">
        <?php echo __('Are you sure you want to flag the selected tickets as <font color="red"><b>overdue</b></font>?');?>
    </p>
    <div><?php echo __('Please confirm to continue.');?></div>
    <hr style="margin-top:1em"/>
    <p class="full-width">
        <span class="buttons pull-left">
            <input type="button" value="<?php echo __('No, Cancel');?>" class="close">
        </span>
        <span class="buttons pull-right">
            <input type="button" value="<?php echo __('Yes, Do it!');?>" class="confirm">
        </span>
     </p>
    <div class="clear"></div>
</div>
<script type="text/javascript">
$(function() {
    $('[data-toggle=tooltip]').tooltip();
});
</script>

