<?php
class User_Model_Location extends Core_Model_Item_Abstract {
    protected $_type = 'user_location';
    protected $_parent_type = 'user';
    protected $_searchTriggers = false;
	
	public function getHref($params = array()) {
		$slug = $this -> getSlug();
		$params = array_merge(array(
			'route' => 'admin_default',
			'reset' => true,
			'module' => 'user',
			'controller' => 'locations',
			'action' => 'index',
			'id' => $this -> getIdentity(),
			'slug' => $slug,
		), $params);
		$route = $params['route'];
		$reset = $params['reset'];
		unset($params['route']);
		unset($params['reset']);
		return Zend_Controller_Front::getInstance() -> getRouter() -> assemble($params, $route, $reset);
	}
}