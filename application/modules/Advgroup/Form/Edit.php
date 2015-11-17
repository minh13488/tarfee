<?php
class Advgroup_Form_Edit extends Engine_Form
{
  public $_error = array();
  protected $_item;

  public function getItem()
  {
    return $this->_item;
  }

  public function setItem(Core_Model_Item_Abstract $item)
  {
    $this->_item = $item;
    return $this;
  }
  
  public function init()
  {
    $user = Engine_Api::_()->user()->getViewer();

    $this
      ->setTitle('Edit Club');

    $this->addElement('Text', 'title', array(
      'label' => 'Club Name',
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
	
    // establish date
    $establish = new Engine_Form_Element_Date('establish_date');
    $establish->setLabel("Establish Date");
    $establish->setAllowEmpty(false);
	$establish -> setYearMin(1699);
    $this->addElement($establish);
	
    
    $allowed_html = 'strong, b, em, i, u, strike, sub, sup, p, div, pre, address, h1, h2, h3, h4, h5, h6, span, ol, li, ul, a, img, embed, br, hr, object , param, iframe';
    $this->addElement('TinyMce', 'description', array(
      'label' => 'Description',
      'editorOptions' => array(
         'bbcode' => 1,
         'mode'=> 'exact',
      	 'elements'=>"description",
          'html'   => 1,
          'theme_advanced_buttons1' => array(
              'undo', 'redo', 'cleanup', 'removeformat', 'pasteword', '|',
              'media', 'image','link', 'unlink', 'fullscreen', 'preview', 'emotions'
          ),
          'theme_advanced_buttons2' => array(
              'fontselect', 'fontsizeselect', 'bold', 'italic', 'underline',
              'strikethrough', 'forecolor', 'backcolor', '|', 'justifyleft',
              'justifycenter', 'justifyright', 'justifyfull', '|', 'outdent', 'indent', 'blockquote',
          ),
        ),
      'required'   => true,
      'allowEmpty' => false,
      'filters' => array(
        new Engine_Filter_Censor(),
        new Engine_Filter_Html(array('AllowedTags'=>$allowed_html)))
    ));
	
	
    $this->addElement('File', 'photo', array(
      'label' => 'Profile Photo'
    ));
    $this->photo->addValidator('Extension', false, 'jpg,png,gif,jpeg');
	
	
	$this->addElement('Text', 'website', array(
      'label' => 'Website',
      'allowEmpty' => true,
      'required' => false,
      'validators' => array(
        array('NotEmpty', true),
        array('StringLength', false, array(1, 64)),
      ),
      'filters' => array(
        'StripTags',
        new Engine_Filter_Censor(),
      ),
    ));
	
	$this->addElement('Text', 'twitter', array(
      'label' => 'Twitter',
      'allowEmpty' => true,
      'required' => false,
      'validators' => array(
        array('NotEmpty', true),
        array('StringLength', false, array(1, 64)),
      ),
      'filters' => array(
        'StripTags',
        new Engine_Filter_Censor(),
      ),
    ));
	
	$this->addElement('Text', 'facebook', array(
      'label' => 'Facebook',
      'allowEmpty' => true,
      'required' => false,
      'validators' => array(
        array('NotEmpty', true),
        array('StringLength', false, array(1, 64)),
      ),
      'filters' => array(
        'StripTags',
        new Engine_Filter_Censor(),
      ),
    ));
	
	$this->addElement('Text', 'google', array(
      'label' => 'Google+',
      'allowEmpty' => true,
      'required' => false,
      'validators' => array(
        array('NotEmpty', true),
        array('StringLength', false, array(1, 64)),
      ),
      'filters' => array(
        'StripTags',
        new Engine_Filter_Censor(),
      ),
    ));
	
	// init email
    $this->addElement('Text', 'email', array(
      'label' => 'Email',
      'validators' => array(
        'EmailAddress'
      ),
    ));
	$this->email->getValidator('EmailAddress')->getHostnameValidator()->setValidateTld(false);

	$this->addElement('Text', 'phone', array(
      'label' => 'Tel',
      'description' => 'Example: +34-123-12345 ',
    ));
	$this -> phone -> getDecorator('Description')->setOption('placement', 'append');
	
    $this->addElement('Select', 'category_id', array(
      'label' => 'Category',
      'multiOptions' => array(
        '0' => ''
      ),
    ));
	
	 $this->addElement('Select', 'sportcategory_id', array(
      'label' => 'Sport',
       'multiOptions' => array(
        '0' => ' '
      ),
    ));
	
	$this -> addElement('hidden', 'location_address', array(
		'value' => '0',
		'order' => '97'
	));
		
	$this -> addElement('hidden', 'lat', array(
		'value' => '0',
		'order' => '98'
	));
	
	$this -> addElement('hidden', 'long', array(
		'value' => '0',
		'order' => '99'
	));
	
	$countriesAssoc = Engine_Api::_()->getDbTable('locations', 'user')->getLocationsAssoc(0);
	$countriesAssoc = array('0'=>'') + $countriesAssoc;
	$this->addElement('Select', 'country_id', array(
		'label' => 'Country',
		'multiOptions' => $countriesAssoc,
	));

	$this->addElement('Select', 'province_id', array(
		'label' => 'Province/State',
	));

	$this->addElement('Select', 'city_id', array(
		'label' => 'City',
	));
	
	$this -> addElement('Dummy', 'location_map', array(
            'label' => 'Location',
            'decorators' => array( array(
                'ViewScript',
                array(
                    'viewScript' => '_location_search.tpl',
                    'class' => 'form element',
                )
            )), 
    ));
	
    // Privacy
    $availableLabels = array(
      'everyone'    => 'Everyone',
      'registered'  => 'Registered Members',
      'member'      => 'All Club Members',
      'officer'     => 'Officers and Owner Only',
      'owner'       => 'Owner Only',
    );


    // View
    $viewOptions = (array) Engine_Api::_()->authorization()->getAdapter('levels')->getAllowed('group', $user, 'auth_view');
    $viewOptions = array_intersect_key($availableLabels, array_flip($viewOptions));
    
    if( !empty($viewOptions) && count($viewOptions) >= 1 ) {
      // Make a hidden field
      if(count($viewOptions) == 1) {
        $this->addElement('hidden', 'auth_view', array('value' => key($viewOptions)));
      // Make select box
      } else {
        $this->addElement('Select', 'auth_view', array(
            'label' => 'View Privacy',
            'description' => 'Who may see this club?',
            'multiOptions' => $viewOptions,
            'value' => key($viewOptions),
          ));
          $this->auth_view->getDecorator('Description')->setOption('placement', 'append');
      }
    }

    // Buttons
    $this->addElement('Button', 'submit', array(
      'label' => 'Save Changes',
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
