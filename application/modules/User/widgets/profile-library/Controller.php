<?php

class User_Widget_ProfileLibraryController extends Engine_Content_Widget_Abstract
{
  public function indexAction()
  {
    // Don't render this if not authorized
    $this->view->viewer = $viewer = Engine_Api::_()->user()->getViewer();
    if( !Engine_Api::_()->core()->hasSubject() ) {
      return $this->setNoRender();
    }
	
	// Get subject
    $this->view->subject = $subject = Engine_Api::_()->core()->getSubject('user');
	
    // get Main Librady
    $this->view->library = $library = $subject -> getMainLibrary();
   
    $params = array();
    $params['owner_type'] = $library -> getType();
	$params['owner_id'] = $library -> getIdentity();
    $this->view->paginator = $paginator = Engine_Api::_()->getDbTable('mappings', 'user') -> getVideosPaginator($params);
		
	 // Set item count per page and current page number
    $paginator->setItemCountPerPage($this->_getParam('itemCountPerPage', 5));
    $paginator->setCurrentPageNumber($this->_getParam('page', 1));

   
  }
}