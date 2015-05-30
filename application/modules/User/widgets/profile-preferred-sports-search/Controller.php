<?php

class User_Widget_ProfilePreferredSportsSearchController extends Engine_Content_Widget_Abstract
{
  public function indexAction()
  {
    // Don't render this if not authorized
    $this->view->viewer = $viewer = Engine_Api::_()->user()->getViewer();
    if( !Engine_Api::_()->core()->hasSubject() ) {
      return $this->setNoRender();
    }

    // Get subject and check auth
    $this->view->subject = $subject = Engine_Api::_()->core()->getSubject('user');
    if( !$subject->authorization()->isAllowed($viewer, 'view') || !$viewer -> isSelf($subject) ) {
      return $this->setNoRender();
    }
	
    $this->view->sports = $sports = $subject->getSports();
  }
}