<?php
class Tfcampaign_Form_Admin_Settings_Global extends Engine_Form {
    public function init() {
        $this
        ->setTitle('Global Settings');
        
        $translate = Zend_Registry::get('Zend_Translate');
        $settings = Engine_Api::_()->getApi('settings', 'core');
        
        $this->addElement('Text', 'tfcampaign_max_title', array(
            'label' => 'Maximum Allowed Title Characters',
            'value' => $settings->getSetting('tfcampaign_max_title', "64"),
        ));
        
        $this->addElement('Text', 'tfcampaign_max_description', array(
            'label' => 'Maximum Allowed Description Characters',
            'value' => $settings->getSetting('tfcampaign_max_description', "300"),
        ));
		
		$this->addElement('Radio', 'tfcampaign_private_allow', array(
	      'label' => 'Allow private campaigns?',
	      'value' => Engine_Api::_()->getApi('settings', 'core')->getSetting('tfcampaign_private_allow', 1),
	      'multiOptions' => array(
	        '1' => 'Yes, allow private campaigns.',
	        '0' => 'No, disallow private campaigns.',
	      ),
	    ));
		
        $this->addElement('Button', 'submit_btn', array(
          'label' => 'Save Changes',
          'type' => 'submit',
          'ignore' => true
        ));
    }
}