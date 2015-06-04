<?php
class Tfcampaign_Form_Create extends Engine_Form
{
  public function init()
  {
  	$settings = Engine_Api::_()->getApi('settings', 'core');
	$view = Zend_Registry::get("Zend_View");
	
  	$user = Engine_Api::_()->user()->getViewer();
    $this
      ->setTitle('Add New Campaign');
	
	$maxCharTitle = $settings->getSetting('tfcampaign_max_title', "300");
    $this->addElement('Text', 'title', array(
      'label' => 'Title',
      'description' => $view -> translate("Maximum %s characters.", $maxCharTitle),
      'allowEmpty' => false,
      'required' => true,
      'validators' => array(
        array('NotEmpty', true),
        array('StringLength', false, array(1, $maxCharTitle)),
      ),
      'filters' => array(
        'StripTags',
        new Engine_Filter_Censor(),
      ),
    ));
	$this -> title -> setAttrib('required', true);
	
	$maxCharDesc = $settings->getSetting('tfcampaign_max_description', "300");
	$this->addElement('Textarea', 'description', array(
      'label' => 'Description',
      'description' => $view -> translate("Maximum %s characters.", $maxCharDesc),
      'validators' => array(
        array('NotEmpty', true),
        array('StringLength', false, array(1, $maxCharDesc)),
      ),
      'filters' => array(
        'StripTags',
        new Engine_Filter_Censor(),
      ),
    ));
	$this -> description -> setAttrib('required', true);
	
	$sportCattable = Engine_Api::_() -> getDbtable('sportcategories', 'user');
	$node = $sportCattable -> getNode(0);
	$categories = $node -> getChilren();
	$sport_categories[0] = '';
	foreach($categories as $category)
	{
		$sport_categories[$category->getIdentity()] = $category -> getTitle();
	}
    $this->addElement('Select', 'sport_type_id', array(
      'label' => 'Sport Type',
      'multiOptions' => $sport_categories,
      'onchange' => 'subCategories()',
    ));
	
	$this -> addElement('Select', 'sport_preference_id', array(
		'label' => 'Sport Preference',
		'multiOptions' => array("0" => ""),
	));
	
	 // Start time
    $start = new Engine_Form_Element_CalendarDateTime('start_date');
    $start->setLabel("Start Time");
    $start->setAllowEmpty(false);
    $this->addElement($start);
	
    // End time
    $end = new Engine_Form_Element_CalendarDateTime('end_date');
    $end->setLabel("End Time");
    $end->setAllowEmpty(false);
    $this->addElement($end);

	
	$arrAge = array();
	$arrAge[] = "";
    for ($i = 1; $i <= 100; $i++) 
    {
    	$arrAge[] = $i;
    }
	
	$this -> addElement('Select', 'from_age', array(
		'label' => 'From Age',
		'multiOptions' => $arrAge,
	));
	
	$this -> addElement('Select', 'to_age', array(
		'label' => 'To Age',
		'multiOptions' => $arrAge,
	));
	
	
	$gender = new Engine_Form_Element_Select('gender');
    $gender->setLabel("Gender");
    $gender->setAllowEmpty(false);
	$gender->setMultiOptions(array('0' => '', '1' => 'Male', '2' => 'Female'));
	$gender -> setRequired(true);
    $this->addElement($gender);
	
	
	$countriesAssoc = Engine_Api::_()->getDbTable('locations', 'user')->getLocationsAssoc(0);
	$countriesAssoc = array('0'=>'') + $countriesAssoc;

	$this->addElement('Select', 'country_id', array(
		'label' => 'Location',
		'multiOptions' => $countriesAssoc,
	));
	
	// Init default locale
    $localeObject = Zend_Registry::get('Locale');

    $languages = Zend_Locale::getTranslationList('language', $localeObject);
    $territories = Zend_Locale::getTranslationList('territory', $localeObject);

    $localeMultiOptions = array();
    foreach( array_keys(Zend_Locale::getLocaleList()) as $key ) {
      $languageName = null;
      if( !empty($languages[$key]) ) {
        $languageName = $languages[$key];
      } else {
        $tmpLocale = new Zend_Locale($key);
        $region = $tmpLocale->getRegion();
        $language = $tmpLocale->getLanguage();
        if( !empty($languages[$language]) && !empty($territories[$region]) ) {
          $languageName =  $languages[$language] . ' (' . $territories[$region] . ')';
        }
      }

      if( $languageName ) {
        $localeMultiOptions[$languageName] = $languageName;
      }
    }
    
    $this->addElement('Select', 'language', array(
      'label' => 'Language',
      'multiOptions' => $localeMultiOptions,
      'value' => 'auto',
      'disableTranslator'=> true
    ));
	
	
	$this -> addElement('Checkbox', 'photo_required', array(
        'label' => 'Photo Required',
    )); 
	
	$this -> addElement('Checkbox', 'video_required', array(
        'label' => 'Video Required',
    )); 
	
	
	// View for specific users
    $this -> addElement('Text', 'user', array(
        'label' => 'Allow view for',
        'autocomplete' => 'off',
        'order' => '13'
    ));
    
    $this -> addElement('Hidden', 'user_ids', array(
        'filters' => array('HtmlEntities'),
        'order' => '14'
    ));
    Engine_Form::addDefaultDecorators($this -> user_ids);
	
	
	$allowPrivate = Engine_Api::_()->getApi('settings', 'core')->getSetting('tfcampaign_private_allow', 1);
	
	if($allowPrivate) {
		// View
	    $availableLabels = array(
	      'everyone'            => 'Everyone',
	      'registered'          => 'All Registered Members',
	      'owner_network'       => 'Friends and Networks',
	      'owner_member_member' => 'Friends of Friends',
	      'owner_member'        => 'Friends Only',
	      'owner'               => 'Just Me'
	    );
	
	    $viewOptions = (array) Engine_Api::_()->authorization()->getAdapter('levels')->getAllowed('tfcampaign_campaign', $user, 'auth_view');
	    $viewOptions = array_intersect_key($availableLabels, array_flip($viewOptions));
	    if( !empty($viewOptions) && count($viewOptions) >= 1 ) {
	      // Make a hidden field
	      if(count($viewOptions) == 1) {
	        $this->addElement('hidden', 'auth_view', array('value' => key($viewOptions)));
	      // Make select box
	      } else {
	        $this->addElement('Select', 'auth_view', array(
	            'label' => 'Privacy',
	            'description' => 'Who may see this campaign?',
	            'multiOptions' => $viewOptions,
	            'value' => key($viewOptions),
	        ));
	        $this->auth_view->getDecorator('Description')->setOption('placement', 'append');
	      }
	    }
    }
	
    // Buttons
    $this->addElement('Button', 'submit', array(
      'label' => 'Create',
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