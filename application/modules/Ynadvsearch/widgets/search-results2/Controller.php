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
		
		$tokens = Engine_Api::_()->getDbTable('keywords', 'ynadvsearch')->getKeywordsAssoc(array('ids' => $tokens));
        
		$this->view->text = $text = array_column($tokens, 'name');
		
		$from = 0;
		
		$limit = $from + 3;		
		
		$type = $request->getParam('type',array_keys(Engine_Api::_()->ynadvsearch()->getAllowSearchTypes()));
		$sport = $request->getParam('sport',array_keys(Engine_Api::_()->getDbTable('sportcategories', 'user')->getCategoriesLevel1Assoc()));
		$results = Engine_Api::_()->getApi('search', 'ynadvsearch')->getResults2( $text, $type, $sport, $from, $limit );
        
		$this->view->limit = $limit;
		$this->view->results = $results;
	}
}
