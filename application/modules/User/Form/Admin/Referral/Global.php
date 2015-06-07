<?php
class User_Form_Admin_Referral_Global extends Engine_Form
{
  public function init()
  {
    $this
      ->setTitle('Global Settings')
      ->setDescription('These settings affect all members in your community.');

    $this->addElement('Radio', 'user_referral_enable', array(
      'label' => 'Referral Program',
      'value' => Engine_Api::_()->getApi('settings', 'core')->getSetting('user.referral_enable', 1),
      'multiOptions' => array(
        '1' => 'Activate.',
        '0' => 'Deactivte.',
      ),
    ));
	
	$this->addElement('Text', 'user_referral_discount',array(
	      'label'=>'Discount % of referral codes',
	      'description' => '',
	      'filters' => array(
	        new Engine_Filter_Censor(),
	      ),
	      'validators' => array(
	          array('Int', true),
	          new Engine_Validate_AtLeast(0),
	        ),
	     'value'=> Engine_Api::_()->getApi('settings', 'core')->getSetting('user.referral_discount', 0),
	    ));	
		
	$this->addElement('Text', 'referral_trial',array(
	      'label'=>'Trial period of referral codes',
	      'description' => '0 is unlimited',
	      'filters' => array(
	        new Engine_Filter_Censor(),
	      ),
	      'validators' => array(
	          array('Int', true),
	          new Engine_Validate_AtLeast(0),
	        ),
	     'value'=> Engine_Api::_()->getApi('settings', 'core')->getSetting('user.referral_trial ', 0),
	    ));	
    $this->getElement('referral_trial')->getDecorator("Description")->setOption("placement", "append");
    // Add submit button
    $this->addElement('Button', 'submit', array(
      'label' => 'Save Changes',
      'type' => 'submit',
      'ignore' => true
    ));
  }
}