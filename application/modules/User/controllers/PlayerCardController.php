<?php
class User_PlayerCardController extends Core_Controller_Action_Standard
{
	public function createAction()
	{
		if (!$this -> _helper -> requireUser -> isValid())
			return;
		if (!$this -> _helper -> requireAuth() -> setAuthParams('group', null, 'create') -> isValid())
			return;
		$viewer = Engine_Api::_() -> user() -> getViewer();
		// Create form
		$this -> view -> form = $form = new User_Form_Playercard_Create();
		if (!$this -> getRequest() -> isPost())
		{
			return;
		}
		
		$posts = $this -> getRequest() -> getPost();
		if($posts['category_id'] == 2)
		{
			$this -> view -> showPreferredFoot = true;
		}
		else {
			$this -> view -> showPreferredFoot = false;
		}
		if($posts['relation_id'] == 0)
		{
			$this -> view -> showOther = true;
		}
		else {
			$this -> view -> showOther = false;
		}
		$category_id = $posts['category_id'];
		$sportCattable = Engine_Api::_() -> getDbtable('sportcategories', 'user');
		$node = $sportCattable -> getNode($category_id);
		$categories = $node -> getChilren();
		if(count($categories))
		{
			$position_options = array(0 => '');
			foreach ($categories as $category) 
			{
				$position_options[$category -> getIdentity()] = $category -> title;
				$node = $sportCattable -> getNode($category -> getIdentity());
				$positons =  $node -> getChilren();
				foreach($positons as $positon)
				{
					$position_options[$positon -> getIdentity()] = '-- '.$positon -> title;
				}
			}
			$form -> getElement('position_id') -> setMultiOptions($position_options);
			$this -> view -> showPosition = true;
		}
		else
		{
			$this -> view -> showPosition = false;
		}

		if (!$form -> isValid($posts))
		{
			return;
		}

		// Process
		$values = $form -> getValues();
		if(Engine_Api::_()->getApi('settings', 'core')->getSetting('user.relation_require', 1) 
		&& $values['relation_id'] == 0 
		&& empty($values['relation_other']))
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

			$db -> commit();

			// Redirect
			$pageURL = 'http';
			if (isset($_SERVER["HTTPS"]) && $_SERVER["HTTPS"] == "on")
			{
				$pageURL .= "s";
			}
			$pageURL .= "://";
			return $this -> _helper -> redirector -> gotoUrl($pageURL.$_SERVER['HTTP_HOST'] . $viewer -> getHref());
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
		if (!$this -> getRequest() -> isPost())
		{
			if($player_card -> relation_id == 0)
			{
				$this -> view -> showOther = true;
			}
			$form -> populate($player_card -> toArray());
			return;
		}
		$posts = $this -> getRequest() -> getPost();
		if($posts['category_id'] == 2)
		{
			$this -> view -> showPreferredFoot = true;
		}
		else {
			$this -> view -> showPreferredFoot = false;
		}
		if($posts['relation_id'] == 0)
		{
			$this -> view -> showOther = true;
		}
		else {
			$this -> view -> showOther = false;
		}
		$category_id = $posts['category_id'];
		$sportCattable = Engine_Api::_() -> getDbtable('sportcategories', 'user');
		$node = $sportCattable -> getNode($category_id);
		$categories = $node -> getChilren();
		if(count($categories))
		{
			$position_options = array(0 => '');
			foreach ($categories as $category) 
			{
				$position_options[$category -> getIdentity()] = $category -> title;
				$node = $sportCattable -> getNode($category -> getIdentity());
				$positons =  $node -> getChilren();
				foreach($positons as $positon)
				{
					$position_options[$positon -> getIdentity()] = '-- '.$positon -> title;
				}
			}
			$form -> getElement('position_id') -> setMultiOptions($position_options);
			$this -> view -> showPosition = true;
		}
		else
		{
			$this -> view -> showPosition = false;
		}
		
		if (!$form -> isValid($posts))
		{
			return;
		}
		$values = $form -> getValues();
		if(Engine_Api::_()->getApi('settings', 'core')->getSetting('uaer.relation_require', 1) && $values['relation_id'] == 0 && empty($values['relation_other']))
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

			// Commit
			$db -> commit();
			// Redirect
			$pageURL = 'http';
			if (isset($_SERVER["HTTPS"]) && $_SERVER["HTTPS"] == "on")
			{
				$pageURL .= "s";
			}
			$pageURL .= "://";
			return $this -> _helper -> redirector -> gotoUrl($pageURL.$_SERVER['HTTP_HOST'] . $viewer -> getHref());
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
			$html .= '<option value="' . $category -> getIdentity() . '" label="' . $category -> title . '" >' .$category -> title . '</option>';
			$node = $sportCattable -> getNode($category -> getIdentity());
			$positions = $node -> getChilren();
			foreach ($positions as $position)
			{
				$html .= '<option value="' . $position -> getIdentity() . '" label="-- ' . $position -> title . '" >' . '-- ' .$position -> title . '</option>';
			}
		}
		echo $html;
		return;
	}
}
?>
