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

		$viewer = Engine_Api::_() -> user() -> getViewer();
		$parent_type = $this -> _getParam('parent_type');
		$parent_id = $this -> _getParam('parent_id', $this -> _getParam('subject_id'));

		// Create form
		$this -> view -> form = $form = new Tfcampaign_Form_Create();

		// Check method and data validity.
		$posts = $this -> getRequest() -> getPost();
		if (!$this -> getRequest() -> isPost()) {
			return;
		}
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
			$campaign -> setFromArray($values);
			$campaign -> save();


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

}
