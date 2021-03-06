<?php
class Ynresponsiveevent_Widget_EventPopularEventsController extends Engine_Content_Widget_Abstract
{
  public function indexAction()
  {
  	if(YNRESPONSIVE_ACTIVE != 'ynresponsive-event' || !Engine_Api::_() -> hasItemType('event'))
	{
		return $this -> setNoRender(true);
	}	
	//Get number of events display
	$limit = 6;
    if($this->_getParam('max') != ''  && $this->_getParam('max') >= 0)
    {       
       $limit = $this->_getParam('max');
    }
	$values['order'] = 'view_count';
	$values['direction'] = 'DESC';
	$paginator = Engine_Api::_() -> ynresponsiveevent() -> getEventPaginator($values);
	$paginator -> setItemCountPerPage($limit);
    
	$this -> view -> events = $paginator;
    $this -> view -> limit = $limit;
	$event_active = 'event';
	if (Engine_Api::_()->hasModuleBootstrap('ynevent'))
	{
		$event_active = 'ynevent';
	}
	$this -> view -> event_active = $event_active;
  }
}