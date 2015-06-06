<?php
class Tfcampaign_Widget_UserProfileCampaignController extends Engine_Content_Widget_Abstract
{
	protected $_childCount;
	public function indexAction()
	{
		// Don't render this if not authorized
		$this -> view -> viewer = $viewer = Engine_Api::_() -> user() -> getViewer();
		if (!Engine_Api::_() -> core() -> hasSubject())
		{
			return $this -> setNoRender();
		}

		// Get subject
		$this -> view -> subject = $subject = Engine_Api::_() -> core() -> getSubject('user');

		if (!$subject)
		{
			return $this -> setNoRender();
		}

		$campaignTable = Engine_Api::_() -> getItemTable('tfcampaign_campaign');
		$this -> view -> campaigns = $campaigns = $campaignTable -> getCampaignsByUser($subject);
      	if (count($campaigns) > 0)
		{
      		$this->_childCount = count($campaigns);
		}
	}

	public function getChildCount()
	{
		return $this -> _childCount;
	}
}
