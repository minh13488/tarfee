<?php
class User_Form_Admin_Player_Level extends Authorization_Form_Admin_Level_Abstract
{
  public function init()
  {
    parent::init();

    // My stuff
    $this
      ->setTitle('Member Level Settings')
      ->setDescription('These settings are applied on a per member level basis. Start by selecting the member level you want to modify, then adjust the settings for that level below.');

    if( !$this->isPublic() ) {

      // Element: max
      $this->addElement('Text', 'max_player_card', array(
        'label' => 'Maximum Allowed Player Cards',
        'description' => 'Enter the maximum number of allowed player cards. The field must contain an integer, use zero for unlimited.',
        'validators' => array(
          array('Int', true),
          new Engine_Validate_AtLeast(0),
        ),
        'value' => 5,
      ));

    }
    
  }
}