<?php
class User_Model_DbTable_Sportcategories extends User_Model_DbTable_Nodes {

	protected $_rowClass = 'User_Model_Sportcategory';
	public function deleteNode(User_Model_Node $node, $node_id = NULL) {
		$result = $node -> getDescendent(true);
		$db = $this -> getAdapter();
		parent::deleteNode($node);
	}
	
}
