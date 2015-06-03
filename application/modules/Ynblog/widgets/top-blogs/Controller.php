<?php
class Ynblog_Widget_TopBlogsController extends Engine_Content_Widget_Abstract
{
	public function indexAction()
  {
    //Get number of blogs display
    if($this->_getParam('max') != '' && $this->_getParam('max') >= 0){
       $limit = $this->_getParam('max');
    }else{
       $limit = 8;
    }

    //Select blogs
    $btable = Engine_Api::_()->getItemTable('blog');
    $ltable  = Engine_Api::_()->getDbtable('likes', 'core');
    $bName = $btable->info('name');
    $lName = $ltable->info('name');
    
    $select = $btable->select()->from($bName)  
                     ->joinLeft($lName, "resource_id = blog_id",'')
                     ->where("resource_type  LIKE 'blog'")
                     ->group("resource_id")
                     ->where("search = 1")
                     ->where("draft = 0")
                     ->where("is_approved = 1")
                     ->order("Count(resource_id) DESC")
                     ->limit($limit);

    $this->view->blogs = $btable->fetchAll($select);
    $this->view->limit = $limit;
  }
}