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
	
	
	//get main Library
	$arrValue = array();
	$viewer = Engine_Api::_() -> user() -> getViewer();
	$select = Engine_Api::_() -> getItemTable('user') 
						-> select() 
						-> where('enabled = ?', '1')
						-> where('verified = ?', '1')
						-> where('approved = ?', '1');
	$users = Engine_Api::_() -> getItemTable('user') -> fetchAll($select);
	foreach($users as $user) {
		if($user -> isSelf($viewer)) {
			continue;
		}
		$arrValue[$user -> getIdentity()] = $user -> getTitle();
	}
	
	 $this->addElement('Select', 'move_to', array(
      'label' => 'To User',
      'multiOptions' => $arrValue,
    ));
		
    $this->addElement('Button', 'submit_button', array(
      'value' => 'submit_button',
      'label' => 'Give OwnerShip',
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
