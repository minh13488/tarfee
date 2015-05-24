<?php
class User_AdminYoutubeController extends Core_Controller_Action_Admin
{
  public function settingsAction()
  {
  	// Make form
    $settings = Engine_Api::_()->getApi('settings', 'core');
     $this->view->form = $form = new User_Form_Admin_Youtube_Global();
     if ($this->getRequest()->isPost()&& $form->isValid($this->getRequest()->getPost())) {
        $values = $form->getValues();
        foreach ($values as $key => $value) {
            $settings->setSetting($key, $value);
        }
        $form->addNotice('Your changes have been saved.'); 
    }
  }
  
  public function tokenAction()
  {
		$this -> _helper -> layout -> disableLayout();
		$this -> _helper -> viewRenderer -> setNoRender(true);
		$redirect = filter_var('http://' . $_SERVER['HTTP_HOST'] . $_SERVER['PHP_SELF'],
		    FILTER_SANITIZE_URL);
		 $redirect = str_replace("index.php", "admin/user/youtube/settings?code=".$this->_getParam('code'), $redirect);   
		header('Location: ' . $redirect);
		
  }
  
}
