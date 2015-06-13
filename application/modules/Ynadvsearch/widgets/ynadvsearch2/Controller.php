<?php

class Ynadvsearch_Widget_Ynadvsearch2Controller extends Engine_Content_Widget_Abstract
{
	public function indexAction() {
	    
        $session = new Zend_Session_Namespace('mobile');
        if ($session -> mobile) {
            $this->setNoRender();
            return;
        }
		$params = $this->_getAllParams();
		$this->view->align = isset($params['align']) ? $params['align'] : 0;
		$this->view->maxRe = $maxRe = Engine_Api::_()->getApi('settings', 'core')->getSetting('ynadvsearch_num_searchitem', 10);
		$user = isset($params['user']) ? $params['user'] : array();

		$id = isset($params['id']) ? $params['id'] : '';
        $title = isset($params['title']) ? $params['title'] : '';
		$this->view->id = $id;
		$other = (isset($params['other']) && $params['other'] != '') ? $params['other'] : array();

		$user_name = '0';
		$group_name = '0';
		$group_description = '0';
		$group_tag = '0';

		$page_name = '0';
		$page_description = '0';
		$directory_name = '0';
		$directory_description = '0';

		if (is_array($user) && in_array('name',$user))
			$user_name = '1';
		else
			$user_name = '0';

		if (!empty($params['group']))
		{
			$group = $params['group'];

			if (in_array('name',$group))
				$group_name = '1';
			else
				$group_name = '0';
			if (in_array('description',$group))
				$group_description = '1';
			else
				$group_description = '0';

			 if (in_array('tag',$group))
				$group_tag = '1';
				else
				$group_tag = '0';

		}
		if (!empty($params['page']))
		{
			$page = $params['page'];
			if (in_array('name',$page))
				$page_name = '1';
			else
				$page_name = '0';
			if (in_array('description',$page))
				$page_description = '1';
			else
				$page_description = '0';
		}

		if (!empty($params['directory']))
		{
			$directory = $params['directory'];
			if (in_array('name',$directory))
				$directory_name = '1';
			else
				$directory_name = '0';
			if (in_array('description',$directory))
				$directory_description = '1';
			else
				$directory_description = '0';

		}

		 if (in_array('name',$other))
			$other_name = '1';
		else
			$other_name = '0';
		if (in_array('description',$other))
			$other_description = '1';
		else
			$other_description = '0';

		$this->view->user_name = $user_name;
		$this->view->group_name = $group_name;
		$this->view->group_description = $group_description;
    	$this->view->group_tag = $group_tag;
		$this->view->page_name = $page_name;
		$this->view->page_description = $page_name;
		$this->view->other_name = $other_name;
		$this->view->other_description = $other_description;
		$this->view->directory_name = $directory_name;
		$this->view->directory_description = $directory_description;
		// trunglt
		$headLink = new Zend_View_Helper_HeadLink();
        $headLink->prependStylesheet('application/modules/Ynadvsearch/externals/styles/main.css');
		$tokens = Zend_Controller_Front::getInstance ()->getRequest ()-> getParam('token', '');
		$tokens = explode(',', $tokens);
		
		$query = Zend_Controller_Front::getInstance ()->getRequest ()-> getParam('query', '');
		if (!empty($query)) {
			$id = Engine_Api::_()->getDbTable('keywords', 'ynadvsearch')->addKeyword($query);
			if ($id) $tokens[] = $id;
		}
		
		$tokens = Engine_Api::_()->getDbTable('keywords', 'ynadvsearch')->getKeywordsAssoc(array('ids' => $tokens));
		$this->view->tokens = $tokens;
		
		$this->view->type = Zend_Controller_Front::getInstance ()->getRequest ()->getParam('type',array_keys(Engine_Api::_()->ynadvsearch()->getAllowSearchTypes()));
		$this->view->sport = Zend_Controller_Front::getInstance ()->getRequest ()->getParam('sport',array_keys(Engine_Api::_()->getDbTable('sportcategories', 'user')->getCategoriesLevel1Assoc()));
		
		$viewer = Engine_Api::_()->user()->getViewer();
		$level_id = ($viewer->getIdentity()) ? $viewer->level_id : 5;
		$permissionsTable = Engine_Api::_()->getDbtable('permissions', 'authorization');
	    $max_keywords = $permissionsTable->getAllowed('user', $level_id, 'max_keyword');
	    if ($max_keywords == null) {
	        $row = $permissionsTable->fetchRow($permissionsTable->select()
	        ->where('level_id = ?', $level_id)
	        ->where('type = ?', 'user')
	        ->where('name = ?', 'max_keyword'));
	        if ($row) {
	            $max_keywords = $row->value;
	        }
	    }
		
		$this->view->max_keywords = $max_keywords;
		
		//advanced search campaign
		$this->view->sports = $sport = Engine_Api::_()->getDbTable('sportcategories', 'user')->getCategoriesLevel1Assoc();	
		$this->view->continents = $continents = Engine_Api::_()->ynadvsearch()->getContinents();
		$this->view->services = $services = Engine_Api::_()->getDbTable('services', 'user')->getAllServices();
		$this->view->relations = $relations = Engine_Api::_() -> getDbTable('relations','user') -> getRelationSearchArray();
	}
}
