<?php
class Ynbusinesspages_Widget_BusinessNewestBlogsController extends Engine_Content_Widget_Abstract {
	public function indexAction() {
        // Don't render if blog item not available
        if( !Engine_Api::_()->hasItemType('blog') ) {
            return $this->setNoRender();
        }
        // Don't render this if not authorized
        $viewer = Engine_Api::_()->user()->getViewer();
        if( !Engine_Api::_()->core()->hasSubject() ) {
            return $this->setNoRender();
        }
        
        // Get subject and check auth
        $this->view->business = $business = Engine_Api::_()->core()->getSubject('ynbusinesspages_business');
        if(!$business->isViewable() || !$business -> getPackage() -> checkAvailableModule('blog')) {
            return $this->setNoRender();
        }
    
        //Get search condition
        $params = array();
        $params['business_id'] = $business -> getIdentity();
        $params['ItemTable'] = 'blog';
        $params['order'] = 'recent';
        $limit = $this -> _getParam('itemCountPerPage', 1);
        if (!$limit) {
            $limit = 1;
        }
        $params['limit'] = $limit;
        //Get paginator
        $this -> view -> paginator = $paginator = Engine_Api::_() -> getDbTable('mappings', 'ynbusinesspages') -> getBlogsPaginator($params);
        if ($paginator->getTotalItemCount() <= 0) {
            $this->setNoRender();
        }
        
        $timezone = Engine_Api::_()->getApi('settings', 'core')
        	->getSetting('core_locale_timezone', 'GMT');
        if( $viewer && $viewer->getIdentity() && !empty($viewer->timezone) ) {
            $timezone = $viewer->timezone;
        }
        $this->view->timezone = $timezone;
    }
}