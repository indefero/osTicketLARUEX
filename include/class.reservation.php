<?php
/*********************************************************************
    class.reservation.php
 
    Released under the GNU General Public License WITHOUT ANY WARRANTY.
    See LICENSE.TXT for details.

    vim: expandtab sw=4 ts=4 sts=4:
**********************************************************************/
include_once(INCLUDE_DIR.'class.equipment.php');

//Ticket thread.
class EquipmentReservation extends VerySimpleModel {
    static $meta = array(
        'table' => EQUIPMENT_RESERVATION_TABLE,
        'pk' => array('id'),
        'joins' => array(
            'equipment' => array(
                'constraint' => array(
                    'equipment_id' => 'Equipment.id'
                )
            ),
            'staff' => array(
                'constraint' => array('staff_id' => 'Staff.staff_id')
            )
        )
    );

    var $_object;
    var $_start;
    var $_end;

    function getId() {
        return $this->id;
    }

    function getObjectId() {
        return $this->object_id;
    }

    function getObject() {

        if (!$this->_object)
            $this->_object = ObjectModel::lookup(
                    $this->getObjectId(), $this->getObjectType());

        return $this->_object;
    }
    
    function getStaff() {
        return $this->staff;
    }
    
    function getEquipment() {
        return $this->equipment;
    }
    
    function getStartDate() {
        return $this->ht['start'];
    }
    
    function getEndDate() {
        return $this->ht['end'];
    }

    // Render reservation
    function render($type=false, $options=array()) {

        $mode = $options['mode'] ?: self::MODE_STAFF;

        // Register thread actions prior to rendering the thread.
        if (!class_exists('tea_showemailheaders'))
            include_once INCLUDE_DIR . 'class.thread_actions.php';

        $entries = $this->getEntries();
        if ($type && is_array($type))
            $entries->filter(array('type__in' => $type));

        if ($options['sort'] && !strcasecmp($options['sort'], 'DESC'))
            $entries->order_by('-id');

        // Precache all the attachments on this thread
        AttachmentFile::objects()->filter(array(
            'attachments__thread_entry__thread__id' => $this->id
        ))->all();

        $events = $this->getEvents();
        $inc = ($mode == self::MODE_STAFF) ? STAFFINC_DIR : CLIENTINC_DIR;
        include $inc . 'templates/thread-entries.tmpl.php';
    }
    
    function addDynamicData($data) {

        $tf = EquipmentForm::getInstance($this->id, true);
        foreach ($tf->getFields() as $f)
            if (isset($data[$f->get('name')]))
                $tf->setAnswer($f->get('name'), $data[$f->get('name')]);

        $tf->save();

        return $tf;
    }
    
    function logEvent($state, $data=null, $user=null, $annul=null) {
        $this->getEquipment()->getThread()->getEvents()->log($this->getEquipment(), $state, $data, $user, $annul);
    }

    function delete() {

        //Self delete
        if (!parent::delete())
            return false;

        return true;
    }

    static function create($vars=false) {
        global $thisstaff, $cfg;

        if (!is_array($vars)
                || !$thisstaff)
            return null;

        $reservation = new static(array(
            'equipment_id' => $vars['equipment_id'],
            'staff_id' => $vars['staff_id'],
        ));

        if ($vars['internal_formdata']['start'])
            $reservation->start = date('Y-m-d G:i', Misc::dbtime($vars['internal_formdata']['start']));
        if ($vars['internal_formdata']['end'])
	    $reservation->end = date('Y-m-d G:i', Misc::dbtime($vars['internal_formdata']['end']));

        if (!$reservation->save(true))
            return false;

        // Add dynamic data
        $reservation->addDynamicData($vars['default_formdata']);

        $reservation->logEvent('reserved', null, $thisstaff);

        Signal::send('reservation.created', $reservation);
        
        return $reservation;
    }
    
    function archive() {
        $sql='INSERT INTO '.HIST_RESERVATION_TABLE.' (equipment_id, start, end, staff_id) '
            .'(SELECT equipment_id, start, end, staff_id FROM '.EQUIPMENT_RESERVATION_TABLE
            .' WHERE id = '.$this->getId().')';
        
        if (db_query($sql)) {
            //Self delete
            if (!parent::delete())
                return false;
        } else {
            return false;
        }

        return true;
    }
    
    static function getAgentActions($agent, $options=array()) {
        if (!$agent)
            return;

        require STAFFINC_DIR.'templates/equipment-reservation-actions.tmpl.php';
    }
    
    /**
     * Método que almacena las reservas ya cumplidas en una tabla de históricos 
     * para que no se acumulen en la vista de cada equipamiento.
     */
    static function ArchiveReservations() {
        $sql='SELECT id FROM '.EQUIPMENT_RESERVATION_TABLE.' T1 '
            .' WHERE end < NOW() '
            .' ORDER BY start';

        if (($res = db_query($sql)) && db_num_rows($res)) {
            while (list($id) = db_fetch_row($res)) {
                if ($reservation = EquipmentReservation::lookup($id))
                    $reservation->archive();
            }
        }
    }
}
    
class ReservationForm extends DynamicForm {
    static $instance;
    static $defaultForm;
    static $internalForm;

    static $forms;

    static function objects() {
        $os = parent::objects();
        return $os->filter(array('type'=>ObjectModel::OBJECT_TYPE_RESERVATION));
    }

    static function getDefaultForm() {
        if (!isset(static::$defaultForm)) {
            if (($o = static::objects()) && $o[0])
                static::$defaultForm = $o[0];
        }

        return static::$defaultForm;
    }

    static function getInstance($object_id=0, $new=false) {
        if ($new || !isset(static::$instance))
            static::$instance = static::getDefaultForm()->instanciate();

        static::$instance->object_type = ObjectModel::OBJECT_TYPE_RESERVATION;

        if ($object_id)
            static::$instance->object_id = $object_id;

        return static::$instance;
    }

    static function getInternalForm($source=null, $options=array()) {
        if (!isset(static::$internalForm))
            static::$internalForm = new ReservationInternalForm($source, $options);

        return static::$internalForm;
    }
}

class ReservationInternalForm
extends AbstractForm {
    static $layout = 'GridFormLayout';

    function buildFields() {

        $fields = array(
                'start'  =>  new DatetimeField(array(
                    'id' => 1,
                    'label' => __('Inicio'),
                    'required' => true,
                    'configuration' => array(
                        'min' => Misc::gmtime(),
                        'time' => true,
                        'gmt' => false,
                        'future' => true,
                        ),
                    )),
                'end'  =>  new DatetimeField(array(
                    'id' => 2,
                    'label' => __('Fin'),
                    'required' => true,
                    'configuration' => array(
                        'min' => Misc::gmtime(),
                        'time' => true,
                        'gmt' => false,
                        'future' => true,
                        ),
                    )),
            );

        $mode = @$this->options['mode'];
        if ($mode && $mode == 'edit') {
            unset($fields['dept_id']);
            unset($fields['assignee']);
        }

        return $fields;
    }
}

?>
