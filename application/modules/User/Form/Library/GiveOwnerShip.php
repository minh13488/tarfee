<?php
class User_Form_Library_GiveOwnerShip extends Engine_Form
{
  protected $_library;
  protected $_subs;
  
  public function getLibrary(){
  	return $this ->_library;
  }
  
  public function setLibrary($library) {
  	$this ->_library = $library;
  }
  
  public function getSubs(){
  	return $this ->_subs;
  }
  
  public function setSubs($subs) {
  	$this ->_subs = $subs;
  }
  
  public function init()
  {
	$view = Zend_Registry::get('Zend_View');
	
    $this->setTitle('Give OwnerShip');
    $this->setAttrib('class', 'global_form_popup');
    $this->setDescription('Are you sure that you want to give ownership this video?');
	
	
	$arrValue = array();
	$viewer = Engine_Api::_() -> user() -> getViewer();
	$players = Engine_Api::_() -> getItemTable('user_playercard') -> getAllPlayerCard($viewer -> getIdentity());
	foreach($players as $player) {
		$arrValue[$player -> getIdentity()] = $player -> getTitle();
	}
	 $this->addElement('Select', 'move_to', array(
	  'required' => true,
      'label' => 'To Player',
      'multiOptions' => $arrValue,
    ));
		
    $this->addElement('Button', 'submit_button', array(
      'value' => 'submit_button',
      'label' => 'Move',
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
