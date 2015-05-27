<?php
class User_Model_DbTable_Locations extends Engine_Db_Table {
    protected $_rowClass = 'User_Model_Location';
	
	public function getLocations($parent_id) {
		return $this->fetchAll($this->select()->where('parent_id = ?', $parent_id));
	}
}
