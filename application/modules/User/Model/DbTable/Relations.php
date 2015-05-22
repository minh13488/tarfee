<?php
class User_Model_DbTable_Relations extends Engine_Db_Table {
		
	public function getAllRelations() {
		return $this -> fetchAll($this -> select());
	}
	
	public function getRelationArray()
	{
		$typeArray = array();
		$select = $this -> select();
		$types = $this -> fetchAll($select);
		foreach($types as $type)
		{
			$typeArray[$type -> relation_id] = $type -> title;  
		}
		return $typeArray;
	}
}
