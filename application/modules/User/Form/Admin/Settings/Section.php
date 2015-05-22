<?php
class User_Form_Admin_Settings_Section extends Authorization_Form_Admin_Level_Abstract {
  	public function init() {
    	$this
      	->setTitle('Section Settings for Member Levels')
      	->setDescription('Specify what profile section settings will be available to members in this level.');

    	$levels = array();
        $table  = Engine_Api::_()->getDbtable('levels', 'authorization');
        foreach ($table->fetchAll($table->select()) as $row) {
            $levels[$row['level_id']] = $row['title'];
        }
        
        $this->addElement('Select', 'level_id', array(
            'label' => 'Member Level',
            'multiOptions' => $levels,
            'ignore' => true
        ));
		
        if( !$this->isPublic() ) {    
            $this->addElement('Integer', 'bio_max', array(
                'label' => 'Maximum character of bio the user can add',
                'description' => 'Set 0 is unlimited',
                'required' =>true,
                'validators' => array(
                    new Engine_Validate_AtLeast(0),
                ),
                'value' => 0,
            ));
            
        }
        
        $this->addElement('Button', 'submit', array(
          'label' => 'Save Changes',
          'type' => 'submit',
          'ignore' => true
        ));  
        } 
}