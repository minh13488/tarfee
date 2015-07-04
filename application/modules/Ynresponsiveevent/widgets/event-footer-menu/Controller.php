<?php
class Ynresponsiveevent_Widget_EventFooterMenuController extends Engine_Content_Widget_Abstract
{
  public function indexAction()
  {
  	if(YNRESPONSIVE_ACTIVE != 'ynresponsive-event')
	{
		return $this -> setNoRender(true);
	}
    $this->view->navigation = $navigation = Engine_Api::_()
      ->getApi('menus', 'core')
      ->getNavigation('core_footer');
    // Get affiliate code
    $this->view->affiliateCode = Engine_Api::_()->getDbtable('settings', 'core')->core_affiliate_code;
  }

  public function getCacheKey()
  {
    //return true;
  }
  public function setLanguage()
  {

  }
}