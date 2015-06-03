<?php
class Tfcampaign_Model_DbTable_Reasons extends Engine_Db_Table {
		
	public function getAllReasons() {
		return $this -> fetchAll($this -> select());
	}
	
	public function getReasonArray()
	{
		$typeArray = array();
		$select = $this -> select();
		$types = $this -> fetchAll($select);
		foreach($types as $type)
		{
			$typeArray[$type -> reason_id] = $type -> title;  
		}
		return $typeArray;
	}
}
