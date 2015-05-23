<?php

class User_Model_Library extends Core_Model_Item_Abstract
{
  protected $_owner_type = 'user';
  
  public function getSubLibrary() {
  	if($this -> level == 0) {
  		$tableLibrary = Engine_Api::_() -> getItemTable('user_library');
  		$select = $tableLibrary -> select() -> where('parent_id = ?', $this -> getIdentity());
  		return $tableLibrary -> fetchAll($select);
  	} else {
  		return false;
  	}
  	
  }
  
}