<?php
class Advgroup_ProfileController extends Core_Controller_Action_Standard
{
  public function init()
  {
  	$viewer = Engine_Api::_() -> user() -> getViewer();
  	
  	    $blacklists = Engine_Api::_()->getDbTable('blacklists','advgroup');
		
		$check = $blacklists->checkBlackListMembers($this -> _getParam('id'),$viewer->getIdentity());
		
		if($check == "true"){
			return;
		}
		
    // @todo this may not work with some of the content stuff in here, double-check
    $subject = null;
    if( !Engine_Api::_()->core()->hasSubject() )
    {
      $id = $this->_getParam('id');
      if( null !== $id )
      {
        $subject = Engine_Api::_()->getItem('group', $id);
        if( $subject && $subject->getIdentity() )
        {
          Engine_Api::_()->core()->setSubject($subject);
        }
        else return;
      }
    }
    $this->_helper->requireSubject('group');
	if (!$this -> _helper -> requireAuth() -> setAuthParams($subject, null, 'view') -> isValid())
	{
		return;
	}
  }
  
public function indexAction()
  {
    if(!Engine_Api::_()->core()->hasSubject()) return $this->renderScript("_error.tpl");
    $subject = Engine_Api::_()->core()->getSubject();
	
	if (Engine_Api::_()->user()->itemOfDeactiveUsers($subject)) {
		return $this->_helper->requireSubject()->forward();
	}
	
    $viewer = Engine_Api::_()->user()->getViewer();

    if($subject->is_subgroup && !$subject->isParentGroupOwner($viewer)){
       $parent_group = $subject->getParentGroup();
        if(!$parent_group->authorization()->isAllowed($viewer , "view")){
          return $this->_helper->requireAuth->forward();
        }
    }
    // Increment view count
    if( !$subject->getOwner()->isSelf($viewer) )
    {
      $subject->view_count++;
      $subject->save();
    }

    // Get styles
    $table = Engine_Api::_()->getDbtable('styles', 'core');
    $select = $table->select()
      ->where('type = ?', $subject->getType())
      ->where('id = ?', $subject->getIdentity())
      ->limit();

    $row = $table->fetchRow($select);

    if( null !== $row && !empty($row->style) ) {
      $this->view->headStyle()->appendStyle($row->style);
    }
	
	//Get Photo Url
	$photoUrl = $subject -> getPhotoUrl('thumb.profile');
	$pos = strpos($photoUrl, "http");
	if ($pos === false)
	{
		$photoUrl = rtrim((constant('_ENGINE_SSL') ? 'https://' : 'http://') . $_SERVER['HTTP_HOST'], '/') . $photoUrl;
	}

	//Get Video Url
	$clubUrl = $subject -> getHref();
	$pos = strpos($clubUrl, "http");
	if ($pos === false)
	{
		$clubUrl = rtrim((constant('_ENGINE_SSL') ? 'https://' : 'http://') . $_SERVER['HTTP_HOST'], '/') . $clubUrl;
	}
		
	//Adding meta tags for sharing
	$view = Zend_Registry::get('Zend_View');
	$og = '<meta property="og:image" content="' . $photoUrl . '" />';
	$og .= '<meta property="og:title" content="' . $subject -> getTitle() . '" />';
	$og .= '<meta property="og:url" content="' . $clubUrl . '" />';
	$view -> layout() -> headIncludes .= $og;

    // Render
    $this->_helper->content
        ->setNoRender()
        ->setEnabled()
        ;
  }
}
