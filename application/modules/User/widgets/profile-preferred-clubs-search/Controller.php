<?php

class User_Widget_ProfilePreferredClubsSearchController extends Engine_Content_Widget_Abstract
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
    if( !$subject->authorization()->isAllowed($viewer, 'view') ) {
      return $this->setNoRender();
    }
	
    $userGroupMappingTable = Engine_Api::_() -> getDbTable('groupmappings', 'user');
	$this -> view -> groupMappings = $groupMappings = $userGroupMappingTable -> getGroupByUser($subject -> getIdentity());
	
	$groups = array();
	foreach($groupMappings as $groupMapping){
			$group_id = $groupMapping -> group_id;
			$group = Engine_Api::_() -> getItem('group', $group_id);
			if($group) {
				$groups[] = $group;
			}
	 }
	$this -> view -> groups = $groups;
	
  }
}