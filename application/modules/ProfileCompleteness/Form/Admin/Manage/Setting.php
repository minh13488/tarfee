<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class ProfileCompleteness_Form_Admin_Manage_Setting extends Engine_Form {

    public function init() {
        $this->setTitle('Global Settings');

        $this->addElement('Text', 'color', array(
            'label' => 'Profile Address',
            'description' => 'Enter Gauge Color in Hex',
            'required' => true,
            'allowEmpty' => false,
            'validators' => array(
                array('NotEmpty', true),
                array('Regex', true, array('/^#[a-f0-9]{6}$/i')),

            ),
        ));

        $this->color->getValidator('NotEmpty')->setMessage('Please enter a valid color in Hex.', 'isEmpty');
        $this->color->getValidator('Regex')->setMessage('Please enter a valid color in Hex.', 'regexNotMatch');


        $this->addElement('Text', 'photoweight', array(
            'label' => 'Profile Photo Weight',
            'description' => 'Enter 0 to skip photo checking, by default it\'s included with value 2',
            'required' => true,
            'validators' => array(
                array('NotEmpty', true),
                array('Int', true),
                new Engine_Validate_AtLeast(0),
                ),
        ));
        $this->photoweight->getValidator('NotEmpty')->setMessage('Please enter a number, and greater than 0.', 'isEmpty');
        $this->addElement('Checkbox', 'view', array(
            'label' => 'Do not show widget',
            'description' => 'Do not show the widget when profile is 100% complete',
        ));


        // init submit
        $this->addElement('Button', 'submit', array(
            'label' => 'Save Changes',
            'type' => 'submit',
            'ignore' => true,
        ));
    }

}

?>
