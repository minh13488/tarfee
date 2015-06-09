<?php

class Tfcampaign_IndexController extends Core_Controller_Action_Standard
{
	public function indexAction()
	{
		$this -> view -> someVar = 'someVal';
	}

	public function createAction()
	{

		if (!$this -> _helper -> requireUser -> isValid())
			return;
		if (!$this -> _helper -> requireAuth() -> setAuthParams('tfcampaign_campaign', null, 'create') -> isValid())
			return;

		// Render
		//$this -> _helper -> content	-> setEnabled();

		// Create form
		$this -> view -> form = $form = new Tfcampaign_Form_Create();
		if (!$this -> getRequest() -> isPost())
		{
			return;
		}
		
		$posts = $this -> getRequest() -> getPost();
		$viewer = Engine_Api::_() -> user() -> getViewer();
		
		if ($posts['category_id'] == 2)
		{
			$this -> view -> showPreferredFoot = true;
		}
		else
		{
			$this -> view -> showPreferredFoot = false;
		}
		$category_id = $posts['category_id'];
		$sportCattable = Engine_Api::_() -> getDbtable('sportcategories', 'user');
		$node = $sportCattable -> getNode($category_id);
		$categories = $node -> getChilren();
		if (count($categories))
		{
			$position_options = array(0 => '');
			foreach ($categories as $category)
			{
				$position_options[$category -> getIdentity()] = $category -> title;
				$node = $sportCattable -> getNode($category -> getIdentity());
				$positons = $node -> getChilren();
				foreach ($positons as $positon)
				{
					$position_options[$positon -> getIdentity()] = '-- ' . $positon -> title;
				}
			}
			$form -> getElement('position_id') -> setMultiOptions($position_options);
			$this -> view -> showPosition = true;
		}
		else
		{
			$this -> view -> showPosition = false;
		}
		$provincesAssoc = array();
		$country_id = $posts['country_id'];
		if ($country_id) {
			$provincesAssoc = Engine_Api::_()->getDbTable('locations', 'user')->getLocationsAssoc($country_id);
			$provincesAssoc = array('0'=>'') + $provincesAssoc;
		}
		$form -> getElement('province_id') -> setMultiOptions($provincesAssoc);
		
		$citiesAssoc = array();
		$province_id = $posts['province_id'];
		if ($province_id) {
			$citiesAssoc = Engine_Api::_()->getDbTable('locations', 'user')->getLocationsAssoc($province_id);
			$citiesAssoc = array('0'=>'') + $citiesAssoc;
		}
		$form -> getElement('city_id') -> setMultiOptions($citiesAssoc);
		
		
		if (!$form -> isValid($posts)) {
			return;
		}
		
		// Process
		$values = $form -> getValues();
		$values['user_id'] = $viewer -> getIdentity();
		
		//check age params
		if(!empty($values['from_age']) && !empty($values['to_age'])) {
			if($values['from_age'] > $values['to_age']) {
				$form -> addError($this -> view -> translate('Invalid Age'));
				return;
			}
		}
		
		$db = Engine_Api::_() -> getItemTable('tfcampaign_campaign') -> getAdapter();
		$db -> beginTransaction();

		try
		{
			
			//Set viewer time zone
			$oldTz = date_default_timezone_get();
			date_default_timezone_set($viewer -> timezone);
			$start = strtotime($values['start_date']);
			$end = strtotime($values['end_date']);
			date_default_timezone_set($oldTz);
			if($start >= $end) {
				$form -> addError($this -> view -> translate("End Time must be greater than Start Time."));
				return;
			}
			$values['start_date'] = date('Y-m-d H:i:s', $start);
			$values['end_date'] = date('Y-m-d H:i:s', $end);
			
			$table = Engine_Api::_() -> getItemTable('tfcampaign_campaign');
			$campaign = $table -> createRow();
			$values['languages'] = json_encode($values['languages']);
			$campaign -> setFromArray($values);
			$campaign -> save();
			
			if(!empty($values['languages']))
			{
				foreach(json_decode($values['languages']) as $langId)
				{
					 // save language map
					 $mappingTable = Engine_Api::_() -> getDbtable('languagemappings', 'user');
					 $mappingTable -> save($langId, $campaign);
				}
			}
			
			// Set photo
			if (!empty($values['photo']))
			{
				$campaign -> setPhoto($form -> photo);
			}

			//set allow view for specific users
			$user_ids = explode(",", $values['user_ids']);
			$userItemViewTable = Engine_Api::_() -> getDbTable('userItemView', 'user');
			foreach ($user_ids as $user_id)
			{
				$row = $userItemViewTable -> createRow();
				$row -> user_id = $user_id;
				$row -> item_id = $campaign -> getIdentity();
				$row -> item_type = $campaign -> getType();
				$row -> save();
			}

			// CREATE AUTH STUFF HERE
			$auth = Engine_Api::_() -> authorization() -> context;
			$roles = array(
				'owner',
				'owner_member',
				'owner_member_member',
				'owner_network',
				'registered',
				'everyone'
			);
			if (isset($values['auth_view']))
				$auth_view = $values['auth_view'];
			else
				$auth_view = "everyone";
			$viewMax = array_search($auth_view, $roles);
			foreach ($roles as $i => $role)
			{
				$auth -> setAllowed($campaign, $role, 'view', ($i <= $viewMax));
			}


			$db -> commit();

			// Redirect
			return $this -> _forward('success', 'utility', 'core', array(
				'parentRedirect' => Zend_Controller_Front::getInstance() -> getRouter() -> assemble(array(
					'id' => $campaign -> getIdentity(),
					'slug' => $campaign -> getSlug(),
				), 'tfcampaign_profile', true),
				'messages' => array(Zend_Registry::get('Zend_Translate') -> _('Please wait...'))
			));
		}
		catch( Engine_Image_Exception $e )
		{
			$db -> rollBack();
			throw $e;
		}

	}
	
