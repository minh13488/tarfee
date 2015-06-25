<?php
class Tfcampaign_Widget_SearchFormController extends Engine_Content_Widget_Abstract
{
	public function indexAction()
	{
		$this -> view -> params = $params = Zend_Controller_Front::getInstance()->getRequest()->getParams();
	}
}
