<?php
class Ynvideo_Widget_MainPageVideosController extends Engine_Content_Widget_Abstract {
	public function indexAction() {
		$request = Zend_Controller_Front::getInstance ()->getRequest ();
		$params = $request->getParams();
		
		$from = $request-> getParam('from', 0);
		$from = intval($from);
		
		$limit = 10;
		
		$viewer = Engine_Api::_()->user()->getViewer();
		if (!$viewer || !$viewer->getIdentity()) {
			return $this->setNoRender();
		}
		
		$user_ids = array();
		$friends = $viewer->getFriendsList();
		foreach ($friends as $friend) {
			$user_ids[] = $friend->getIdentity();
		}
		$group_ids = array();
		$followGroups = Engine_Api::_()->getDbTable('follow', 'advgroup')->getFollowGroups($viewer->getIdentity());		
		foreach ($followGroups as $group) {
			$group_ids[] = $group->resource_id;
		}
		
		$table = Engine_Api::_()->getItemTable('video');
		$select = $table->select()->distinct();
		if (!empty($user_ids) && !empty($group_ids)) {
			$select->where("owner_type = 'user' AND owner_id IN (?)", $user_ids)->orWhere("parent_type = 'group' AND parent_id IN (?)", $group_ids);
		}
		elseif(!empty($user_ids)) {
			$select->where("owner_type = 'user' AND owner_id IN (?)", $user_ids);
		}
		elseif(!empty($group_ids)) {
			$select->where("parent_type = 'group' AND parent_id IN (?)", $group_ids);
		}
		else {
			$select->where('0 = 1');
		}
		$select->group('video_id');
		$select->limit($limit+1, $from);
		$select->order('video_id DESC');
		$results = $table->fetchAll($select);
		
		if (!count($results)) {
			return $this->setNoRender();
		}
		$this->view->limit = $limit;
		$this->view->from = $from;
		$this->view->results = $results;
	}
}
