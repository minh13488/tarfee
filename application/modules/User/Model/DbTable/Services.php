<?php

class User_Model_DbTable_Services extends Engine_Db_Table {
	protected $_rowClass = 'User_Model_Service';
	
	public function getAllServices() {
		return $this -> fetchAll($this -> select());
	}
	
    public function getServiceById($id = 0) {
        $select = $this->select()->where('service_id = ?', $id);
        return $this->fetchRow($select);
    }
}
