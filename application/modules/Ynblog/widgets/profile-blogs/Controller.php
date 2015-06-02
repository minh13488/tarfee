<?php
class Ynblog_Widget_ProfileBlogsController extends Engine_Content_Widget_Abstract
{
  protected $_childCount;
  
  public function indexAction()
  {
    $viewer = Engine_Api::_()->user()->getViewer();

    // Don't render layout if no subject is gotten
    if( !Engine_Api::_()->core()->hasSubject() ) {
      return $this->setNoRender();
    }

    // Get subject and check authorization
    $subject = Engine_Api::_()->core()->getSubject();
    if( !$subject->authorization()->isAllowed($viewer, 'view') ) {
      return $this->setNoRender();
    }

    // Get blog paginator
    $this->view->paginator = $paginator = Engine_Api::_()->ynblog()
            ->getBlogsPaginator(array('orderby' => 'creation_date',
                                      'draft'  => '0',
                                      'is_approved' => '1',
                                      'visible' => '1',
                                      'user_id' =>  $subject->getIdentity(),
                                ));
    //$this->view->paginator->setItemCountPerPage(10);
    $paginator->setCurrentPageNumber(1);

    // Don't render layout if no blog gotten
    if( $paginator->getTotalItemCount() <= 0 ) {
      return $this->setNoRender();
    }

    // Add count to title if configured
    if( $this->_getParam('titleCount', false) && $paginator->getTotalItemCount() > 0 ) {

    	$this->_childCount = $paginator->getTotalItemCount();
    }

    $settings = Engine_Api::_()->getApi('settings', 'core');
    $this->view->items_per_page = $settings->getSetting('blog_page', 10);
  }

  public function getChildCount()
  {
    return $this->_childCount;
  }
}