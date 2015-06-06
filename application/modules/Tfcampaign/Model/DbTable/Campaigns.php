<?php
class Tfcampaign_Model_DbTable_Campaigns extends Engine_Db_Table {
	
	protected $_rowClass = 'Tfcampaign_Model_Campaign';
	
	public function getCampaignsByUser($user) {
		$select = $this -> select();
		$select -> where('user_id = ?', $user -> getIdentity())
				-> where('deleted <> ?', '1');
		return $this -> fetchAll($select);
	}
}
