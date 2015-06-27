<?php
class Tfcampaign_Widget_FilterCampaignsController extends Engine_Content_Widget_Abstract
{
	public function indexAction()
	{
		$this -> view -> params =  Zend_Controller_Front::getInstance()->getRequest()->getParams();
	}
}