	public function editAction()
	{
		// Render
		//$this -> _helper -> content	-> setEnabled();
		
		if (!$this -> _helper -> requireUser -> isValid())
			return;
		
		$id = $this -> _getParam('id', 0);
		$campaign = Engine_Api::_() -> getItem('tfcampaign_campaign', $id);
		$viewer = Engine_Api::_() -> user() -> getViewer();
		
		if(!$campaign) {
			return $this -> _helper -> requireSubject -> forward();
		}
		
		
		// Create form
		$this -> view -> form = $form = new Tfcampaign_Form_Edit();
		
		//toto check editable
		$allowPrivate = Engine_Api::_()->getApi('settings', 'core')->getSetting('tfcampaign_private_allow', 1);
		if($allowPrivate) 
		{
			// authorization
		    $auth = Engine_Api::_()->authorization()->context;
		    $roles = array('owner', 'owner_member', 'owner_member_member', 'owner_network', 'registered', 'everyone');
		    foreach( $roles as $role )
		    {
		      if( 1 === $auth->isAllowed($campaign, $role, 'view') )
		      {
		        $form->auth_view->setValue($role);
		      }
		    }
		}
		//view for specific users
		$tableUserItemView = Engine_Api::_() -> getDbTable('userItemView', 'user');
		$this -> view -> userViewRows = $userViewRows = $tableUserItemView -> getUserByItem($campaign);
		
		if (!$this -> getRequest() -> isPost())
		{
			$arrCampaign = $campaign -> toArray();
			
			if ($arrCampaign['category_id'] == 2)
			{
				$this -> view -> showPreferredFoot = true;
			}
			else
			{
				$this -> view -> showPreferredFoot = false;
			}
			$category_id = $arrCampaign['category_id'];
			$sportCattable = Engine_Api::_() -> getDbtable('sportcategories', 'user');
			$node = $sportCattable -> getNode($category_id);
			$categories = $node -> getChilren();
			if (count($categories))
			{
				$position_options = array(0 => '');
				foreach ($categories as $category)
				{
					$position_options[$category -> getIdentity()] = $category -> title;
					$node = $sportCattable -> getNode($category -> getIdentity());
					$positons = $node -> getChilren();
					foreach ($positons as $positon)
					{
						$position_options[$positon -> getIdentity()] = '-- ' . $positon -> title;
					}
				}
				$form -> getElement('position_id') -> setMultiOptions($position_options);
				$this -> view -> showPosition = true;
			}
			else
			{
				$this -> view -> showPosition = false;
			}
			
			if (isset($arrCampaign['country_id']))
			{
				$provincesAssoc = array();
				$country_id = $arrCampaign['country_id'];
				if ($country_id) 
				{
					$provincesAssoc = Engine_Api::_()->getDbTable('locations', 'user')->getLocationsAssoc($country_id);
					$provincesAssoc = array('0'=>'') + $provincesAssoc;
				}
				$form -> getElement('province_id') -> setMultiOptions($provincesAssoc);
			}
			
			if (isset($arrCampaign['province_id']))
			{
				$citiesAssoc = array();
				$province_id = $arrCampaign['province_id'];
				if ($province_id) {
					$citiesAssoc = Engine_Api::_()->getDbTable('locations', 'user')->getLocationsAssoc($province_id);
					$citiesAssoc = array('0'=>'') + $citiesAssoc;
				}
				$form -> getElement('city_id') -> setMultiOptions($citiesAssoc);
			}
			$arrCampaign['languages'] = json_decode($arrCampaign['languages']);
			$start = strtotime($arrCampaign['start_date']);
			$end = strtotime($arrCampaign['end_date']);
		    $oldTz = date_default_timezone_get();
		    date_default_timezone_set($viewer->timezone);
		    $start = date('Y-m-d H:i:s', $start);
			$end = date('Y-m-d H:i:s', $end);
		    date_default_timezone_set($oldTz);
			
			$arrCampaign['start_date'] = $start;
			$arrCampaign['end_date'] = $end;
			
			$form -> populate($arrCampaign);
			return;
		}
		$posts = $this -> getRequest() -> getPost();
		if ($posts['category_id'] == 2)
		{
			$this -> view -> showPreferredFoot = true;
		}
		else
		{
			$this -> view -> showPreferredFoot = false;
		}
		$category_id = $posts['category_id'];
		$sportCattable = Engine_Api::_() -> getDbtable('sportcategories', 'user');
		$node = $sportCattable -> getNode($category_id);
		$categories = $node -> getChilren();
		if (count($categories))
		{
			$position_options = array(0 => '');
			foreach ($categories as $category)
			{
				$position_options[$category -> getIdentity()] = $category -> title;
				$node = $sportCattable -> getNode($category -> getIdentity());
				$positons = $node -> getChilren();
				foreach ($positons as $positon)
				{
					$position_options[$positon -> getIdentity()] = '-- ' . $positon -> title;
				}
			}
			$form -> getElement('position_id') -> setMultiOptions($position_options);
			$this -> view -> showPosition = true;
		}
		else
		{
			$this -> view -> showPosition = false;
		}
		
		$provincesAssoc = array();
		$country_id = $posts['country_id'];
		if ($country_id) 
		{
			$provincesAssoc = Engine_Api::_()->getDbTable('locations', 'user')->getLocationsAssoc($country_id);
			$provincesAssoc = array('0'=>'') + $provincesAssoc;
		}
		$form -> getElement('province_id') -> setMultiOptions($provincesAssoc);
		
		$citiesAssoc = array();
		$province_id = $posts['province_id'];
		if ($province_id) {
			$citiesAssoc = Engine_Api::_()->getDbTable('locations', 'user')->getLocationsAssoc($province_id);
			$citiesAssoc = array('0'=>'') + $citiesAssoc;
		}
		$form -> getElement('city_id') -> setMultiOptions($citiesAssoc);
		
		//check valid form
		if (!$form -> isValid($posts)) {
			$this -> view -> error = true;
			return;
		}
		
		// Process
		$values = $form -> getValues();
		$values['user_id'] = $viewer -> getIdentity();
		
		//check age params
		if(!empty($values['from_age']) && !empty($values['to_age'])) {
			if($values['from_age'] > $values['to_age']) {
				$form -> addError($this -> view -> translate('Invalid Age'));
				return;
			}
		}
		
		$db = Engine_Api::_() -> getItemTable('tfcampaign_campaign') -> getAdapter();
		$db -> beginTransaction();

		try
		{
			
			//Set viewer time zone
			$oldTz = date_default_timezone_get();
			date_default_timezone_set($viewer -> timezone);
			$start = strtotime($values['start_date']);
			$end = strtotime($values['end_date']);
			date_default_timezone_set($oldTz);
			if($start >= $end) {
				$form -> addError($this -> view -> translate("End Time must be greater than Start Time."));
				return;
			}
			$values['start_date'] = date('Y-m-d H:i:s', $start);
			$values['end_date'] = date('Y-m-d H:i:s', $end);
			
			$table = Engine_Api::_() -> getItemTable('tfcampaign_campaign');
			$values['languages'] = json_encode($values['languages']);
			$campaign -> setFromArray($values);
			$campaign -> save();
			
			if(!empty($values['languages']))
			{
				foreach(json_decode($values['languages']) as $langId)
				{
					 // save language map
					 $mappingTable = Engine_Api::_() -> getDbtable('languagemappings', 'user');
					 $mappingTable -> save($langId, $campaign);
				}
			}
			
			// Set photo
			if (!empty($values['photo']))
			{
				$campaign -> setPhoto($form -> photo);
			}

			//set allow view for specific users
			$user_ids = explode(",", $values['user_ids']);
			$userItemViewTable = Engine_Api::_() -> getDbTable('userItemView', 'user');
			//delete all before inserting
			$userItemViewTable -> deleteAllRows($campaign);
			foreach ($user_ids as $user_id)
			{
				$row = $userItemViewTable -> createRow();
				$row -> user_id = $user_id;
				$row -> item_id = $campaign -> getIdentity();
				$row -> item_type = $campaign -> getType();
				$row -> save();
			}

			// CREATE AUTH STUFF HERE
			$auth = Engine_Api::_() -> authorization() -> context;
			$roles = array(
				'owner',
				'owner_member',
				'owner_member_member',
				'owner_network',
				'registered',
				'everyone'
			);
			if (isset($values['auth_view']))
				$auth_view = $values['auth_view'];
			else
				$auth_view = "everyone";
			$viewMax = array_search($auth_view, $roles);
			foreach ($roles as $i => $role)
			{
				$auth -> setAllowed($campaign, $role, 'view', ($i <= $viewMax));
			}


			$db -> commit();

			// Redirect
			return $this -> _forward('success', 'utility', 'core', array(
				'parentRedirect' => Zend_Controller_Front::getInstance() -> getRouter() -> assemble(array(
					'id' => $campaign -> getIdentity(),
					'slug' => $campaign -> getSlug(),
				), 'tfcampaign_profile', true),
				'messages' => array(Zend_Registry::get('Zend_Translate') -> _('Please wait...'))
			));
		}
		catch( Engine_Image_Exception $e )
		{
			$db -> rollBack();
			throw $e;
		}

	}
}
