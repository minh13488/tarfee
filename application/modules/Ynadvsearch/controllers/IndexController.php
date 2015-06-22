<?php

if (!function_exists('array_column')) {
    function array_column($array, $column_key, $index_key = null)  {
        return array_reduce($array, function ($result, $item) use ($column_key, $index_key) 
        {
            if (null === $index_key) {
                $result[] = $item[$column_key];
            } else {
                $result[$item[$index_key]] = $item[$column_key];
            }

            return $result;
        }, array());
    }
}

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
		if (count($result) < 20) {
			$limit = 20 - count($result);
			$names = array_column($result, 'name');
			$searchTbl = Engine_Api::_()->getDbTable('search', 'core');
			$searchSelect = $searchTbl->select()
				->where('title LIKE ?', '%'.$search.'%')
				->limit($limit);
			if (!empty($names))
			$searchSelect->where('title NOT IN ?', $names);
			$rows = $searchTbl->fetchAll($searchSelect);
			foreach ($rows as $row) {
				$keyword = $table->createRow();
				$keyword->title = $row->title;
				$keyword->creation_date = $keyword->modified_date = date('Y-m-d H:i:s');
				$keyword->save();
				$result[] = array (
					'id' => $keyword->keyword_id,
					'name' => $keyword->title
				);
			}
		}
		echo json_encode($result);
        return;
	}
}
