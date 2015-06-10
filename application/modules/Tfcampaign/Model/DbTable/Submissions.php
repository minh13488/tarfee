<?php
class Tfcampaign_Model_DbTable_Submissions extends Engine_Db_Table {
	
	protected $_rowClass = 'Tfcampaign_Model_Submission';
	
	public function getSubmissionsPaginator($params = array()) 
    {
        return Zend_Paginator::factory($this->getSubmissionsSelect($params));
    }
  
    public function getSubmissionsSelect($params = array()) {
    	
		$submissionTbl = $this;
		$submissionTblName = $submissionTbl -> info('name');

		$playerTbl = Engine_Api::_() -> getItemTable('user_playercard');
		$playerTblName = $playerTbl -> info('name');
		
		$select = $submissionTbl -> select();
		$select -> setIntegrityCheck(false);

		$select -> from("$submissionTblName as submission", "submission.*");
		
		$select -> joinLeft("$playerTblName as player", "submission.player_id = player.playercard_id", null) ;
        $select -> group("submission.submission_id");
        
		if (isset($params['order'])) {
	        if (empty($params['direction'])) {
	            $params['direction'] = ($params['order'] == 'submission.submission_id') ? 'DESC' : 'ASC';
	        }
            $select->order($params['order'].' '.$params['direction']);
		}
		else {
	        if (!empty($params['direction'])) {
	            $select->order('submission.submission_id'.' '.$params['direction']);
	        }
			else{
				$select->order('submission.submission_id DESC');
			}
	    }
		
    	return $select;
    }
	
}
