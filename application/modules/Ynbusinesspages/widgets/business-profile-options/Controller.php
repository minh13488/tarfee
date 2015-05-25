<?php
class Ynbusinesspages_Widget_BusinessProfileOptionsController extends Engine_Content_Widget_Abstract {
	public function indexAction() {
		
	 	 // Don't render this if not authorized
	 	if (Engine_Api::_()->core()->hasSubject()) {
	 	    $business = Engine_Api::_() -> core() -> getSubject('ynbusinesspages_business');
	 	}
        else if ($this->_getParam('business_id')) {
            $business = Engine_Api::_()->getItem('ynbusinesspages_business', $this->_getParam('business_id'));
        }
        if (!$business) {
            return $this->setNoRender();
        }
        if (intval($business -> like_count) < 0)
        {
        	$business -> like_count = 0; 
        	$business -> save();
        }
        $this->view->business = $business;
    }
}
	