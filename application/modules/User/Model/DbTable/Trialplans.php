<?php
class User_Model_DbTable_Trialplans extends Engine_Db_Table {
	
	protected $_name = 'user_trialplans';
	    
    public function getRow($user_id, $package_id) {
        $select = $this->select()
        ->where('user_id = ?', $user_id)
		->where('package_id = ?', $package_id)
		->limit(1);
        
		return $this->fetchRow($select);
    }
}
