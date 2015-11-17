<?php
class User_Form_Signup_Request extends Engine_Form
{
  public function init()
  {
    // Init form
    $this->setTitle('Request Invitation');
    $this->setDescription($description);
    $this->setAttrib('id', 'user_form_request');
	$this->setAttrib('method', 'post');
    $this->loadDefaultDecorators();
    $this->getDecorator('Description')->setOption('escape', false);
	
	$this->addElement('Text', 'name', array(
      'label' => '*Your Name',
      'required' => true,
      'allowEmpty' => false,
      'tabindex' => 1,
    ));
	$this -> name -> setAttrib('required', true);
	
	$this->addElement('Text', 'role', array(
      'label' => '*Role',
      'required' => true,
      'allowEmpty' => false,
      'tabindex' => 2,
    ));
	$this -> role -> setAttrib('required', true);
	
	$this->addElement('Text', 'organization', array(
      'label' => 'Organization Name',
      'required' => false,
      'tabindex' => 3,
    ));
	
  	// init email
    $this->addElement('Text', 'email', array(
      'label' => '*Email',
      'required' => true,
      'allowEmpty' => false,
      'validators' => array(
        'EmailAddress'
      ),
      'tabindex' => 4,
    ));
    $this->email->getValidator('EmailAddress')->getHostnameValidator()->setValidateTld(false);
	$this -> email -> setAttrib('required', true);

	$countriesAssoc = Engine_Api::_()->getDbTable('locations', 'user')->getLocationsAssoc(0);
	$countriesAssoc = array(''=>'') + $countriesAssoc;

	$this->addElement('Select', 'country_id', array(
		'label' => '*Country',
		'multiOptions' => $countriesAssoc,
		'required' => true,
		'tabindex' => 5,
	));
	$this -> country_id -> setAttrib('required', true);

	$this->addElement('Select', 'province_id', array(
		'label' => '*Province/State',
		'required' => true,
		'tabindex' => 6,
	));
	$this -> province_id -> setAttrib('required', true);

	$this->addElement('Select', 'city_id', array(
		'label' => '*City',
		'required' => true,
		'tabindex' => 7,
	));
	$this -> city_id -> setAttrib('required', true);	
	
	$this->addElement('Text', 'phone', array(
      'label' => '*Tel',
      'description' => 'Example: +34-123-12345 ',
      'required' => true,
      'allowEmpty' => true,
      'tabindex' => 8,
    ));
	$this -> phone -> setAttrib('required', true);	
	$this -> phone -> getDecorator('Description')->setOption('placement', 'append');
	
	$this->addElement('Textarea', 'message', array(
      'label' => '*Tell us more about you',
      'required' => true,
      'allowEmpty' => false,
      'tabindex' => 9,
    ));	
	$this -> message -> setAttrib('required', true);	
	
    // Init submit
    $this->addElement('Button', 'submit', array(
      'label' => 'Send Request',
      'type' => 'submit',
      'ignore' => true,
      'tabindex' => 10,
      'decorators' => array(
        'ViewHelper',
      ),
    ));
	$this->addElement('Cancel', 'cancel', array(
      'label' => 'Cancel',
      'prependText' => ' or ',
      'type' => 'link',
      'link' => true,
       'tabindex' => 11,
      'onclick' => 'parent.Smoothbox.close();',
      'decorators' => array(
        'ViewHelper',
      ),
    ));

    $this->addDisplayGroup(array('submit', 'cancel'), 'buttons');
  }
}
