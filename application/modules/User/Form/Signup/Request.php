<?php
class User_Form_Signup_Request extends Engine_Form
{
  public function init()
  {
    // Init form
    $this->setTitle('Request Invite');
    $this->setDescription($description);
    $this->setAttrib('id', 'user_form_request');
    $this->loadDefaultDecorators();
    $this->getDecorator('Description')->setOption('escape', false);
  	// init email
    $this->addElement('Text', 'email', array(
      'label' => 'Email Address',
      'required' => true,
      'allowEmpty' => false,
      'validators' => array(
        'EmailAddress'
      ),
      'tabindex' => 1,
    ));
    $this->email->getValidator('EmailAddress')->getHostnameValidator()->setValidateTld(false);
	$this -> email -> setAttrib('required', true);
	// init email
    $this->addElement('Text', 'name', array(
      'label' => 'Name',
      'required' => true,
      'allowEmpty' => false,
      'tabindex' => 2,
    ));
	$this -> name -> setAttrib('required', true);
    // Init submit
    $this->addElement('Button', 'submit', array(
      'label' => 'Send Request',
      'type' => 'submit',
      'ignore' => true,
      'tabindex' => 3,
      'decorators' => array(
        'ViewHelper',
      ),
    ));
  }
}
