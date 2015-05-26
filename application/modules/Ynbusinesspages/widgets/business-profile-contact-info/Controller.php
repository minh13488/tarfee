<?php
class Ynbusinesspages_Widget_BusinessProfileContactInfoController extends Engine_Content_Widget_Abstract {
	public function indexAction() {
		
		$this -> view -> params = $params = $this ->_getAllParams();
		if(isset($params['phone']) 
			&& isset($params['fax']) 
			&& isset($params['email']) 
			&& isset($params['website'])
			&& !$params['phone'] 
			&& !$params['fax'] 
			&&  !$params['email'] 
			&&  !$params['website'])
		{
			return $this -> setNoRender();
		}
		
	 	 // Don't render this if not authorized
		$viewer = Engine_Api::_() -> user() -> getViewer();
		if (!Engine_Api::_() -> core() -> hasSubject()) {
			return $this -> setNoRender();
		}

		// Get subject and check auth
		$subject = Engine_Api::_() -> core() -> getSubject('ynbusinesspages_business');
        if (!$subject -> isViewable()) {
            return $this -> setNoRender();
        }
        
		if($subject -> is_claimed)
		{
			return $this -> setNoRender();
		}
		
		//getpackage 
		$this -> view -> business = $business = $subject;
		
	}
}
	