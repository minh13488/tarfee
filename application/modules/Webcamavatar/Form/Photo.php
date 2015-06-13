<?php

class Webcamavatar_Form_Photo extends Engine_Form
{
  public function init()
  {
//     Get step and step number
    $stepTable = Engine_Api::_()->getDbtable('signup', 'user');
    $stepSelect = $stepTable->select()->where('class = ?','Webcamavatar_Plugin_Signup_Photo');
    $step = $stepTable->fetchRow($stepSelect);
    $stepNumber = 1 + $stepTable->select()
      ->from($stepTable, new Zend_Db_Expr('COUNT(signup_id)'))
      ->where('`order` < ?', $step->order)
      ->query()
      ->fetchColumn()
      ;
    $stepString = $this->getView()->translate('Step %1$s', $stepNumber);
    $this->setDisableTranslator(true);


    // Custom
    $this->setTitle($this->getView()->translate('%1$s: Capture the pictures directly through your webcam', $stepString));

    // Element: enable
    $this->addElement('Radio', 'enable', array(
      'label' => 'Capture the picture',
      'description' => 'Do you want your users to capture their pictures directly through their webcam and save screenshot to be profile avatar or save in computer.' .
        'themselves upon signup?',
      'multiOptions' => array(
        '1' => 'Yes, give users the option to capture the picture upon signup.',
        '0' => 'No, do not allow users to capture the picture upon signup.',
      ),
    ));

    // Element: submit
    $this->addElement('Button', 'submit', array(
      'label' => 'Save Changes',
      'type' => 'submit',
      'ignore' => true,
    ));

    // Populate
    $this->populate(array(
      'enable' => $step->enable,
    ));
  }
}