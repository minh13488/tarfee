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

		$ids = array();
	    $members = $subject->membership()->getMembersInfo();
	    foreach( $members as $member ) {
	    	if ($member->user_id != $subject->user_id)
	      		$ids[] = $member->user_id;
	    }
		
		if (empty($ids)) $ids = array(0);
		
		//Get data from table video
		$tableVideo = Engine_Api::_()->getItemTable('video');
		$tagTbl = Engine_Api::_()->getDbTable('tags', 'core');
		$tagTblName = $tagTbl->info('name');
		$tagmapTbl = Engine_Api::_()->getDbTable('tagMaps', 'core');
		$tagmapTblName = $tagmapTbl->info('name');
		$tagSelect = $tagTbl -> select() -> from($tagTblName) -> setIntegrityCheck(false);
		$tagSelect->joinLeft($tagmapTblName, "$tagmapTblName.tag_id = $tagTblName.tag_id","$tagmapTblName.resource_id as resource_id");
		$tagSelect
			->where("$tagmapTblName.resource_type = ?", 'video')
			->where("$tagmapTblName.tagger_type = ?", 'user')
			->where("$tagmapTblName.tagger_id IN (?)", $ids)
			->where("$tagTblName.text LIKE ?", $subject->getTitle());
		$video_ids = array();
		$tags = $tagTbl->fetchAll($tagSelect); 
		$video_ids = array();
		foreach ($tags as $tag) {
			$video_ids[] = $tag->resource_id;
		}
		if (empty($video_ids)) $video_ids = array(0);
		$video_ids = array_unique($video_ids);
		
		$select = $tableVideo -> select()
		-> where('video_id IN (?)', $video_ids)
		-> where('owner_id IN (?)', $ids)
		-> order('creation_date DESC')
		-> limit($max);
    
    	$this->view->paginator = $paginator = Zend_Paginator::factory($select);
  		if (!$paginator->getTotalItemCount()) {
  			return $this->setNoRender();
  		}
  	}
}
?>
