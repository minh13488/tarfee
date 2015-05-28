<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: IndexController.php 10075 2013-07-30 21:51:18Z jung $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class User_IndexController extends Core_Controller_Action_Standard
{
  public function indexAction()
  {

  }

  public function homeAction()
  {
    // check public settings
    $require_check = Engine_Api::_()->getApi('settings', 'core')->getSetting('core.general.portal', 1);
    if(!$require_check){
      if( !$this->_helper->requireUser()->isValid() ) return;
    }

    if( !Engine_Api::_()->user()->getViewer()->getIdentity() ) {
      return $this->_helper->redirector->gotoRoute(array(), 'default', true);
    }

    // Render
    $this->_helper->content
        ->setNoRender()
        ->setEnabled()
        ;
  }

  public function browseAction()
  {
    $require_check = Engine_Api::_()->getApi('settings', 'core')->getSetting('core.general.browse', 1);
    if(!$require_check){
      if( !$this->_helper->requireUser()->isValid() ) return;
    }
    if( !$this->_executeSearch() ) {
      // throw new Exception('error');
    }

    if( $this->_getParam('ajax') ) {
      $this->renderScript('_browseUsers.tpl');
    }

    if( !$this->_getParam('ajax') ) {
    // Render
    $this->_helper->content
        ->setEnabled()
        ;
    }
  }

  protected function _executeSearch()
  {
    // Check form
    $form = new User_Form_Search(array(
      'type' => 'user'
    ));

    if( !$form->isValid($this->_getAllParams()) ) {
      $this->view->error = true;
      $this->view->totalUsers = 0; 
      $this->view->userCount = 0; 
      $this->view->page = 1;
      return false;
    }

    $this->view->form = $form;

    // Get search params
    $page = (int)  $this->_getParam('page', 1);
    $ajax = (bool) $this->_getParam('ajax', false);
    $options = $form->getValues();
    
    // Process options
    $tmp = array();
    $originalOptions = $options;
    foreach( $options as $k => $v ) {
      if( null == $v || '' == $v || (is_array($v) && count(array_filter($v)) == 0) ) {
        continue;
      } else if( false !== strpos($k, '_field_') ) {
        list($null, $field) = explode('_field_', $k);
        $tmp['field_' . $field] = $v;
      } else if( false !== strpos($k, '_alias_') ) {
        list($null, $alias) = explode('_alias_', $k);
        $tmp[$alias] = $v;
      } else {
        $tmp[$k] = $v;
      }
    }
    $options = $tmp;

    // Get table info
    $table = Engine_Api::_()->getItemTable('user');
    $userTableName = $table->info('name');

    $searchTable = Engine_Api::_()->fields()->getTable('user', 'search');
    $searchTableName = $searchTable->info('name');

    //extract($options); // displayname
    $profile_type = @$options['profile_type'];
    $displayname = @$options['displayname'];
    if (!empty($options['extra'])) {
      extract($options['extra']); // is_online, has_photo, submit
    }

    // Contruct query
    $select = $table->select()
      //->setIntegrityCheck(false)
      ->from($userTableName)
      ->joinLeft($searchTableName, "`{$searchTableName}`.`item_id` = `{$userTableName}`.`user_id`", null)
      //->group("{$userTableName}.user_id")
      ->where("{$userTableName}.search = ?", 1)
      ->where("{$userTableName}.enabled = ?", 1);
      
    $searchDefault = true;  
      
    // Build the photo and is online part of query
    if( isset($has_photo) && !empty($has_photo) ) {
      $select->where($userTableName.'.photo_id != ?', "0");
      $searchDefault = false;
    }

    if( isset($is_online) && !empty($is_online) ) {
      $select
        ->joinRight("engine4_user_online", "engine4_user_online.user_id = `{$userTableName}`.user_id", null)
        ->group("engine4_user_online.user_id")
        ->where($userTableName.'.user_id != ?', "0");
      $searchDefault = false;
    }

    // Add displayname
    if( !empty($displayname) ) {
      $select->where("(`{$userTableName}`.`username` LIKE ? || `{$userTableName}`.`displayname` LIKE ?)", "%{$displayname}%");
      $searchDefault = false;
    }

    // Build search part of query
    $searchParts = Engine_Api::_()->fields()->getSearchQuery('user', $options);
    foreach( $searchParts as $k => $v ) {
      $select->where("`{$searchTableName}`.{$k}", $v);
      
      if(isset($v) && $v != ""){
        $searchDefault = false;
      }
    }
    
    if($searchDefault){
      $select->order("{$userTableName}.lastlogin_date DESC");
    } else {
      $select->order("{$userTableName}.displayname ASC");
    }

    // Build paginator
    $paginator = Zend_Paginator::factory($select);
    $paginator->setItemCountPerPage(10);
    $paginator->setCurrentPageNumber($page);
    
    $this->view->page = $page;
    $this->view->ajax = $ajax;
    $this->view->users = $paginator;
    $this->view->totalUsers = $paginator->getTotalItemCount();
    $this->view->userCount = $paginator->getCurrentItemCount();
    $this->view->topLevelId = $form->getTopLevelId();
    $this->view->topLevelValue = $form->getTopLevelValue();
    $this->view->formValues = array_filter($originalOptions);

    return true;
  }

	//HOANGND function for render profile section
	public function renderSectionAction() {
        $this->_helper->layout->disableLayout();
        $this->_helper->viewRenderer->setNoRender(true);
        $id = $this->_getParam('user_id', 0);
		$user = Engine_Api::_()->user()->getUser($id);
        
        if (!$id || !$user) {
            return $this->_helper->requireSubject()->forward();
        }
		$type = $this->_getParam('type');
        $params = $this->_getParam('params');
		
		//TODO check auth
        echo Engine_Api::_()->user()->renderSection($type, $user, $params);
    }
	
	public function getMyLocationAction() {
		$latitude = $this -> _getParam('latitude');
		$longitude = $this -> _getParam('longitude');
		$values = file_get_contents("http://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&sensor=true");
		echo $values;
		die ;
  	}
	
	public function uploadPhotoAction() {
        $this->_helper->layout->disableLayout();
        $this->_helper->viewRenderer->setNoRender(true);
        $user = Engine_Api::_()->user()->getViewer();
        if (!$user || !$user->getIdentity()) {
            $status = false;
            $error = Zend_Registry::get('Zend_Translate') -> _('Invalid request.');
            return $this -> getResponse() -> setBody(Zend_Json::encode(array('files' => array(0 => array('status' => $status, 'error'=> $error)))));
        }
        if (!$this -> getRequest() -> isPost()) {
            $status = false;
            $error = Zend_Registry::get('Zend_Translate') -> _('Invalid request method');
            return $this -> getResponse() -> setBody(Zend_Json::encode(array('files' => array(0 => array('status' => $status, 'error'=> $error)))));
        }

        if (empty($_FILES['files'])) {
            $status = false;
            $error = Zend_Registry::get('Zend_Translate') -> _('No file');
            return $this -> getResponse() -> setBody(Zend_Json::encode(array('files' => array(0 => array('status' => $status, 'name'=> $error)))));
        }
        $name = $_FILES['files']['name'][0];
        $type = explode('/', $_FILES['files']['type'][0]);
        if (!$_FILES['files'] || !is_uploaded_file($_FILES['files']['tmp_name'][0]) || $type[0] != 'image') {
            $status = false;
            $error = Zend_Registry::get('Zend_Translate') -> _('Invalid Upload File');
            return $this -> getResponse() -> setBody(Zend_Json::encode(array('files' => array(0 => array('status' => $status, 'error'=> $error, 'name' => $name)))));
        }
        
        if($_FILES['files']['size'][0] > 1000*1024) {
            $status = false;
            $error = Zend_Registry::get('Zend_Translate') -> _('Exceeded filesize limit.');
            return $this -> getResponse() -> setBody(Zend_Json::encode(array('files' => array(0 => array('status' => $status, 'error'=> $error, 'name' => $name)))));
        }
        $temp_file = array(
            'type' => $_FILES['files']['type'][0],
            'tmp_name' => $_FILES['files']['tmp_name'][0],
            'name' => $_FILES['files']['name'][0]
        );
        $photo_id = Engine_Api::_() -> user() -> setPhoto($temp_file, array(
            'parent_type' => 'user',
            'parent_id' => $user->getIdentity(),
        ));
        
        $status = true;
        $name = $_FILES['files']['name'][0];
        
        return $this -> getResponse() -> setBody(Zend_Json::encode(array('files' => array(0 => array('status' => $status, 'name'=> $name, 'photo_id' => $photo_id)))));
    }

	public function sublocationsAction() {
		$this -> _helper -> layout -> disableLayout();
		$this -> _helper -> viewRenderer -> setNoRender(TRUE);
		$id = $this -> getRequest() -> getParam('location_id');
		if (!$id) {
			echo '';
			return;
		}
		$subLocations = Engine_Api::_() -> getDbTable('locations', 'user') -> getLocations($id);
		$html = '';
		foreach ($subLocations as $subLocation)
		{
			$html .= '<option value="' . $subLocation -> getIdentity() . '" label="' . $subLocation -> getTitle() . '" >' . $subLocation -> getTitle() . '</option>';
		}
		echo $html;
		return;
	}
	
	public function getContinentAction() {
		$this -> _helper -> layout -> disableLayout();
		$this -> _helper -> viewRenderer -> setNoRender(TRUE);
		$id = $this -> getRequest() -> getParam('location_id');
		$location = Engine_Api::_()->getItem('user_location', $id);
		if (!$location) {
			echo '';
			return;
		}
		else {
			echo $location->getContinent();
			return;
		}
	}
}