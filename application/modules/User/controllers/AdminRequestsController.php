<?php
class User_AdminRequestsController extends Core_Controller_Action_Admin {
 	 public function indexAction() {
 	 	$table = Engine_Api::_()->getDbTable('inviterequests', 'user');
		$select = $table->select()
			->where('approved = ?', '0')
			->order('inviterequest_id DESC');
		$this->view->paginator = $paginator = Zend_Paginator::factory($select);
		$page = $this->_getParam('page',1);
		$this->view->paginator->setItemCountPerPage(10);
        $this->view->paginator->setCurrentPageNumber($page);
 	 }
	 
	 public function viewDetailAction() {
	 	$this->_helper->layout->setLayout('admin-simple');
        $id = $this->_getParam('id', 0);
		$table = Engine_Api::_()->getDbTable('inviterequests', 'user');
		$request = $table->find($id);
		if (!request) {
			$this->_forward('success', 'utility', 'core', array(
                'smoothboxClose' => true,
                'parentRefresh'=> false,
                'messages' => array('Request not found.')
            ));
		}
		$this->view->request = $request;
	 }
	 
	 public function rejectAction() {
        // In smoothbox
        $this->_helper->layout->setLayout('admin-simple');
        $id = $this->_getParam('id');
        $this->view->request_id = $id;
        // Check post
        if( $this->getRequest()->isPost()) {
        	$table = Engine_Api::_()->getDbTable('inviterequests', 'user');
            $db = Engine_Db_Table::getDefaultAdapter();
            $db->beginTransaction();

            try {
                $request = $table->find($id);
                $request->delete();
                $db->commit();
            }

            catch(Exception $e) {
                $db->rollBack();
                throw $e;
            }

            $this->_forward('success', 'utility', 'core', array(
                'smoothboxClose' => true,
                'parentRefresh'=> true,
                'messages' => array('This request has been rejected.')
            ));
        }
    }
	
	public function approveAction() {
        // In smoothbox
        $this->_helper->layout->setLayout('admin-simple');
        $id = $this->_getParam('id', 0);
        $table = Engine_Api::_()->getDbTable('inviterequests', 'user');
		$request = $table->find($id);
		if (!request) {
			$this->_forward('success', 'utility', 'core', array(
                'smoothboxClose' => true,
                'parentRefresh'=> false,
                'messages' => array('Request not found.')
            ));
		}
		
		$viewer = Engine_Api::_()->user()->getViewer();
		$inviteTable = Engine_Api::_()->getDbtable('invites', 'invite');
	    $db = $inviteTable->getAdapter();
	    $db->beginTransaction();
	    
	    try {
      		$emailsSent = $inviteTable->sendInvites($viewer, $request->email, '', 0);
	      	$db->commit();
	    } 
	    catch( Exception $e ) {
	      	$db->rollBack();
	      	if( APPLICATION_ENV == 'development' ) {
	        	throw $e;
	      	}
	    }
		
		$this->_forward('success', 'utility', 'core', array(
            'smoothboxClose' => true,
            'parentRefresh'=> true,
            'messages' => array('Request has been approved.')
        ));
    }
	
	public function multirejectAction() {
        $viewer = Engine_Api::_() -> user() -> getViewer();
        $this -> view -> ids = $ids = $this -> _getParam('ids', NULL);
        $confirm = $this -> _getParam('confirm', FALSE);
        $this -> view -> count = count(explode(",", $ids));

        // Check post
        if ($this -> getRequest() -> isPost() && $confirm == TRUE) {
            //Process delete
            $ids_array = explode(",", $ids);
			$table = Engine_Api::_()->getDbTable('inviterequests', 'user');
            foreach ($ids_array as $id) {
                $request = $table->find($id);
                if ($request) {
                    $request->delete();
                }
            }

            $this -> _helper -> redirector -> gotoRoute(array('module'=>'user','controller'=>'requests', 'action'=>'index'), 'admin_default', TRUE);
        }
    }
}