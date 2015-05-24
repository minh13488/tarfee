<?php
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class ProfileCompleteness_AdminSettingController extends Core_Controller_Action_Admin {

    public function indexAction() {
        $this->view->navigation = $navigation = Engine_Api::_()->getApi('menus', 'core')
                ->getNavigation('profilecompleteness_admin_main', array(), 'profilecompleteness_admin_main_setting');

        $this->view->form = $form = new ProfileCompleteness_Form_Admin_Manage_Setting();

        $table = Engine_Api::_()->getDbtable('search', 'core');
        $db = $table->getAdapter();
        $select = $table->select()->setIntegrityCheck(false);
        $select->from(array('w' => 'engine4_profilecompleteness_weights'))
                ->where('w.type_id = 0 AND w.field_id = 0');
        $row = $table->fetchRow($select);
        $values = array();
        $values['photoweight'] = $row->weight;
        $select = $table->select()->setIntegrityCheck(false);
        $select->from(array('w' => 'engine4_profilecompleteness_settings'));
        $row = $table->fetchRow($select);
        $values['view'] = $row->view;
        $values['color'] = $row->color;
        $form->populate($values);

        if ($this->getRequest()->isPost() && $form->isValid($this->getRequest()->getPost())) {
            $table = Engine_Api::_()->getDbtable('weights', 'profileCompleteness');
            $db = $table->getAdapter();
            $db->beginTransaction();
            try {
                $select = $table->select()->setIntegrityCheck(false);
                $select->from(array('w' => 'engine4_profilecompleteness_weights'))
                        ->where('w.type_id = 0 AND w.field_id = 0');
                $row = $table->fetchRow($select);
                $values = $form->getValues();
                $row->weight = $values['photoweight'];
                $row->save();
                $select = $table->select()->setIntegrityCheck(false);
                $table = Engine_Api::_()->getDbtable('settings', 'profileCompleteness');
                $select->from(array('w' => 'engine4_profilecompleteness_settings'));
                $row = $table->fetchRow($select);
                $row->color = $values['color'];
                $row->view = $values['view'];
                $row->save();
                $db->commit();
            } catch (Exception $e) {
                $db->rollback();
                throw $e;
            }
            $form->addNotice('Your changes have been saved.');
        }
    }
}

?>
