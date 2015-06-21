<?php

/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class User_Form_Signup1_Step1 extends Engine_Form_Email
{  
  public function init()
  {
    $settings = Engine_Api::_()->getApi('settings', 'core');
    $inviteSession = new Zend_Session_Namespace('invite');
    $tabIndex = 1;
    
    // Init form
    $this->setTitle('Create Account');
	
    // Element: email
    $emailElement = $this->addEmailElement(array(
      'label' => 'Email Address',
      'description' => 'You will use your email address to login.',
      'required' => true,
      'allowEmpty' => false,
      'validators' => array(
        array('NotEmpty', true),
        array('EmailAddress', true),
        array('Db_NoRecordExists', true, array(Engine_Db_Table::getTablePrefix() . 'users', 'email'))
      ),
      'filters' => array(
        'StringTrim'
      ),
      // fancy stuff
      'inputType' => 'email',
      'autofocus' => 'autofocus',
      'tabindex' => $tabIndex++,
    ));
    $emailElement->getDecorator('Description')->setOptions(array('placement' => 'APPEND'));
    $emailElement->getValidator('NotEmpty')->setMessage('Please enter a valid email address.', 'isEmpty');
    $emailElement->getValidator('Db_NoRecordExists')->setMessage('Someone has already registered this email address, please use another one.', 'recordFound');

    // Add banned email validator
    $bannedEmailValidator = new Engine_Validate_Callback(array($this, 'checkBannedEmail'), $emailElement);
    $bannedEmailValidator->setMessage("This email address is not available, please use another one.");
    $emailElement->addValidator($bannedEmailValidator);
    
    if( !empty($inviteSession->invite_email) ) {
      $emailElement->setValue($inviteSession->invite_email);
    }
    // Element: code
    if( $settings->getSetting('user.signup.inviteonly') > 0 ) {
      //require code
      $codeValidator = new Engine_Validate_Callback(array($this, 'checkInviteCode'), $emailElement);
      $codeValidator->setMessage("This invite code is invalid or does not match the selected email address");
      $this->addElement('Text', 'code', array(
        'label' => 'Invite Code',
        'required' => true
      ));
      $this->code->addValidator($codeValidator);

      if( !empty($inviteSession->invite_code) ) {
        $this->code->setValue($inviteSession->invite_code);
      }
    } else {
    	 $this->addElement('Text', 'code', array(
	        'label' => 'Invite Code',
	        'description' => 'Enter referral code if you have',
	     ));
    }


	  // Element: password
	  $this->addElement('Password', 'password', array(
	    'label' => 'Password',
	    'description' => 'Passwords must be at least 6 characters in length.',
	    'required' => true,
	    'allowEmpty' => false,
	    'validators' => array(
	      array('NotEmpty', true),
	      array('StringLength', false, array(6, 32)),
	    ),
	    'tabindex' => $tabIndex++,
	  ));
	  $this->password->getDecorator('Description')->setOptions(array('placement' => 'APPEND'));
	  $this->password->getValidator('NotEmpty')->setMessage('Please enter a valid password.', 'isEmpty');


    // Init submit
    $this->addElement('Button', 'submit', array(
      'label' => 'Continue',
      'type' => 'submit',
      'ignore' => true,
      'tabindex' => $tabIndex++,
      'decorators' => array(
        'ViewHelper'
      )
    ));
    
	$this->addElement('Button', 'cancel', array(
      'label' => 'skip',
      'link' => true,
      'prependText' => ' or ',
      'href' => '',
      'onclick' => 'closeRegister();',
      'decorators' => array(
        'ViewHelper'
      )
    ));
	
    $this->addDisplayGroup(array('submit', 'cancel'), 'buttons', array(
      'decorators' => array(
        'FormElements',
        'DivDivDivWrapper',
      ),
    ));
	
    // Set default action
    $this->setAction(Zend_Controller_Front::getInstance()->getRouter()->assemble(array(), 'user_signup1', true));
  }

  public function checkPasswordConfirm($value, $passwordElement)
  {
    return ( $value == $passwordElement->getValue() );
  }

  public function checkInviteCode($value, $emailElement)
  {
    $inviteTable = Engine_Api::_()->getDbtable('invites', 'invite');
    $select = $inviteTable->select()
      ->from($inviteTable->info('name'), 'COUNT(*)')
      ->where('code = ?', $value)
      ;
      
    if( Engine_Api::_()->getApi('settings', 'core')->getSetting('user.signup.checkemail') ) {
      $select->where('recipient LIKE ?', $emailElement->getValue());
    }
    
    return (bool) $select->query()->fetchColumn(0);
  }

  public function checkBannedEmail($value, $emailElement)
  {
    $bannedEmailsTable = Engine_Api::_()->getDbtable('BannedEmails', 'core');
    return !$bannedEmailsTable->isEmailBanned($value);
  }

  public function checkBannedUsername($value, $usernameElement)
  {
    $bannedUsernamesTable = Engine_Api::_()->getDbtable('BannedUsernames', 'core');
    return !$bannedUsernamesTable->isUsernameBanned($value);
  }
}
