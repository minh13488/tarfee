<?php
class User_Form_Playercard_Create extends Engine_Form
{
  public function init()
  {
  	$user = Engine_Api::_()->user()->getViewer();
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
	$relations['0'] = 'Other';
	$this->addElement('Select', 'relation_id', array(
      'label' => 'Relation',
      'multiOptions' => $relations,
      'onchange' => 'showOther()',
      'required' => (bool)Engine_Api::_()->getApi('settings', 'core')->getSetting('user.relation_require', 1)
    ));
	$this->addElement('Textarea', 'relation_other', array(
      'label' => 'Relation Other',
      'validators' => array(
        array('NotEmpty', true),
      ),
      'filters' => array(
        'StripTags',
        new Engine_Filter_Censor(),
        new Engine_Filter_EnableLinks(),
        new Engine_Filter_StringLength(array('max' => 100)),
      ),
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
   
   	$sportCattable = Engine_Api::_() -> getDbtable('sportcategories', 'user');
	$node = $sportCattable -> getNode(0);
	$categories = $node -> getChilren();
	$sport_categories[0] = '';
	foreach($categories as $category)
	{
		$sport_categories[$category->getIdentity()] = $category -> getTitle();
	}
    $this->addElement('Select', 'category_id', array(
      'label' => 'Sport Category',
      'multiOptions' => $sport_categories,
      'onchange' => 'subCategories()',
    ));
	
	$gender = new Engine_Form_Element_Select('gender');
    $gender->setLabel("Gender");
    $gender->setAllowEmpty(false);
	$gender->setMultiOptions(array('1' => 'Male', '2' => 'Female'));
	$gender -> setRequired(true);
    $this->addElement($gender);
	
    $birthday = new Fields_Form_Element_Birthdate('birth_date');
    $birthday->setLabel("Date of Birth");
    $birthday->setAllowEmpty(false);
	$birthday -> setRequired(true);
    $this->addElement($birthday);
	
	$this -> addElement('Select', 'referred_foot', array(
		'label' => 'Preferred Foot',
		'multiOptions' => array('1' => 'Left', '2' => 'Right', '0' => 'Both'),
	));
	
	$positions = $sportCattable -> getMultiOptions('--', '', FALSE);
	$this -> addElement('Select', 'position_id', array(
		'label' => 'Position',
		'multiOptions' => $positions,
	));
	
	// View
    $availableLabels = array(
      'everyone'            => 'Everyone',
      'registered'          => 'All Registered Members',
      'owner_network'       => 'Friends and Networks',
      'owner_member_member' => 'Friends of Friends',
      'owner_member'        => 'Friends Only',
      'owner'               => 'Just Me'
    );

    $viewOptions = (array) Engine_Api::_()->authorization()->getAdapter('levels')->getAllowed('user_playercard', $user, 'auth_view');
    $viewOptions = array_intersect_key($availableLabels, array_flip($viewOptions));
    if( !empty($viewOptions) && count($viewOptions) >= 1 ) {
      // Make a hidden field
      if(count($viewOptions) == 1) {
        $this->addElement('hidden', 'auth_view', array('value' => key($viewOptions)));
      // Make select box
      } else {
        $this->addElement('Select', 'auth_view', array(
            'label' => 'Privacy',
            'description' => 'Who may see this player card?',
            'multiOptions' => $viewOptions,
            'value' => key($viewOptions),
        ));
        $this->auth_view->getDecorator('Description')->setOption('placement', 'append');
      }
    }

 	// Comment
    $commentOptions = (array) Engine_Api::_()->authorization()->getAdapter('levels')->getAllowed('user_playercard', $user, 'auth_comment');
    $commentOptions = array_intersect_key($availableLabels, array_flip($commentOptions));

    if( !empty($commentOptions) && count($commentOptions) >= 1 ) {
      // Make a hidden field
      if(count($commentOptions) == 1) {
        $this->addElement('hidden', 'auth_comment', array('value' => key($commentOptions)));
      // Make select box
      } else {
        $this->addElement('Select', 'auth_comment', array(
            'label' => 'Comment Privacy',
            'description' => 'Who may post comments on this player card?',
            'multiOptions' => $commentOptions,
            'value' => key($commentOptions),
        ));
        $this->auth_comment->getDecorator('Description')->setOption('placement', 'append');
      }
	}
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