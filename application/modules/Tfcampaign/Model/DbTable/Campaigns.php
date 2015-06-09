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
	
	public function getCampaignsPaginator($params = array()) 
    {
        return Zend_Paginator::factory($this->getCampaignsSelect($params));
    }
  
    public function getCampaignsSelect($params = array()) {
    	$campaignTbl = Engine_Api::_() -> getItemTable('tfcampaign_campaign');
    	$campaignTblName = $campaignTbl -> info('name');


    	$userTbl = Engine_Api::_() -> getDbtable('users', 'user');
    	$userTblName = $userTbl -> info('name');

    	$categoryTbl = Engine_Api::_() -> getItemTable('user_sportcategory');
    	$categoryTblName = $categoryTbl -> info('name');

		$select = $this -> select();
		$select -> from("$campaignTblName as campaign", "campaign.*");
		
    	$select
    	-> joinLeft("$userTblName as user", "user.user_id = campaign.user_id", "")
    	-> joinLeft("$categoryTblName as category", "category.sportcategory_id = campaign.category_id", "");

    	$select->group("campaign.campaign_id");
    	$tmp = array();

    	if (isset($params['title']) && $params['title'] != '') 
    	{
    		$select->where('campaign.title LIKE ?', '%'.$params['title'].'%');
    	}
    	
    	if (isset($params['owner']) && $params['owner'] != '') 
    	{
    		$select->where('user.displayname LIKE ?', '%'.$params['owner'].'%');
    	}
    	
    	if (!empty($params['category_id']) && $params['category_id'] != 'all') 
    	{
			$select->where('campaign.category_id IN (?)', $params['category_id']);
    	}
		
    	if(isset($params['user_id'])) 
    	{
    		$select->where('campaign.user_id = ?', $params['user_id']);
    	}
    	
		$select -> where('campaign.deleted <> 1');
		
    	return $select;
    }
}
