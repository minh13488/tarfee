<?php
class User_Model_DbTable_Locations extends Engine_Db_Table {
    protected $_rowClass = 'User_Model_Location';
	
	public function getLocations($parent_id) {
		return $this->fetchAll($this->select()->where('parent_id = ?', $parent_id));
	}
	
	public function getLocationsAssoc($parent_id) {
		$arr = array();
		$rows = $this->getLocations($parent_id);
		foreach ($rows as $row) {
			$arr[$row->getIdentity()] = $row->getTitle();
		}
		return $arr;
	}
}
