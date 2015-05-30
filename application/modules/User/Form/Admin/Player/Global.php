<?php
class User_Form_Admin_Player_Global extends Engine_Form
{
  public function init()
  {
    $this
      ->setTitle('Global Settings')
      ->setDescription('These settings affect all members in your community.');

    $this->addElement('Radio', 'relation_require', array(
      'label' => 'Player Card - Relation',
      'value' => Engine_Api::_()->getApi('settings', 'core')->getSetting('user.relation_require', 1),
      'multiOptions' => array(
        '1' => 'Mandatory.',
        '0' => 'Optional.',
      ),
    ));
    
    // Add submit button
    $this->addElement('Button', 'submit', array(
      'label' => 'Save Changes',
      'type' => 'submit',
      'ignore' => true
    ));
  }
}