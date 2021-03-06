<?php
class Ynresponsiveevent_Form_Event_Create extends Engine_Form
{
  public function init()
  {
    $user = Engine_Api::_()->user()->getViewer();

    $this->setTitle('Create New Event')
      ->setAttrib('id', 'ynrespnosive_event_create_form')
	  ->setAttrib('class', 'global_form_popup')
      ->setMethod("POST")
      ->setAction(Zend_Controller_Front::getInstance()->getRouter()->assemble(array()));
	  
	$this -> addElement('Text', 'to', array('autocomplete' => 'off', 'label' => 'Select an Existing Event as Reference'));
	Engine_Form::addDefaultDecorators($this -> to);

	// Init to Values
	$this -> addElement('Hidden', 'toValues', array(
		'label' => 'Select an Existing Event as Reference',
		'required' => true,
		'allowEmpty' => false,
		'style' => 'margin-top:-5px',
		'order' => 1,
		'validators' => array('NotEmpty'),
		'filters' => array('HtmlEntities'),
	));
	Engine_Form::addDefaultDecorators($this -> toValues);
    // Title
    $this->addElement('Text', 'title', array(
      'label' => 'Event Name',
      'allowEmpty' => false,
      'required' => true,
      'validators' => array(
        array('NotEmpty', true),
        array('StringLength', false, array(1, 256)),
      ),
      'filters' => array(
        'StripTags',
        new Engine_Filter_Censor(),
      ),
    ));

    $title = $this->getElement('title');

    // Description
    $this->addElement('Textarea', 'description', array(
      'label' => 'Event Description',
      'maxlength' => '512',
      'filters' => array(
        'StripTags',
        new Engine_Filter_Censor(),
        new Engine_Filter_EnableLinks(),
        new Engine_Filter_StringLength(array('max' => 512)),
      ),
    ));
	
    // Photo
    $this->addElement('File', 'photo', array(
      'label' => 'Main Photo'
    ));
    $this->photo->addValidator('Extension', false, 'jpg,png,gif,jpeg');

    // Buttons
    $this->addElement('Button', 'submit', array(
      'label' => 'Save Changes',
      'type' => 'submit',
      'ignore' => true,
      'decorators' => array(
        'ViewHelper',
      ),
    ));

    $this->addElement('Cancel', 'cancel', array(
      'label' => 'cancel',
      'link' => false,
        'onClick'=> 'javascript:parent.Smoothbox.close();',
      'prependText' => ' or ',
      'decorators' => array(
        'ViewHelper',
      ),
    ));

    $this->addDisplayGroup(array('submit', 'cancel'), 'buttons', array(
      'decorators' => array(
        'FormElements',
        'DivDivDivWrapper',
      ),
    ));
  }
}