<?php
class Tfcampaign_Widget_UserProfileCampaignController extends Engine_Content_Widget_Abstract
{
	public function indexAction()
	{
		// Don't render this if not authorized
		$this -> view -> viewer = $viewer = Engine_Api::_() -> user() -> getViewer();
		if (!Engine_Api::_() -> core() -> hasSubject())
		{
			return $this -> setNoRender();
		}

		$params = $this ->_getAllParams();
		
		// Get subject
		$this -> view -> subject = $subject = Engine_Api::_() -> core() -> getSubject('user');

		if (!$subject)
		{
			return $this -> setNoRender();
		}

		$campaignTable = Engine_Api::_() -> getItemTable('tfcampaign_campaign');
		$this -> view -> total = $campaignTable -> getCampaignsTotal($subject);
		$this -> view -> campaigns = $campaigns = $campaignTable -> getCampaignsByUser($subject, $params['itemCountPerPage']);
		if(count($campaigns) <= 0 && !$viewer -> isSelf($subject))
		{
			return $this -> setNoRender();
		}
	}
}
