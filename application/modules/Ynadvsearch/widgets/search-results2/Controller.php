<?php
class Ynadvsearch_Widget_SearchResults2Controller extends Engine_Content_Widget_Abstract {
	public function indexAction() {
		$request = Zend_Controller_Front::getInstance ()->getRequest ();
		
		$tokens = $request-> getParam('token', '');
		$tokens = explode(',', $tokens);
		$query = $request -> getParam('query', '');
		if (!empty($query)) {
			$id = Engine_Api::_()->getDbTable('keywords', 'ynadvsearch')->addKeyword($query, false);
			if ($id) $tokens[] = $id;
		}
		
		$this->view->tokens = $tokens = Engine_Api::_()->getDbTable('keywords', 'ynadvsearch')->getKeywordsAssoc(array('ids' => $tokens));
        
		$this->view->text = $text = array_column($tokens, 'name');
		
		$from = $request-> getParam('from', 0);
		$from = intval($from);
		
		$limit = 2;		
		
		$viewer = Engine_Api::_()->user()->getViewer();
		$level_id = ($viewer->getIdentity()) ? $viewer->level_id : 5;
		$permissionsTable = Engine_Api::_()->getDbtable('permissions', 'authorization');
	    $max_results = $permissionsTable->getAllowed('user', $level_id, 'max_result');
	    if ($max_results == null) {
	        $row = $permissionsTable->fetchRow($permissionsTable->select()
	        ->where('level_id = ?', $level_id)
	        ->where('type = ?', 'user')
	        ->where('name = ?', 'max_result'));
	        if ($row) {
	            $max_results = $row->value;
	        }
	    }

		if ($max_results && (($from + $limit) >= $max_results)) {
			$limit = $max_results - $from;
			$this->view->reachLimit = true;
		}

		$this->view->type = $type = $request->getParam('type',array_keys(Engine_Api::_()->ynadvsearch()->getAllowSearchTypes()));
		$this->view->sport = $sport = $request->getParam('sport',array_keys(Engine_Api::_()->getDbTable('sportcategories', 'user')->getCategoriesLevel1Assoc()));
		$results = Engine_Api::_()->getApi('search', 'ynadvsearch')->getResults2( $text, $type, $sport, $from, $limit );
        
		$this->view->limit = $limit;
		$this->view->from = $from;
		$this->view->results = $results;
	}
}
