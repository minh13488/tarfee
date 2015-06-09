<?php
class Tfcampaign_Model_DbTable_Submissions extends Engine_Db_Table {
	
	protected $_rowClass = 'Tfcampaign_Model_Submission';
	
	public function getSubmissionsPaginator($params = array()) 
    {
        return Zend_Paginator::factory($this->getSubmissionsSelect($params));
    }
  
    public function getSubmissionsSelect($params = array()) {
    	$select = $this -> select();
    	return $select;
    }
	
}
