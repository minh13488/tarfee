<?php
class User_Model_DbTable_Offerservices extends Engine_Db_Table 
{
    protected $_rowClass = 'User_Model_Offerservice';
    
    public function getAllOfferServicesOfUser($user_id) {
        $select = $this->select()->where('user_id = ?', $user_id)
        ->order('offerservice_id ASC');
        return $this->fetchAll($select);
    }
}
