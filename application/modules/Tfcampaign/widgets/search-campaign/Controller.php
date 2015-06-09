<?php
class Tfcampaign_Widget_SearchCampaignController extends Engine_Content_Widget_Abstract 
{
	public function indexAction()
	{
        $viewer = Engine_Api::_()->user()->getViewer();
        $this->view->form = $form = new Tfcampaign_Form_Search();
	}
}