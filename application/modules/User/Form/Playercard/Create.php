<?php
class User_Form_Playercard_Create extends Engine_Form
{
  public function init()
  {
    $this
      ->setTitle('Add New Player Card');
	  
	$this->addElement('File', 'photo', array(
      'label' => 'Card Photo'
    ));
    $this->photo->addValidator('Extension', false, 'jpg,png,gif,jpeg');
	
    $this->addElement('Text', 'first_name', array(
      'label' => 'First Name',
      'allowEmpty' => false,
      'required' => true,
      'validators' => array(
        array('NotEmpty', true),
        array('StringLength', false, array(1, 64)),
      ),
      'filters' => array(
        'StripTags',
        new Engine_Filter_Censor(),
      ),
    ));
	
	$this->addElement('Text', 'last_name', array(
      'label' => 'Last Name',
      'allowEmpty' => false,
      'required' => true,
      'validators' => array(
        array('NotEmpty', true),
        array('StringLength', false, array(1, 64)),
      ),
      'filters' => array(
        'StripTags',
        new Engine_Filter_Censor(),
      ),
    ));
	
	$relations = Engine_Api::_() -> getDbTable('relations','user') -> getRelationArray();
	$this->addElement('Select', 'relation_id', array(
      'label' => 'Relation',
      'multiOptions' => $relations,
    ));

    $this->addElement('Textarea', 'description', array(
      'label' => 'Description',
      'validators' => array(
        array('NotEmpty', true),
      ),
      'filters' => array(
        'StripTags',
        new Engine_Filter_Censor(),
        new Engine_Filter_EnableLinks(),
        new Engine_Filter_StringLength(array('max' => 10000)),
      ),
    ));
   
    $sport_categories = Engine_Api::_() -> getDbTable('sportcategories', 'user') -> getMultiOptions('','',FALSE,1);
    $this->addElement('Select', 'category_id', array(
      'label' => 'Sport Category',
      'multiOptions' => $sport_categories,
    ));
	
	$gender = new Engine_Form_Element_Select('gender');
    $gender->setLabel("Gender");
    $gender->setAllowEmpty(false);
	$gender->setMultiOptions(array('1' => 'Male', '2' => 'Female'));
    $this->addElement($gender);
	
    $birthday = new Engine_Form_Element_Birthdate('birth_date');
    $birthday->setLabel("Date of Birth");
    $birthday->setAllowEmpty(false);
    $this->addElement($birthday);
	
	$this -> addElement('Select', 'referred_foot', array(
		'label' => 'Preferred Foot',
		'multiOptions' => array('1' => 'Left', '2' => 'Right', '0' => 'Both'),
	));

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
      'link' => true,
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