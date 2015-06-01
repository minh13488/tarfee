<?php
class User_Model_DbTable_Eyeons extends Engine_Db_Table {
    public function isEyeOn($user_id, $player_id) {
        $select = $this->select()->where('user_id = ?', $user_id)->where('player_id = ?', $player_id);
        $row = $this->fetchRow($select);
        return ($row) ? true : false;
    }
	
	public function getUserEyeOns($user_id) {
        $select = $this->select()->where('user_id = ?', $user_id);
        return $this->fetAll($select);
    }
}