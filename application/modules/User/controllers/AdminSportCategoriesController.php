<?php
class User_AdminSportCategoriesController extends Core_Controller_Action_Admin
{
  public function init()
  {
    $this->view->navigation = $navigation = Engine_Api::_()->getApi('menus', 'core')
      ->getNavigation('player_admin_main', array(), 'player_admin_main_sportcategory');
  }
  public function indexAction()
  {
  		$table = Engine_Api::_() -> getDbtable('sportcategories', 'user');
		$node = $table -> getNode($this -> _getParam('parent_id', 0));
		$this -> view -> categories = $node -> getChilren();
		$this -> view -> category = $node;
  }
}