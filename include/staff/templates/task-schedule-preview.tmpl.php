<?php
$error=$msg=$warn=null;

if (!$task->checkStaffPerm($thisstaff))
     $warn.= sprintf(__('You do not have access to %s'), __('esta programación de tareas'));

echo sprintf(
        '<div style="width:600px; padding: 2px 2px 0 5px;" id="t%s">
         <h2>'.__('Task #%s').': %s</h2>',
         $task->getId(),
         str_pad($task->getId(), 6, "0", STR_PAD_LEFT),
         Format::htmlchars($task->getTitle()));

if($error)
    echo sprintf('<div id="msg_error">%s</div>',$error);
elseif($msg)
    echo sprintf('<div id="msg_notice">%s</div>',$msg);
elseif($warn)
    echo sprintf('<div id="msg_warning">%s</div>',$warn);

echo '<ul class="tabs" id="task-preview">';

echo '
        <li class="active"><a href="#summary"
            ><i class="icon-list-alt"></i>&nbsp;'.__('Resumen de la programación de tareas').'</a></li>';
if ($task->getThread()->getNumCollaborators()) {
    echo sprintf('
        <li><a id="collab_tab" href="#collab"
            ><i class="icon-fixed-width icon-group
            faded"></i>&nbsp;'.__('Collaborators (%d)').'</a></li>',
            $task->getThread()->getNumCollaborators());
}
echo '</ul>';
echo '<div id="task-preview_container">';
echo '<div class="tab_content" id="summary">';
echo '<table border="0" cellspacing="" cellpadding="1" width="100%" class="ticket_info">';

echo sprintf('
        <tr>
            <th>Periodicidad:</th>
            <td>%s</td>
        </tr>',
        $task->regularity);

echo sprintf('
        <tr>
            <th>Tiempo de resolución:</th>
            <td>%d días</td>
        </tr>',
        $task->period);

if ($task->last_created_task) {
    echo sprintf('
            <tr>
                <th>Última tarea creada:</th>
                <td>%s</td>
            </tr>',
            Format::datetime($task->last_created_task));
}

echo sprintf('
        <tr>
            <th>Inicio (fecha creación de primera tarea):</th>
            <td>%s</td>
        </tr>',
        Format::datetime($task->start));

echo sprintf('
        <tr>
            <th>'.__('Created').':</th>
            <td>%s</td>
        </tr>',
        Format::datetime($task->getCreateDate()));

echo '</table>';


echo '<hr>
    <table border="0" cellspacing="" cellpadding="1" width="100%" class="ticket_info">';

echo sprintf('
        <tr>
            <th width="100">'.__('Assigned To').':</th>
            <td>%s</td>
        </tr>', $task->getAssigned() ?: ' <span class="faded">&mdash; '.__('Unassigned').' &mdash;</span>');

echo sprintf(
    '
        <tr>
            <th width="100">'.__('Department').':</th>
            <td>%s</td>
        </tr>',
    Format::htmlchars($task->dept->getName())
    );

echo '
    </table>';
echo '</div>';
?>
<?php
//TODO: add link to view if the user has permission
?>
</div>
</div>
