<?php
class Tfcampaign_Form_EditSubmit extends Engine_Form
{
  protected $_campaign;
  
  public function setCampaign($campaign) {
    $this ->_campaign = $campaign;
  }
  
  public function getCampaign() {
  	return $this ->_campaign;
  }
  
  public function init()
  {
	$view = Zend_Registry::get('Zend_View');
	
	$isError = false;
    $this->setTitle('Edit Player Submission');
    $this->setAttrib('class', 'global_form_popup');
	
	$errorMessage = array();
	$arrValue = array();
	$arrSubmission = array();
	$viewer = Engine_Api::_() -> user() -> getViewer();
	
		
	//Title
    $this->addElement('Text', 'title', array(
      'label' => 'Note',
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
	$this -> title -> setAttrib('required', true);
		
	$this->addElement('Textarea', 'description', array(
      'label' => 'Description',
      'validators' => array(
        array('NotEmpty', true),
        array('StringLength', false, array(1, 300)),
      ),
      'filters' => array(
        'StripTags',
        new Engine_Filter_Censor(),
      ),
    ));
	$this -> description -> setAttrib('required', true);
	
	$this->addElement('File', 'photo', array(
      'label' => 'Player Photo',
      'allowEmpty' => false,
      'required' => true,
    ));
	
	//video
	if($this->_campaign->photo_required) {
		$this->addElement('File', 'photo', array(
	      'label' => 'Player Photo',
	      'allowEmpty' => false,
	      'required' => true,
	    ));
	    $this -> photo -> addValidator('Extension', false, 'jpg,png,gif,jpeg');
		$this -> photo -> setAttrib('accept', 'image/*');
	}
	else {
		$this->addElement('File', 'photo', array(
	      'label' => 'Player Photo',
	    ));
		$this -> photo -> setAllowEmpty(true);
	    $this -> photo -> addValidator('Extension', false, 'jpg,png,gif,jpeg');
		$this -> photo -> setAttrib('accept', 'image/*');
	}
	
	//video
	$videoTable = Engine_Api::_() -> getItemTable('video');
	$select = $videoTable -> select()
						  -> where('owner_id = ?', $viewer -> getIdentity())
						  -> where('owner_type = ?', 'user');
	$videos = $videoTable -> fetchAll($select);
	
	$arrVideoValue = array();
	foreach($videos as $video) {
		$arrVideoValue[$video -> getIdentity()] = $video -> getTitle();
	}
	if(count($arrVideoValue)) {
		//if campaign not require video add option none
		if(!$this->_campaign->video_required)
		{
			$arrVideoValue[0] = $view -> translate('none');
		}
		 $this->addElement('Select', 'video_id', array(
	      'label' => 'Player Video',
	      'multiOptions' => $arrVideoValue,
	      'value' => 0,
	    ));
	}
	
	if($this->_campaign->video_required && !count($arrVideoValue)) {
		$isError = true;
		$errorMessage[] = $view -> translate("There are no available videos");
	}	
	
	//if error disable this button
    $this->addElement('Button', 'submit_button', array(
      'label' => 'Save changes',
      'type' => 'submit',
      'ignore' => true,
      'decorators' => array(
        'ViewHelper',
      ),
    ));
	
	if($isError) {
		foreach($errorMessage as $message) {
			$this ->addError($message);
		}
		$this -> submit_button -> setAttrib('disabled','');
	}
	
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
