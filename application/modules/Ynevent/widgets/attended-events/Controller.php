<?php

class Ynevent_Widget_AttendedEventsController extends Engine_Content_Widget_Abstract
{
  protected $_childCount;
  
  public function indexAction()
  {
    // Don't render this if not authorized
    $viewer = Engine_Api::_()->user()->getViewer();
	
	$membership = Engine_Api::_() -> getDbtable('membership', 'ynevent');
	$select = $membership -> getMembershipsOfSelect($viewer);
    // Get paginator
    $this->view->paginator = $paginator = Zend_Paginator::factory($select);

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