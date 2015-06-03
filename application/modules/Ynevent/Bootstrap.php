<?php
class Ynevent_Bootstrap extends Engine_Application_Bootstrap_Abstract {
	public function __construct($application) {
		parent::__construct($application);
		$this->initViewHelperPath();
		$headScript = new Zend_View_Helper_HeadScript();
		$request = new Zend_Controller_Request_Http();
		$view = Zend_Registry::get('Zend_View');
		$headScript
		->appendFile($view->baseUrl() . '/application/modules/Ynevent/externals/scripts/yncalendar.js')
		->appendFile($view->baseUrl() . '/application/modules/Ynevent/externals/scripts/core.js');
		
		$view->addHelperPath(APPLICATION_PATH .'/application/modules/Ynevent/View/Helper','Ynevent_View_Helper_');

		$front = Zend_Controller_Front::getInstance();
		$front -> registerPlugin(new Ynevent_Controller_Plugin_Dispatch);
	}
}