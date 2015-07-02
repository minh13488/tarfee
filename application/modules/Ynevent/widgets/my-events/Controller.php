<?php

class Ynevent_Widget_MyEventsController extends Engine_Content_Widget_Abstract
{
  protected $_childCount;
  
  public function indexAction()
  {
    // Don't render this if not authorized
    $viewer = Engine_Api::_()->user()->getViewer();
	$type = $this -> _getParam('type', 0);

    // Get paginator
    $eventTb = Engine_Api::_()->getDbtable('events', 'ynevent');
    $this->view->paginator = $paginator = Zend_Paginator::factory($eventTb -> select() -> where('type_id = ?', $type) ->order('creation_date DESC'));

    // Set item count per page and current page number
    $paginator->setItemCountPerPage($this->_getParam('itemCountPerPage', 5));
    $paginator->setCurrentPageNumber($this->_getParam('page', 1));
	$this -> view -> itemCountPerPage = $this->_getParam('itemCountPerPage', 5);
	$this -> view -> type = $type;
	if($paginator -> getTotalItemCount() <= 0)
	{
		return $this -> setNoRender();
	}
  }
}