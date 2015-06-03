<?php

class Ynadvsearch_IndexController extends Core_Controller_Action_Standard {
	public function indexAction() {

	}

	public function usersGroupsListAction() {

	}
	
	public function suggestKeywordsAction() {
		$this -> _helper -> layout -> disableLayout();
        $this -> _helper -> viewRenderer -> setNoRender(true);
		$search = $this->_getParam('q' ,'');
		$search = trim($search);
		
		$table = Engine_Api::_()->getDbTable('keywords', 'ynadvsearch');
		$search = $table->select()->where('title LIKE ?', '%'.$search.'%')->order('count DESC');
		$rows = $table->fetchAll($search);
		$result = array();
		foreach ($rows as $row) {
			$result[] = array (
				'id' => $row->keyword_id,
				'name' => $row->title
			);
		}
		
		echo json_encode($result);
        return;
	}
}
