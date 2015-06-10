<?php
class Tfcampaign_ProfileController extends Core_Controller_Action_Standard
{
  	public function init()
  	{
  		$viewer = Engine_Api::_() -> user() -> getViewer();
  		$subject = null;
  		if( !Engine_Api::_()->core()->hasSubject() )
  		{
  			$id = $this->_getParam('id');
  			if( null !== $id )
  			{
  				$subject = Engine_Api::_()->getItem('tfcampaign_campaign', $id);
				
  				if( $subject && $subject->getIdentity() )
  				{
  					Engine_Api::_()->core()->setSubject($subject);
  				}
  			}
  		}
  		$this->_helper->requireSubject('tfcampaign_campaign');
  	}
  
	public function indexAction()
	{
	    if(!Engine_Api::_()->core()->hasSubject()) 
		{
	    	return $this->_helper->requireSubject()->forward();
		}	
	    $this -> view -> campaign = $campaign = Engine_Api::_()->core()->getSubject();
        // Check authorization to view business.
        if (!$campaign->isViewable()) {
            return $this -> _helper -> requireAuth() -> forward();
        }
		$params  = $this ->_getAllParams();
		$params['campaign_id'] = $campaign -> getIdentity();
		$campaign -> view_count++;
		$campaign -> save();
		
		//for filter
		$filterType = $this ->_getParam('sort', 'matching');
		
		switch ($filterType) {
			case 'location':
				
				break;
			case 'age':
				
				break;
			case 'gender':
				
				break;	
		}
		
		$submissionTable = Engine_Api::_() -> getItemTable('tfcampaign_submission');
		$submissionPlayers = $submissionTable -> fetchAll($submissionTable -> getSubmissionsSelect($params));
		
		switch ($filterType) {
				case 'matching':
					$arrMatch = array();
					foreach($submissionPlayers as $submissionPlayer) {
						$arrMatch[$submissionPlayer -> getIdentity()] = $submissionPlayer -> countPercentMatching();
					}
					arsort($arrMatch);
					$submissionPlayers = null;
					foreach($arrMatch as $key => $value) {
						$submission = Engine_Api::_() -> getItem('tfcampaign_submission', $key);
						if($submission)
							$submissionPlayers[] = $submission;
					}
					break;
				case 'rating':
					$arrMatch = array();
					foreach($submissionPlayers as $submissionPlayer) {
						$player = $submissionPlayer -> getPlayer();
						if($player)
							$arrMatch[$submissionPlayer -> getIdentity()] = $player -> getOverallRating();
					}
					arsort($arrMatch);
					$submissionPlayers = null;
					foreach($arrMatch as $key => $value) {
						$submission = Engine_Api::_() -> getItem('tfcampaign_submission', $key);
						if($submission)
							$submissionPlayers[] = $submission;
					}
					break;
		}
		$this -> view -> filterType = $filterType;
		$this -> view -> submissionPlayers = $submissionPlayers;
		
  	}
}
