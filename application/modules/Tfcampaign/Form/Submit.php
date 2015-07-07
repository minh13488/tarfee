<?php
class Tfcampaign_Form_Submit extends Engine_Form
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
	
    $this->setTitle('Submit Player');
    $this->setAttrib('class', 'global_form_popup');
    $this->setDescription('Which player do you want to submit?');
	
	$errorMessage = array();
	$arrValue = array();
	$arrSubmission = array();
	$viewer = Engine_Api::_() -> user() -> getViewer();
	
	//get submission players
	$submissionPlayers = $this ->_campaign -> getSubmissionPlayers();
	foreach($submissionPlayers as $submissionPlayer) {
		$arrSubmission[] = $submissionPlayer -> player_id;
	}
	//get players available
	$players = Engine_Api::_() -> getItemTable('user_playercard') -> getAllPlayerCard($viewer -> getIdentity());
	foreach($players as $player) 
	{
		if(!in_array($player -> getIdentity(), $arrSubmission)) 
		{
			if($player -> countPercentMatching($this ->_campaign) >= $this ->_campaign -> percentage)
			{
				if($this ->_campaign -> category_id != 0) {
					if($this ->_campaign -> category_id == $player -> category_id) {
						$arrValue[$player -> getIdentity()] = $player -> getTitle();
					}	
				} else {
					$arrValue[$player -> getIdentity()] = $player -> getTitle();
				}
			}
		}
	}
	
	if(count($arrValue)) {
		 $this->addElement('Select', 'player_id', array(
	      'label' => 'Player card',
	      'multiOptions' => $arrValue,
	    ));
    } else {
    	$isError = true;
		$errorMessage[] = $view -> translate("There are no available players");
    }
		
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
	
	
	//if error disable this button
    $this->addElement('Button', 'submit_button', array(
      'label' => 'Submit',
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
