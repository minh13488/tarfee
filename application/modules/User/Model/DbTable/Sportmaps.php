<?php
class User_Model_DbTable_Sportmaps extends Engine_Db_Table {
	protected $_primary = 'map_id';
	
	public function getSportsOfUser($user_id, $limit = null) {
		$tblName = $this->info('name');
		$sportTbl = Engine_Api::_()->getItemTable('user_sportcategory');
		$sportTblName = $sportTbl->info('name');
		$select = $sportTbl->select()->setIntegrityCheck(false);
		$select -> from("$sportTblName as sport", "sport.*");
		$select -> joinLeft("$tblName as map", "map.sport_id = sport.sportcategory_id", "");
		if(!isset($limit) && empty($limit)) {
			$limit = 2;
		}
		$select 
			-> where("sport.parent_id = ?", '1')
			-> where("map.user_id = ?", $user_id)
			-> order("sport.title ASC");
		if($limit != 0) {
			$select -> limit($limit);
		}
		return $sportTbl->fetchAll($select);
	}
}
