<?php
class User_LibraryController extends Core_Controller_Action_Standard
{
	public function init() {
		
		// Return if guest try to access to create link.
		if (!$this -> _helper -> requireUser -> isValid())
			return;
	}
	
	public function moveToSubAction(){
		$viewer = Engine_Api::_() -> user() -> getViewer();
		$videoID = $this ->_getParam('id');
		$libraryID = $this ->_getParam('libid');
		
		$library = Engine_Api::_() -> getItem('user_library', $libraryID);
		$mainLibrary = $viewer -> getMainLibrary();	
		$subLibraries = $mainLibrary -> getSubLibrary();
		
		$this -> view -> form = $form = new User_Form_Library_MoveToSub(array('library' => $library, 'subs' => $subLibraries));
		
		if (!$this -> getRequest() -> isPost()) {
			return;
		}
		
		$posts = $this -> getRequest() -> getPost();
		if (!$form -> isValid($posts)) {
			return;
		}
		
		$values = $form -> getValues();
		$move_to = $values['move_to'];
		$mappingTable = Engine_Api::_() -> getDbTable('mappings', 'user');
		$db = $mappingTable -> getAdapter();
		$db -> beginTransaction();

		try
		{
			
			//get Row Mapping and update to move to user
			$mappingRow = $mappingTable -> getRow($libraryID, 'user_library', $videoID, 'video');
			if($mappingRow) {
				$mappingRow -> owner_id = $move_to;
				$mappingRow -> save();
			}
			$db -> commit();
		} catch( Exception $e )	{
			$db -> rollBack();
			throw $e;
		}
		
		$this -> _forward('success', 'utility', 'core', array(
				'closeSmoothbox' => true,
				'parentRefresh' => true,
				'messages' => array(Zend_Registry::get('Zend_Translate') -> _($this -> view -> translate('Move Contents Success...')))
		));
	} 
	
	public function giveOwnershipAction(){
		$viewer = Engine_Api::_() -> user() -> getViewer();
		$videoID = $this ->_getParam('id');
		$libraryID = $this ->_getParam('libid');
		
		$mainLibrary = $viewer -> getMainLibrary();	
		$subLibraries = $mainLibrary -> getSubLibrary();
		
		$this -> view -> form = $form = new User_Form_Library_GiveOwnerShip();
		
		if (!$this -> getRequest() -> isPost()) {
			return;
		}
		
		$posts = $this -> getRequest() -> getPost();
		if (!$form -> isValid($posts)) {
			return;
		}
		
		$values = $form -> getValues();
		$move_to = $values['move_to'];
		$mappingTable = Engine_Api::_() -> getDbTable('mappings', 'user');
		$db = $mappingTable -> getAdapter();
		$db -> beginTransaction();

		try
		{
			//save video user_id
			$video = Engine_Api::_() -> getItem('video', $videoID);
			if($video) {
				$video -> owner_id = $move_to;
				$video -> save();
			}
			
			//get move to user
			$user = Engine_Api::_() -> getItem('user', $move_to);
			
			//get mainlibrary of move to user
			$mainLibrary = $user -> getMainLibrary();
			
			//get Row Mapping and update to move to user
			$mappingRow = $mappingTable -> getRow($libraryID, 'user_library', $videoID, 'video');
			if($mappingRow) {
				$mappingRow -> owner_id = $mainLibrary -> getIdentity();
				$mappingRow -> save();
			}
			$db -> commit();
		} catch( Exception $e )	{
			$db -> rollBack();
			throw $e;
		}
		
		$this -> _forward('success', 'utility', 'core', array(
				'closeSmoothbox' => true,
				'parentRefresh' => true,
				'messages' => array(Zend_Registry::get('Zend_Translate') -> _($this -> view -> translate('Give OwnerShip Success...')))
		));
	} 
	
	public function createSubLibraryAction() 
	{
		$this -> view -> form = $form = new User_Form_Library_Create();
		$viewer = Engine_Api::_() -> user() -> getViewer();
		$mainlibrary = $viewer -> getMainLibrary();		
		if (!$this -> getRequest() -> isPost()) {
			return;
		}
		
		$posts = $this -> getRequest() -> getPost();
		if (!$form -> isValid($posts)) {
			return;
		}
		
		$values = $form -> getValues();
		$values['parent_id'] = $mainlibrary -> getIdentity();
		$values['user_id'] = $viewer -> getIdentity();
		$values['level'] = 1;
		
		$libraryTable = Engine_Api::_() -> getItemTable('user_library');
		$library = $libraryTable -> createRow();
		$library->setFromArray($values);
		$library->save();
		
		// CREATE AUTH STUFF HERE
	      $auth = Engine_Api::_()->authorization()->context;
	      $roles = array('owner', 'owner_member', 'owner_member_member', 'owner_network', 'registered', 'everyone');
	      if(isset($values['auth_view'])) $auth_view =$values['auth_view'];
	      else $auth_view = "everyone";
	      $viewMax = array_search($auth_view, $roles);
	      foreach( $roles as $i=>$role )
	      {
	        $auth->setAllowed($library, $role, 'view', ($i <= $viewMax));
	      }
		
		$this -> _forward('success', 'utility', 'core', array(
				'closeSmoothbox' => true,
				'parentRefresh' => true,
				'messages' => array(Zend_Registry::get('Zend_Translate') -> _($this -> view -> translate('Adding Sub Library Success...')))
		));
		
	}
	
