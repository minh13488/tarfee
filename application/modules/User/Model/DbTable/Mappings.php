<?php
class User_Model_DbTable_Mappings extends Engine_Db_Table
{
  	protected $_name = 'user_mappings';
	
	public function getVideosPaginator($params = array()) {
        $paginator = Zend_Paginator::factory($this->getVideosSelect($params));
        if (!empty($params['page'])) {
            $paginator->setCurrentPageNumber($params['page']);
        }
        if (!empty($params['limit'])) {
            $paginator->setItemCountPerPage($params['limit']);
        }
        return $paginator;
    }
	
	public function getItemIdsMapping($type, $params = array())
	{
		$select = $this -> select() -> from($this, new Zend_Db_Expr("`item_id`"));
		$select -> where("item_type = ?", $type);
        if (isset($params['owner_id'])) {
            $select -> where("owner_id = ?", $params['owner_id']);
        }
        if (isset($params['owner_type'])) {
            $select -> where("owner_type = ?", $params['owner_type']);
        }
        if (isset($params['user_id'])) {
            $select -> where("user_id = ?", $params['user_id']);
        }
        $select -> order("creation_date DESC");
		$mapping_ids = $this->fetchAll($select);
		$ids = array();
		foreach($mapping_ids as $mapping_id)
		{
			$ids[] = $mapping_id -> item_id;
		}
		return $ids;
	}
	
    public function getVideosSelect($params = array()) {
        $table = Engine_Api::_()->getItemTable('video');
        $rName = $table->info('name');
        $select = $table->select()->from($rName)->setIntegrityCheck(false);
		
		$mappings_p = $params;
        if (isset($mappings_p['user_id'])) unset($mappings_p['user_id']);
		$ids = $this -> getItemIdsMapping('video', $mappings_p);
		if (!empty($ids) && count($ids) > 0) {
            $select->where('video_id IN (?)', $ids);
        }
		else {
			$select->where('video_id = 0');
		}
		
        $select->order("$rName.creation_date DESC");
        return $select;
    }
	
	public function deleteItem($params = array()){
		$tableName = $this -> info('name');
		$db = $this -> getAdapter();
		$db -> beginTransaction();
		try
		{
			$db->delete($tableName, array(
				'owner_type = ?' => $params['owner_type'],
				'owner_id = ?' => $params['owner_id'],
			    'item_type = ?' => $params['item_type'],
			    'item_id = ?' => $params['item_id']
			));
			$db -> commit();
			
		}
		catch( Exception $e )
		{
			$db -> rollBack();
			return $e;
		}
		return "true";
	}
}