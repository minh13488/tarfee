<?php
class User_Form_Admin_Youtube_Global extends Engine_Form {
    public function init() {
        $this
        ->setTitle('Global Settings');
        
        $translate = Zend_Registry::get('Zend_Translate');
        $settings = Engine_Api::_()->getApi('settings', 'core');
        
        $this->addElement('Text', 'user_youtube_clientid', array(
            'label' => 'ClientId',
            'value' => $settings->getSetting('user_youtube_clientid', ""),
        ));
        
        $this->addElement('Text', 'user_youtube_secret', array(
            'label' => 'Client Secret',
            'value' => $settings->getSetting('user_youtube_secret', ""),
        ));
		
        $this->addElement('Button', 'submit_btn', array(
          'label' => 'Save Changes',
          'type' => 'submit',
          'ignore' => true
        ));
    }
}