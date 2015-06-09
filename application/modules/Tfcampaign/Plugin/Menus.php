<?php
class Tfcampaign_Plugin_Menus {
	public function onMenuInitialize_TfcampaignMainManage() {
		// Must be logged in
		$viewer = Engine_Api::_() -> user() -> getViewer();
		if (!$viewer -> getIdentity()) {
			return false;
		}
		return true;
	}
	public function onMenuInitialize_TfcampaignMainCreate() {
		// Must be logged in
		$viewer = Engine_Api::_() -> user() -> getViewer();
		if (!$viewer -> getIdentity()) {
			return false;
		}
		 // Must be able to create campaign
	    if( !Engine_Api::_()->authorization()->isAllowed('tfcampaign_campaign', $viewer, 'create') ) {
	      return false;
	    }
		return true;
	}
	
}
