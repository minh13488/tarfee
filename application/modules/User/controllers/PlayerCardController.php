<?php
class User_PlayerCardController extends Core_Controller_Action_Standard {
	public function createAction()
	{
		if( !$this->_helper->requireUser->isValid() )
        return;
    	if( !$this->_helper->requireAuth()->setAuthParams('group', null, 'create')->isValid() )
       	 return;

	    // Create form
	    $this->view->form = $form = new User_Form_Playercard_Create();
	
	    if( !$this->getRequest()->isPost() ) {
	      return;
	    }
	
	    if( !$form->isValid($this->getRequest()->getPost()) ) {
	      return;
	    }

	    // Process
	    $values = $form->getValues();
	    $viewer = Engine_Api::_()->user()->getViewer();
	    $values['user_id'] = $viewer->getIdentity();
	
	    $db = Engine_Api::_()->getDbtable('playercards', 'user')->getAdapter();
	    $db->beginTransaction();
	
	    try {
	      // Create group
	      $table = Engine_Api::_()->getDbtable('playercards', 'user');
	      $player_card = $table->createRow();
	      $player_card->setFromArray($values);
	      $player_card->save();
		  
	      // Set photo
	      if( !empty($values['photo']) ) {
	        $player_card->setPhoto($form->photo);
	      }
	
	      $db->commit();
	
	      // Redirect
	      return $this->_helper->redirector->gotoUrl($viewer -> getHref());
	    } catch( Engine_Image_Exception $e ) {
	      $db->rollBack();
		  echo $e -> getMessage();
	      $form->addError(Zend_Registry::get('Zend_Translate')->_('The image you selected was too large.'));
	    } catch( Exception $e ) {
	      $db->rollBack();
	      throw $e;
	    }
	}
}
?>
