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
		$require_check = Engine_Api::_() -> getApi('settings', 'core') -> getSetting('core.general.portal', 1);
		if (!$require_check)
		{
			if (!$this -> _helper -> requireUser() -> isValid())
				return;
		}

		if (!Engine_Api::_() -> user() -> getViewer() -> getIdentity())
		{
			return $this -> _helper -> redirector -> gotoRoute(array(), 'default', true);
		}

		// Render
		$this -> _helper -> content -> setNoRender() -> setEnabled();
	}

	public function browseAction()
	{
		$require_check = Engine_Api::_() -> getApi('settings', 'core') -> getSetting('core.general.browse', 1);
		if (!$require_check)
		{
			if (!$this -> _helper -> requireUser() -> isValid())
				return;
		}
		if (!$this -> _executeSearch())
		{
			// throw new Exception('error');
		}

		if ($this -> _getParam('ajax'))
		{
			$this -> renderScript('_browseUsers.tpl');
		}

		if (!$this -> _getParam('ajax'))
		{
			// Render
			$this -> _helper -> content -> setEnabled();
		}
	}

	protected function _executeSearch()
	{
		// Check form
		$form = new User_Form_Search( array('type' => 'user'));

		if (!$form -> isValid($this -> _getAllParams()))
		{
			$this -> view -> error = true;
			$this -> view -> totalUsers = 0;
			$this -> view -> userCount = 0;
			$this -> view -> page = 1;
			return false;
		}

		$this -> view -> form = $form;

		// Get search params
		$page = (int)$this -> _getParam('page', 1);
		$ajax = (bool)$this -> _getParam('ajax', false);
		$options = $form -> getValues();

		// Process options
		$tmp = array();
		$originalOptions = $options;
		foreach ($options as $k => $v)
		{
			if (null == $v || '' == $v || (is_array($v) && count(array_filter($v)) == 0))
			{
				continue;
			}
			else
			if (false !== strpos($k, '_field_'))
			{
				list($null, $field) = explode('_field_', $k);
				$tmp['field_' . $field] = $v;
			}
			else
			if (false !== strpos($k, '_alias_'))
			{
				list($null, $alias) = explode('_alias_', $k);
				$tmp[$alias] = $v;
			}
			else
			{
				$tmp[$k] = $v;
			}
		}
		$options = $tmp;

		// Get table info
		$table = Engine_Api::_() -> getItemTable('user');
		$userTableName = $table -> info('name');

		$searchTable = Engine_Api::_() -> fields() -> getTable('user', 'search');
		$searchTableName = $searchTable -> info('name');

		//extract($options); // displayname
		$profile_type = @$options['profile_type'];
		$displayname = @$options['displayname'];
		if (!empty($options['extra']))
		{
			extract($options['extra']);
			// is_online, has_photo, submit
		}

		// Contruct query
		$select = $table -> select()
		// -> setIntegrityCheck(false)
		-> from($userTableName) -> joinLeft($searchTableName, "`{$searchTableName}`.`item_id` = `{$userTableName}`.`user_id`", null)
		// -> group("{$userTableName}.user_id")
		-> where("{$userTableName}.search = ?", 1) -> where("{$userTableName}.enabled = ?", 1);

		$searchDefault = true;

		// Build the photo and is online part of query
		if (isset($has_photo) && !empty($has_photo))
		{
			$select -> where($userTableName . '.photo_id != ?', "0");
			$searchDefault = false;
		}

		if (isset($is_online) && !empty($is_online))
		{
			$select -> joinRight("engine4_user_online", "engine4_user_online.user_id = `{$userTableName}`.user_id", null) -> group("engine4_user_online.user_id") -> where($userTableName . '.user_id != ?', "0");
			$searchDefault = false;
		}

		// Add displayname
		if (!empty($displayname))
		{
			$select -> where("(`{$userTableName}`.`username` LIKE ? || `{$userTableName}`.`displayname` LIKE ?)", "%{$displayname}%");
			$searchDefault = false;
		}

		// Build search part of query
		$searchParts = Engine_Api::_() -> fields() -> getSearchQuery('user', $options);
		foreach ($searchParts as $k => $v)
		{
			$select -> where("`{$searchTableName}`.{$k}", $v);

			if (isset($v) && $v != "")
			{
				$searchDefault = false;
			}
		}

		if ($searchDefault)
		{
			$select -> order("{$userTableName}.lastlogin_date DESC");
		}
		else
		{
			$select -> order("{$userTableName}.displayname ASC");
		}

		// Build paginator
		$paginator = Zend_Paginator::factory($select);
		$paginator -> setItemCountPerPage(10);
		$paginator -> setCurrentPageNumber($page);

		$this -> view -> page = $page;
		$this -> view -> ajax = $ajax;
		$this -> view -> users = $paginator;
		$this -> view -> totalUsers = $paginator -> getTotalItemCount();
		$this -> view -> userCount = $paginator -> getCurrentItemCount();
		$this -> view -> topLevelId = $form -> getTopLevelId();
		$this -> view -> topLevelValue = $form -> getTopLevelValue();
		$this -> view -> formValues = array_filter($originalOptions);

		return true;
	}

	//HOANGND function for render profile section
	public function renderSectionAction()
	{
		$this -> _helper -> layout -> disableLayout();
		$this -> _helper -> viewRenderer -> setNoRender(true);
		$id = $this -> _getParam('user_id', 0);
		$user = Engine_Api::_() -> user() -> getUser($id);

		if (!$id || !$user)
		{
			return $this -> _helper -> requireSubject() -> forward();
		}
		$type = $this -> _getParam('type');
		$params = $this -> _getParam('params');

		//TODO check auth
		echo Engine_Api::_() -> user() -> renderSection($type, $user, $params);
	}

	public function getMyLocationAction()
	{
		$latitude = $this -> _getParam('latitude');
		$longitude = $this -> _getParam('longitude');
		$values = file_get_contents("http://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&sensor=true");
		echo $values;
		die ;
	}

	public function uploadPhotoAction()
	{
		$this -> _helper -> layout -> disableLayout();
		$this -> _helper -> viewRenderer -> setNoRender(true);
		$user = Engine_Api::_() -> user() -> getViewer();
		if (!$user || !$user -> getIdentity())
		{
			$status = false;
			$error = Zend_Registry::get('Zend_Translate') -> _('Invalid request.');
			return $this -> getResponse() -> setBody(Zend_Json::encode(array('files' => array(0 => array(
						'status' => $status,
						'error' => $error
					)))));
		}
		if (!$this -> getRequest() -> isPost())
		{
			$status = false;
			$error = Zend_Registry::get('Zend_Translate') -> _('Invalid request method');
			return $this -> getResponse() -> setBody(Zend_Json::encode(array('files' => array(0 => array(
						'status' => $status,
						'error' => $error
					)))));
		}

		if (empty($_FILES['files']))
		{
			$status = false;
			$error = Zend_Registry::get('Zend_Translate') -> _('No file');
			return $this -> getResponse() -> setBody(Zend_Json::encode(array('files' => array(0 => array(
						'status' => $status,
						'name' => $error
					)))));
		}
		$name = $_FILES['files']['name'][0];
		$type = explode('/', $_FILES['files']['type'][0]);
		if (!$_FILES['files'] || !is_uploaded_file($_FILES['files']['tmp_name'][0]) || $type[0] != 'image')
		{
			$status = false;
			$error = Zend_Registry::get('Zend_Translate') -> _('Invalid Upload File');
			return $this -> getResponse() -> setBody(Zend_Json::encode(array('files' => array(0 => array(
						'status' => $status,
						'error' => $error,
						'name' => $name
					)))));
		}

		if ($_FILES['files']['size'][0] > 1000 * 1024)
		{
			$status = false;
			$error = Zend_Registry::get('Zend_Translate') -> _('Exceeded filesize limit.');
			return $this -> getResponse() -> setBody(Zend_Json::encode(array('files' => array(0 => array(
						'status' => $status,
						'error' => $error,
						'name' => $name
					)))));
		}
		$temp_file = array(
			'type' => $_FILES['files']['type'][0],
			'tmp_name' => $_FILES['files']['tmp_name'][0],
			'name' => $_FILES['files']['name'][0]
		);
		$photo_id = Engine_Api::_() -> user() -> setPhoto($temp_file, array(
			'parent_type' => 'user',
			'parent_id' => $user -> getIdentity(),
		));

		$status = true;
		$name = $_FILES['files']['name'][0];

		return $this -> getResponse() -> setBody(Zend_Json::encode(array('files' => array(0 => array(
					'status' => $status,
					'name' => $name,
					'photo_id' => $photo_id
				)))));
	}

	public function sublocationsAction()
	{
		$this -> _helper -> layout -> disableLayout();
		$this -> _helper -> viewRenderer -> setNoRender(TRUE);
		$id = $this -> getRequest() -> getParam('location_id');
		if (!$id)
		{
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

	public function getContinentAction()
	{
		$this -> _helper -> layout -> disableLayout();
		$this -> _helper -> viewRenderer -> setNoRender(TRUE);
		$id = $this -> getRequest() -> getParam('location_id');
		$location = Engine_Api::_() -> getItem('user_location', $id);
		if (!$location)
		{
			echo '';
			return;
		}
		else
		{
			echo $location -> getContinent();
			return;
		}
	}

	public function savePreferredClubsAction()
	{
		$this -> _helper -> layout -> disableLayout();
		$this -> _helper -> viewRenderer -> setNoRender(true);

		$userGroupMappingTable = Engine_Api::_() -> getDbTable('groupmappings', 'user');

		$groupIds = $this -> _getParam('ids');
		$user_id = $this -> _getParam('user_id');

		$db = $userGroupMappingTable -> getAdapter();
		$db -> beginTransaction();
		try
		{
			$groupIds = explode(",", $groupIds);
			//delete all before insert
			$userGroupMappingTable -> deleteAllRows($user_id);
			foreach ($groupIds as $group_id)
			{
				$row = $userGroupMappingTable -> getRow($user_id, $group_id);
				if (!isset($row) && empty($row))
				{
					$row = $userGroupMappingTable -> createRow();
					$row -> user_id = $user_id;
					$row -> group_id = $group_id;
					$row -> save();
				}
			}
			$status = 'true';
			$db -> commit();

		}
		catch (Exception $e)
		{
			$db -> rollBack();
			$status = 'false';
		}

		$data = array();
		$data[] = array('status' => $status, );

		return $this -> _helper -> json($data);
	}

	public function suggestGroupAction()
	{
		$this -> _helper -> layout -> disableLayout();
		$this -> _helper -> viewRenderer -> setNoRender(true);
		$table = Engine_Api::_() -> getItemTable('group');

		// Get params
		$text = $this -> _getParam('text', $this -> _getParam('search', $this -> _getParam('value')));
		$limit = (int)$this -> _getParam('limit', 10);

		// Generate query
		$select = Engine_Api::_() -> getItemTable('group') -> select() -> where('search = ?', 1);

		if (null !== $text)
		{
			$select -> where('`' . $table -> info('name') . '`.`title` LIKE ?', '%' . $text . '%');
		}
		
		//query with sport type
		$viewer = Engine_Api::_() -> user() -> getViewer();
		$sportMapsTable = Engine_Api::_() -> getDbTable('sportmaps', 'user');
		$sportMaps = $sportMapsTable -> getSportsOfUser($viewer -> getIdentity(), 0);
		$sportIds = array();
		foreach($sportMaps as $sport) {
			$sportIds[] = $sport -> getIdentity();
		}
		if(count($sportIds)) {
			$select -> where('sportcategory_id IN (?)', $sportIds);
		} else {
			$select -> where("1 = 0");
		}
		
		$select -> limit($limit);

		// Retv data
		$data = array();
		foreach ($select->getTable()->fetchAll($select) as $friend)
		{
			$data[] = array(
				'id' => $friend -> getIdentity(),
				'label' => $friend -> getTitle(), // We should recode this to use title instead
				// of label
				'title' => $friend -> getTitle(),
				'photo' => $this -> view -> itemPhoto($friend, 'thumb.icon'),
				'url' => $friend -> getHref(),
				'type' => 'user',
			);
		}

		// send data
		$data = Zend_Json::encode($data);
		$this -> getResponse() -> setBody($data);
	}
	
	 public function suggestUserAction() {
        $this -> _helper -> layout -> disableLayout();
        $this -> _helper -> viewRenderer -> setNoRender(true);
        $table = Engine_Api::_()->getItemTable('user');
    
        // Get params
        $text = $this->_getParam('text', $this->_getParam('search', $this->_getParam('value')));
        $limit = (int) $this->_getParam('limit', 10);
    
        // Generate query
        $select = Engine_Api::_()->getItemTable('user')->select()->where('search = ?', 1);
    
        if( null !== $text ) {
            $select->where('`'.$table->info('name').'`.`displayname` LIKE ?', '%'. $text .'%');
        }
        $select->limit($limit);
    
        // Retv data
        $data = array();
        foreach( $select->getTable()->fetchAll($select) as $friend ){
            $data[] = array(
                'id' => $friend->getIdentity(),
                'label' => $friend->getTitle(), // We should recode this to use title instead of label
                'title' => $friend->getTitle(),
                'photo' => $this->view->itemPhoto($friend, 'thumb.icon'),
                'url' => $friend->getHref(),
                'type' => 'user',
            );
        }
    
        // send data
        $data = Zend_Json::encode($data);
        $this->getResponse()->setBody($data);
    }

	public function suggestUserBlockAction() {
        $this -> _helper -> layout -> disableLayout();
        $this -> _helper -> viewRenderer -> setNoRender(true);
        $table = Engine_Api::_()->getItemTable('user');
    	$user = Engine_Api::_()->user()->getViewer();
        // Get params
        $text = $this->_getParam('text', $this->_getParam('search', $this->_getParam('value')));
        $limit = (int) $this->_getParam('limit', 10);
    
        // Generate query
        $select = Engine_Api::_()->getItemTable('user')->select()->where('search = ?', 1);
    	$select -> where('user_id <> ?', $user -> getIdentity());
		// get user blocked
		$blockedUsers = array();
		foreach ($user->getBlockedUsers() as $blocked_user_id) 
		{
			$blockedUsers[] = $blocked_user_id;
		}
		if($blockedUsers)
		{
			$select -> where('user_id NOT IN (?)', $blockedUsers);
		}
        if( null !== $text ) 
        {
            $select->where('`'.$table->info('name').'`.`displayname` LIKE ?', '%'. $text .'%');
        }
        $select->limit($limit);
    
        // Retv data
        $data = array();
        foreach( $select->getTable()->fetchAll($select) as $friend ){
            $data[] = array(
                'id' => $friend->getIdentity(),
                'label' => $friend->getTitle(), // We should recode this to use title instead of label
                'title' => $friend->getTitle(),
                'photo' => $this->view->itemPhoto($friend, 'thumb.icon'),
                'url' => $friend->getHref(),
                'type' => 'user',
            );
        }
    
        // send data
        $data = Zend_Json::encode($data);
        $this->getResponse()->setBody($data);
    }
	public function blockUsersAction()
	{
		$this -> _helper -> layout -> disableLayout();
		$this -> _helper -> viewRenderer -> setNoRender(true);

		$userIds = $this -> _getParam('ids');
		$viewer = Engine_Api::_()->user()->getViewer();
		
		$db = Engine_Api::_()->getDbtable('block', 'user')->getAdapter();
		$db -> beginTransaction();
		try
		{
			$userIds = explode(",", $userIds);
			foreach ($userIds as $user_id)
			{
				$user = Engine_Api::_()->getItem('user', $user_id);
		        $viewer->addBlock($user);
		        if( $user->membership()->isMember($viewer, null) ) 
		        {
		        	$user->membership()->removeMember($viewer);
		      	}
			      
		      	try 
		      	{
			        // Set the requests as handled
			        $notification = Engine_Api::_()->getDbtable('notifications', 'activity')
			          ->getNotificationBySubjectAndType($viewer, $user, 'friend_request');
			        if( $notification ) 
			        {
			          $notification->mitigated = true;
			          $notification->read = 1;
			          $notification->save();
			        }
			        $notification = Engine_Api::_()->getDbtable('notifications', 'activity')
			            ->getNotificationBySubjectAndType($viewer, $user, 'friend_follow_request');
			        if( $notification ) 
			        {
			          $notification->mitigated = true;
			          $notification->read = 1;
			          $notification->save();
			        }
		      	} 
		      	catch( Exception $e ) {}
			}
			$status = 'true';
			$db -> commit();

		}
		catch (Exception $e)
		{
			$db -> rollBack();
			$status = 'false';
		}

		$data = array();
		$data[] = array('status' => $status, );

		return $this -> _helper -> json($data);
	}
	public function saveBasicAction() {
		$this -> _helper -> layout -> disableLayout();
        $this -> _helper -> viewRenderer -> setNoRender(true);
		$user = Engine_Api::_()->user()->getViewer();
		
		$aliasedFields = $user->fields()->getFieldsObjectsByAlias();
    	$topLevelId = 0;
    	$topLevelValue = null;
    	if( isset($aliasedFields['profile_type']) ) {
      		$aliasedFieldValue = $aliasedFields['profile_type']->getValue($user);
      		$topLevelId = $aliasedFields['profile_type']->field_id;
      		$topLevelValue = ( is_object($aliasedFieldValue) ? $aliasedFieldValue->value : null );
      		if( !$topLevelId || !$topLevelValue ) {
        		$topLevelId = null;
        		$topLevelValue = null;
      		}
    	}
    
    	// Get form
    	$form = $this->view->form = new Fields_Form_Standard(array(
      		'item' => $user,
      		'topLevelId' => $topLevelId,
      		'topLevelValue' => $topLevelValue,
    	));
    	//$form->generate();
    
		$countriesAssoc = Engine_Api::_()->getDbTable('locations', 'user')->getLocationsAssoc(0);
		$countriesAssoc = array('0'=>'') + $countriesAssoc;
	
		$provincesAssoc = array();
		$country_id = $this->_getParam('country_id', 0);
		if ($country_id) {
			$provincesAssoc = Engine_Api::_()->getDbTable('locations', 'user')->getLocationsAssoc($country_id);
			$provincesAssoc = array('0'=>'') + $provincesAssoc;
		}
	
		$form->addElement('Select', 'country_id', array(
			'label' => 'Country',
			'multiOptions' => $countriesAssoc,
			'value' => $country_id
		));
	
		$citiesAssoc = array();
		$province_id = $this->_getParam('province_id', 0);
		if ($province_id) {
			$citiesAssoc = Engine_Api::_()->getDbTable('locations', 'user')->getLocationsAssoc($province_id);
			$citiesAssoc = array('0'=>'') + $citiesAssoc;
		}
	
		$form->addElement('Select', 'province_id', array(
			'label' => 'Province/State',
			'multiOptions' => $provincesAssoc,
			'value' => $province_id
		));
	
		$city_id = $this->_getParam('city_id', 0);
		$form->addElement('Select', 'city_id', array(
			'label' => 'City',
			'multiOptions' => $citiesAssoc,
			'value' => $city_id
		));
		
		$continent = '';
		$country = Engine_Api::_()->getItem('user_location', $country_id);
		if ($country) $continent = $country->getContinent();
		$form->addElement('Text', 'continent', array(
			'label' => 'Continent',
			'value' => $continent,
			'disabled' => true
		));
		
		$form->setAttrib('id', 'basic_section-form');
		
		$form->submit->addDecorator('ViewHelper');
		
		$form->addElement('Button', 'cancel', array(
	      'label' => 'Cancel',
	      'order' => 10001,
	      'type' => 'button',
	      'class' => 'basic-cancel-btn',
	      'decorators' => array(
	        'ViewHelper'
	      )
	    ));
		
	    $form->addDisplayGroup(array('submit', 'cancel'), 'buttons');
		
		$data = array();
    	if($form->isValid($this->_getAllParams()) ) {
      		$form->saveValues();
	
	  		$values = $this->getRequest()->getPost();
	  		$user->country_id = $values['country_id'];
	  		$user->province_id = $values['province_id'];
	  		$user->city_id = $values['city_id'];
	  
      		// Update display name
      		$aliasValues = Engine_Api::_()->fields()->getFieldsValuesByAlias($user);
     	 	$user->setDisplayName($aliasValues);
      		//$user->modified_date = date('Y-m-d H:i:s');
      		$user->save();

      		// update networks
      		Engine_Api::_()->network()->recalculate($user);
			$data = array('status' => true);
			
  		}
		else {
			$data = array(
				'status' => false,
				'html' => $form->render($this->view)
			);
		}
		
		$data = Zend_Json::encode($data);
        $this->getResponse()->setBody($data);
	}

	public function getCountriesAction() {
		$this -> _helper -> layout -> disableLayout();
		$this -> _helper -> viewRenderer -> setNoRender(TRUE);
		$continent = $this -> getRequest() -> getParam('continent', '');
		$countries = Engine_Api::_() -> getDbTable('locations', 'user') -> getCountriesByContinent($continent);
		$html = '';
		foreach ($countries as $country)
		{
			$html .= '<option value="' . $country -> getIdentity() . '" label="' . $country -> getTitle() . '" >' . $country -> getTitle() . '</option>';
		}
		echo $html;
		return;
	}
}
