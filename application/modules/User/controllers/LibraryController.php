<?php
class User_LibraryController extends Core_Controller_Action_Standard
{
	public function init() {
		
		// Return if guest try to access to create link.
		if (!$this -> _helper -> requireUser -> isValid())
			return;
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
		
		$this -> _forward('success', 'utility', 'core', array(
				'closeSmoothbox' => true,
				'parentRefresh' => true,
				'messages' => array(Zend_Registry::get('Zend_Translate') -> _($this -> view -> translate('Editting Sub Library Success...')))
		));
	}
}