	public function editAction() 
	{
		$this -> view -> form = $form = new User_Form_Library_Edit();
		$viewer = Engine_Api::_() -> user() -> getViewer();
		
		$library = Engine_Api::_() -> getItem('user_library',  $this ->_getParam('id'));
		$form -> populate($library -> toArray());
		
		// authorization
	    $auth = Engine_Api::_()->authorization()->context;
	    $roles = array('owner', 'owner_member', 'owner_member_member', 'owner_network', 'registered', 'everyone');
	    foreach( $roles as $role )
	    {
	      if( 1 === $auth->isAllowed($library, $role, 'view') )
	      {
	        $form->auth_view->setValue($role);
	      }
	    }
		
		if(!$library) {
			return $this->_helper->requireSubject()->forward();
		}
		
		if (!$this -> getRequest() -> isPost()) {
			return;
		}
		
		$posts = $this -> getRequest() -> getPost();
		if (!$form -> isValid($posts)) {
			return;
		}
		
		$values = $form -> getValues();
		$library->setFromArray($values);
		$library->save();
		
		// CREATE AUTH STUFF HERE
	      $auth = Engine_Api::_()->authorization()->context;
	      $roles = array('owner', 'owner_member', 'owner_member_member', 'owner_network', 'registered', 'everyone');
	      if(isset($values['auth_view'])) $auth_view =$values['auth_view'];
	      else $auth_view = "everyone";
	      $viewMax = array_search($auth_view, $roles);
	      foreach( $roles as $i=>$role )
	      {
	        $auth->setAllowed($library, $role, 'view', ($i <= $viewMax));
	      }
		
		$this -> _forward('success', 'utility', 'core', array(
				'closeSmoothbox' => true,
				'parentRefresh' => true,
				'messages' => array(Zend_Registry::get('Zend_Translate') -> _($this -> view -> translate('Editting Sub Library Success...')))
		));
	}
	
	public function deleteAction() 
	{
		
		$viewer = Engine_Api::_() -> user() -> getViewer();
		$library = Engine_Api::_() -> getItem('user_library',  $this ->_getParam('id'));
		$mainLibrary = $viewer -> getMainLibrary();	
		$subLibraries = $mainLibrary -> getSubLibrary();
		
		$this -> view -> form = $form = new User_Form_Library_Delete(array('library'=>$library, 'subs' => $subLibraries));
		if(!$library) {
			return $this->_helper->requireSubject()->forward();
		}
		
		if (!$this -> getRequest() -> isPost()) {
			return;
		}
		
		$posts = $this -> getRequest() -> getPost();
		if (!$form -> isValid($posts)) {
			return;
		}
		
		//get table 
		$mappingTable = Engine_Api::_()->getDbTable('mappings', 'user');
		
		//get videos mapping of library
		$params = array();
	    $params['owner_type'] = $library -> getType();
		$params['owner_id'] = $library -> getIdentity();
		$videoMappings = $mappingTable -> getItemsMapping('video', $params);
		
		$db = $mappingTable -> getAdapter();
		$db -> beginTransaction();

		try
		{
			if(isset($posts['move_to']) && !empty($posts['move_to']) && $posts['move_to'] != '0') {
				//move videos of delete library to other
			    foreach($videoMappings as $videoMapping) {
			    	$videoMapping -> owner_id = $posts['move_to'];
			    	$videoMapping -> save();
			    }
			
			}
			else{
				//delete all
				foreach($videoMappings as $videoMapping) {
				    	$videoMapping -> delete();
			    }
		    }
			$library -> delete();
			$db -> commit();
		}
		catch( Exception $e )
		{
			$db -> rollBack();
			throw $e;
		}
		
		
		
		$this -> _forward('success', 'utility', 'core', array(
				'closeSmoothbox' => true,
				'parentRefresh' => true,
				'messages' => array(Zend_Registry::get('Zend_Translate') -> _($this -> view -> translate('Delete Sub Library Success...')))
		));
	}
}
