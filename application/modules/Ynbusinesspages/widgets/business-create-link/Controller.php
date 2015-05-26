<?php
class Ynbusinesspages_Widget_BusinessCreateLinkController extends Engine_Content_Widget_Abstract {
	public function indexAction() {
		
       $viewer = Engine_Api::_() -> user() -> getViewer();
        // Must be logged-in
        if (!$viewer -> getIdentity())
        {
            return $this->setNoRender();
        }
		if( !Engine_Api::_()->authorization()->isAllowed('ynbusinesspages_business', $viewer, 'create') ) {
	        return $this->setNoRender();
	    }
    }
}
	