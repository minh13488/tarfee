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
		
		$from = null;		
		
		$type = array_keys(Engine_Api::_()->ynadvsearch()->getAllowSearchTypes());
		$limit = 10;
		$this->view->limit = $limit;
		$results = Engine_Api::_()->getApi('search', 'ynadvsearch')->getResults2( $text, $type, $from, $limit );
        
		$this->view->results = $results;
		if (isset($values['isViewMore']) && $values['isViewMore'] == 1) {
			$this->view->isViewMore = $values['isViewMore'];
		}
	}
}
