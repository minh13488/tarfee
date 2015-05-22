<?php
class User_Model_DbTable_Sportcategories extends User_Model_DbTable_Nodes {

	protected $_rowClass = 'User_Model_Sportcategory';
	public function deleteNode(User_Model_Node $node, $node_id = NULL) {
		$result = $node -> getDescendent(true);
		$db = $this -> getAdapter();
		//$sql = 'update engine4_user_deals set category_id =  '.$node_id.' where category_id in (' . implode(',', $result) . ',0)';
		//$db -> query($sql);
		parent::deleteNode($node);
	}
	
}
