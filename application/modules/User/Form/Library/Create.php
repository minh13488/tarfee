<?php
class User_Form_Library_Create extends Engine_Form
{
	
  public function init()
  {
	$view = Zend_Registry::get('Zend_View');
	
    $this->setTitle('Create Sub Library');
    $this->setAttrib('class', 'global_form_popup');
	
	//Title
    $this->addElement('Text', 'title', array(
      'label' => '*Title',
      'allowEmpty' => false,
      'required' => true,
      'validators' => array(
        array('NotEmpty', true),
      ),
      'filters' => array(
        'StripTags',
        new Engine_Filter_Censor(),
      ),
    ));
	
	//Description
    $this->addElement('Textarea', 'description', array(
      'label' => 'Description',
    ));
	
    $this->addElement('Button', 'submit_button', array(
      'value' => 'submit_button',
      'label' => 'Create',
      'onclick' => 'removeSubmit()',
      'type' => 'submit',
      'ignore' => true,
      'decorators' => array(
        'ViewHelper',
      ),
    ));
	
     $this->addElement('Cancel', 'cancel', array(
        'label' => 'cancel',
        'link' => true,
        'prependText' => ' or ',
        'href' => '',
        'onclick' => 'parent.Smoothbox.close();',
        'decorators' => array(
            'ViewHelper'
        )
    ));
    
	 $this->addDisplayGroup(array('submit_button', 'cancel'), 'buttons', array(
      'decorators' => array(
        'FormElements',
        'DivDivDivWrapper',
      ),
    ));
  }
}
