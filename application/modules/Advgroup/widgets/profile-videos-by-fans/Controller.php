<?php
class Advgroup_Widget_ProfileVideosByFansController extends Engine_Content_Widget_Abstract{
  	public function indexAction(){
     	// Don't render this if not authorized
    	$this->view->viewer = $viewer = Engine_Api::_()->user()->getViewer();
    	if( !Engine_Api::_()->core()->hasSubject() ) {
      		return $this->setNoRender();
    	}
	
    	if(!Engine_Api::_()->hasItemType('video')) {
      		return $this->setNorender();
    	}
    	
    	// Get subject and check auth
    	$this->view->group = $subject = Engine_Api::_()->core()->getSubject('group');
    	if($subject->is_subgroup && !$subject->isParentGroupOwner($viewer)){
       		$parent_group = $subject->getParentGroup();
    		if(!$parent_group->authorization()->isAllowed($viewer , "view")){
          		return $this->setNoRender();
        	}
        	else if(!$subject->authorization()->isAllowed($viewer , "view")){
          		return $this->setNoRender();
        	}
    	}
    	else if( !$subject->authorization()->isAllowed($viewer, 'view') ) {
      		return $this->setNoRender();
    	}
    
    	//Get number of videos display
    	$max = $this->_getParam('itemCountPerPage');
    	if(!is_numeric($max) | $max <=0) $max = 5;

	    $params = array();
	    $params['parent_type'] = 'group';
	    $params['parent_id'] = $subject->getIdentity();
	    $params['orderby'] = 'creation_date';
	    $params['page'] = $this->_getParam('page',1);
	    $params['limit'] = $max;
		
		$ids = array();
	    $members = $subject->membership()->getMembersInfo();
	    foreach( $members as $member ) {
	    	if ($member->user_id != $subject->user_id)
	      		$ids[] = $member->user_id;
	    }
		
		$params['user_ids'] = (empty($ids)) ? array(0) : $ids;
		
		//Get data from table Mappings
		$tableMapping = Engine_Api::_()->getItemTable('advgroup_mapping');
		$mapping_ids = $tableMapping -> getVideoIdsMapping($subject -> getIdentity());
	
		//Get data from table video
		$tableVideo = Engine_Api::_()->getItemTable('video');
		$select = $tableVideo -> select() 
		-> from($tableVideo->info('name'), new Zend_Db_Expr("`video_id`"))
		-> where('parent_type = "group"') 
		-> where('parent_id = ?', $subject -> getIdentity());
		$video_ids = $tableVideo -> fetchAll($select);
	
		//Merge ids
		foreach($mapping_ids as $mapping_id) {
			$params['ids'][] = $mapping_id -> item_id;
		}
		foreach($video_ids as $video_id) {
			if(!in_array($video_id -> video_id, $params['ids'])) {
				$params['ids'][] = $video_id -> video_id;
			}
		}
    
    	$this->view->paginator = $paginator = $subject -> getVideosPaginator($params);
  		if (!$paginator->getTotalItemCount()) {
  			return $this->setNoRender();
  		}
  	}
}
?>
