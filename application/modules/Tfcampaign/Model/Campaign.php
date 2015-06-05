<?php

class Tfcampaign_Model_Campaign extends Core_Model_Item_Abstract {
	
	public function getSlug($str = NULL, $maxstrlen = 64)
	{
		$str = $this -> getTitle();
		if (strlen($str) > 32)
		{
			$str = Engine_String::substr($str, 0, 32) . '...';
		}
		$str = preg_replace('/([a-z])([A-Z])/', '$1 $2', $str);
		$str = strtolower($str);
		$str = preg_replace('/[^a-z0-9-]+/i', '-', $str);
		$str = preg_replace('/-+/', '-', $str);
		$str = trim($str, '-');
		if (!$str)
		{
			$str = '-';
		}
		return $str;
	}
	
	public function getHref($params = array())
	{
		$slug = $this -> getSlug();
		$params = array_merge(array(
			'route' => 'tfcampaign_profile',
			'reset' => true,
			'id' => $this -> getIdentity(),
			'slug' => $slug,
		), $params);
		$route = $params['route'];
		$reset = $params['reset'];
		unset($params['route']);
		unset($params['reset']);
		return Zend_Controller_Front::getInstance() -> getRouter() -> assemble($params, $route, $reset);
	}
	
	function isViewable() {
		//get viewer
		$viewer = Engine_Api::_() -> user() -> getViewer();
		
		//view for specific users
		$tableUserItemView = Engine_Api::_() -> getDbTable('userItemView', 'user');
		$userViewRows = $tableUserItemView -> getUserByItem($this);
		foreach($userViewRows as $userViewRow) {
			$user = Engine_Api::_() -> getItem('user', $userViewRow -> user_id);
			if($user -> getIdentity() && $viewer -> isSelf($user)) {
				return true;
			}
		}
        return $this->authorization()->isAllowed(null, 'view'); 
    }
	
}
