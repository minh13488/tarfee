<?php
class Tfcampaign_Model_DbTable_Campaigns extends Engine_Db_Table {
	
	protected $_rowClass = 'Tfcampaign_Model_Campaign';
	
	public function getCampaignsByUser($user, $limit = null) {
		$select = $this -> select();
		$select -> where('user_id = ?', $user -> getIdentity())
				-> where('deleted <> ?', '1');
		if(isset($limit))
			$select -> limit($limit);
		return $this -> fetchAll($select);
	}
	
	public function getCampaignsTotal($user) {
		$select = $this -> select();
    	$select -> from($this->info('name'), 'COUNT(*) AS count')
				-> where('user_id = ?', $user -> getIdentity())
				-> where('deleted <> ?', '1');
    	return $select->query()->fetchColumn(0);
	}
	
	public function getLastestCampaign($user) {
		$select = $this -> select() 
						-> where('user_id = ?', $user -> getIdentity())
						-> order('campaign_id DESC')
						-> limit(1);
		return $this -> fetchRow($select);
	}
}
