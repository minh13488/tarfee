<?php
class User_PlayerCardController extends Core_Controller_Action_Standard
{
	public function init()
	{
		if (!$this -> _helper -> requireAuth() -> setAuthParams('user_playercard', null, 'view') -> isValid())
			return;

		$id = $this -> _getParam('player_id', $this -> _getParam('id', null));
		if ($id)
		{
			$playerCard = Engine_Api::_() -> getItem('user_playercard', $id);
			if ($playerCard)
			{
				Engine_Api::_() -> core() -> setSubject($playerCard);
			}
		}
		if (!$this -> _helper -> requireAuth() -> setAuthParams('user_playercard', null, 'view') -> isValid())
			return;
	}

	public function createAction()
	{
		if (!$this -> _helper -> requireUser -> isValid())
			return;
		$viewer = Engine_Api::_() -> user() -> getViewer();
		// Create form
		$this -> view -> form = $form = new User_Form_Playercard_Create();
		if (!$this -> getRequest() -> isPost())
		{
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
		if ($posts['relation_id'] == 0)
		{
			$this -> view -> showOther = true;
		}
		else
		{
			$this -> view -> showOther = false;
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

		if (!$form -> isValid($posts))
		{
			return;
		}

		// Process
		$values = $form -> getValues();
		if (Engine_Api::_() -> getApi('settings', 'core') -> getSetting('user.relation_require', 1) && $values['relation_id'] == 0 && empty($values['relation_other']))
		{
			$form -> getElement('relation_other') -> addError('Please complete this field - it is required.');
			return false;
		}

		$values['user_id'] = $viewer -> getIdentity();

		$db = Engine_Api::_() -> getDbtable('playercards', 'user') -> getAdapter();
		$db -> beginTransaction();

		try
		{
			// Create group
			$table = Engine_Api::_() -> getDbtable('playercards', 'user');
			$player_card = $table -> createRow();
			$player_card -> setFromArray($values);
			$player_card -> save();

			// Set photo
			if (!empty($values['photo']))
			{
				$player_card -> setPhoto($form -> photo);
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
				$auth -> setAllowed($player_card, $role, 'view', ($i <= $viewMax));
			}

			$roles = array(
				'owner',
				'owner_member',
				'owner_member_member',
				'owner_network',
				'registered',
				'everyone'
			);
			if (isset($values['auth_comment']))
				$auth_comment = $values['auth_comment'];
			else
				$auth_comment = "everyone";
			$commentMax = array_search($auth_comment, $roles);
			foreach ($roles as $i => $role)
			{
				$auth -> setAllowed($player_card, $role, 'comment', ($i <= $commentMax));
			}

			$db -> commit();

			// Redirect
			$pageURL = 'http';
			if (isset($_SERVER["HTTPS"]) && $_SERVER["HTTPS"] == "on")
			{
				$pageURL .= "s";
			}
			$pageURL .= "://";
			return $this -> _helper -> redirector -> gotoUrl($pageURL . $_SERVER['HTTP_HOST'] . $viewer -> getHref());
		}
		catch( Engine_Image_Exception $e )
		{
			$db -> rollBack();
			$form -> addError(Zend_Registry::get('Zend_Translate') -> _('The image you selected was too large.'));
		}
		catch( Exception $e )
		{
			$db -> rollBack();
			throw $e;
		}
	}

	public function editAction()
	{
		if (!$this -> _helper -> requireUser -> isValid())
			return;
		$id = $this -> _getParam('id', 0);
		$player_card = Engine_Api::_() -> getItem('user_playercard', $id);
		$viewer = Engine_Api::_() -> user() -> getViewer();
		if (!$player_card || $viewer -> getIdentity() != $player_card -> user_id)
		{
			return $this -> _forward('requireauth', 'error', 'core');
		}

		$this -> view -> form = $form = new User_Form_Playercard_Edit();
		
		// authorization
	    $auth = Engine_Api::_()->authorization()->context;
	    $roles = array('owner', 'owner_member', 'owner_member_member', 'owner_network', 'registered', 'everyone');
	    foreach( $roles as $role )
	    {
	      if( 1 === $auth->isAllowed($player_card, $role, 'view') )
	      {
	        $form->auth_view->setValue($role);
	      }
		   if( 1 === $auth->isAllowed($player_card, $role, 'comment') )
	      {
	        $form->auth_comment->setValue($role);
	      }
	    }
		
		if (!$this -> getRequest() -> isPost())
		{
			if ($player_card -> relation_id == 0)
			{
				$this -> view -> showOther = true;
			}
			$arr_player = $player_card -> toArray();
			$form -> populate($arr_player);
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
		if ($posts['relation_id'] == 0)
		{
			$this -> view -> showOther = true;
		}
		else
		{
			$this -> view -> showOther = false;
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
		
		if (!$form -> isValid($posts))
		{
			return;
		}
		$values = $form -> getValues();
		if (Engine_Api::_() -> getApi('settings', 'core') -> getSetting('uaer.relation_require', 1) && $values['relation_id'] == 0 && empty($values['relation_other']))
		{
			$form -> getElement('relation_other') -> addError('Please complete this field - it is required.');
			return false;
		}

		// Process
		$db = Engine_Api::_() -> getItemTable('user_playercard') -> getAdapter();
		$db -> beginTransaction();

		try
		{
			// Set group info
			$player_card -> setFromArray($values);
			$player_card -> save();

			if (!empty($values['photo']))
			{
				$player_card -> setPhoto($form -> photo);
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
			if ($values['auth_view'])
				$auth_view = $values['auth_view'];
			else
				$auth_view = "everyone";
			$viewMax = array_search($auth_view, $roles);
			foreach ($roles as $i => $role)
			{
				$auth -> setAllowed($player_card, $role, 'view', ($i <= $viewMax));
			}

			$roles = array(
				'owner',
				'owner_member',
				'owner_member_member',
				'owner_network',
				'registered',
				'everyone'
			);
			if ($values['auth_comment'])
				$auth_comment = $values['auth_comment'];
			else
				$auth_comment = "everyone";
			$commentMax = array_search($auth_comment, $roles);
			foreach ($roles as $i => $role)
			{
				$auth -> setAllowed($player_card, $role, 'comment', ($i <= $commentMax));
			}

			// Rebuild privacy
			$actionTable = Engine_Api::_() -> getDbtable('actions', 'activity');
			foreach ($actionTable->getActionsByObject($player_card) as $action)
			{
				$actionTable -> resetActivityBindings($action);
			}
			// Commit
			$db -> commit();
			// Redirect
			$pageURL = 'http';
			if (isset($_SERVER["HTTPS"]) && $_SERVER["HTTPS"] == "on")
			{
				$pageURL .= "s";
			}
			$pageURL .= "://";
			return $this -> _helper -> redirector -> gotoUrl($pageURL . $_SERVER['HTTP_HOST'] . $viewer -> getHref());
		}
		catch( Engine_Image_Exception $e )
		{
			$db -> rollBack();
			$form -> addError(Zend_Registry::get('Zend_Translate') -> _('The image you selected was too large.'));
		}
		catch( Exception $e )
		{
			$db -> rollBack();
			throw $e;
		}
	}

	public function deleteAction()
	{
		if (!$this -> _helper -> requireUser -> isValid())
			return;
		$id = $this -> _getParam('id', 0);
		$player_card = Engine_Api::_() -> getItem('user_playercard', $id);
		$viewer = Engine_Api::_() -> user() -> getViewer();
		if (!$player_card || $viewer -> getIdentity() != $player_card -> user_id)
		{
			return $this -> _forward('requireauth', 'error', 'core');
		}

		$this -> view -> form = $form = new User_Form_Playercard_Delete();

		if (!$this -> getRequest() -> isPost())
		{
			return;
		}

		if (!$form -> isValid($this -> getRequest() -> getPost()))
		{
			return;
		}

		$table = Engine_Api::_() -> getItemTable('user_playercard');
		$db = $table -> getAdapter();
		$db -> beginTransaction();

		try
		{
			$player_card -> delete();
			$db -> commit();
		}

		catch( Exception $e )
		{
			$db -> rollBack();
			throw $e;
		}
		return $this -> _forward('success', 'utility', 'core', array(
			'messages' => array(Zend_Registry::get('Zend_Translate') -> _('Player card deleted.')),
			'layout' => 'default-simple',
			'parentRefresh' => true,
		));
	}

	public function subcategoriesAction()
	{
		$this -> _helper -> layout -> disableLayout();
		$this -> _helper -> viewRenderer -> setNoRender(TRUE);
		$cat_id = $this -> getRequest() -> getParam('cat_id');
		$sportCattable = Engine_Api::_() -> getDbtable('sportcategories', 'user');
		$node = $sportCattable -> getNode($cat_id);
		$categories = $node -> getChilren();
		$html = '';
		foreach ($categories as $category)
		{
			$html .= '<option value="' . $category -> getIdentity() . '" label="' . $category -> title . '" >' . $category -> title . '</option>';
			$node = $sportCattable -> getNode($category -> getIdentity());
			$positions = $node -> getChilren();
			foreach ($positions as $position)
			{
				$html .= '<option value="' . $position -> getIdentity() . '" label="-- ' . $position -> title . '" >' . '-- ' . $position -> title . '</option>';
			}
		}
		echo $html;
		return;
	}

	public function viewAction()
	{
		if (!$this -> _helper -> requireSubject() -> isValid())
			return;

		$playerCard = Engine_Api::_() -> core() -> getSubject('user_playercard');
		$viewer = Engine_Api::_() -> user() -> getViewer();
		
		//check view auth
		if(!$playerCard -> isViewable()) {
			return $this -> _helper -> requireAuth() -> forward();
		}
		
		// Check if edit/delete is allowed
		$this -> view -> can_edit = $can_edit = $this -> _helper -> requireAuth() -> setAuthParams($playerCard, null, 'edit') -> checkRequire();
		$this -> view -> can_delete = $can_delete = $this -> _helper -> requireAuth() -> setAuthParams($playerCard, null, 'delete') -> checkRequire();

		$this -> view -> viewer_id = $viewer -> getIdentity();
		$this -> view -> playerCard = $playerCard;

		// Render
		$this -> _helper -> content -> setEnabled();
	}

	public function cropPhotoAction()
	{
		$this -> view -> user = $user = Engine_Api::_() -> core() -> getSubject();
		$this -> view -> viewer = $viewer = Engine_Api::_() -> user() -> getViewer();

		// Get form
		$this -> view -> form = $form = new User_Form_Edit_CropPhoto();

		if (!$this -> getRequest() -> isPost())
		{
			return;
		}

		if (!$form -> isValid($this -> getRequest() -> getPost()))
		{
			return;
		}
		// Resizing a photo
		if ($form -> getValue('coordinates') !== '')
		{
			$storage = Engine_Api::_() -> storage();

			$iMain = $storage -> get($user -> photo_id, 'thumb.main');
			$iProfile = $storage -> get($user -> photo_id, 'thumb.profile');

			// Read into tmp file
			$pName = $iMain -> getStorageService() -> temporary($iMain);
			$iName = dirname($pName) . '/nis_' . basename($pName);

			list($x, $y, $w, $h) = explode(':', $form -> getValue('coordinates'));

			$image = Engine_Image::factory();
			$image -> open($pName) -> resample($x + .1, $y + .1, $w - .1, $h - .1, 200, 200) -> write($iName) -> destroy();

			$iProfile -> store($iName);

			// Remove temp files
			@unlink($iName);
		}
		$this->_forward('success', 'utility', 'core', array(
	      'smoothboxClose' => true,
	      'parentRefresh' => true,
	      'messages' => array(Zend_Registry::get('Zend_Translate')->_('Your changes have been saved.'))
	    ));
	}

}
?>
