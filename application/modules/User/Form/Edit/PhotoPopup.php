<?php
class User_Form_Edit_PhotoPopup extends Engine_Form
{
  public function init()
  {
    $this
      ->setAttrib('enctype', 'multipart/form-data')
      ->setAttrib('name', 'EditPhoto');

    $this->addElement('Image', 'current', array(
      'label' => 'Current Photo',
      'ignore' => true,
      'decorators' => array(array('ViewScript', array(
        'viewScript' => '_formEditImage.tpl',
        'class'      => 'form element',
        'testing' => 'testing'
      )))
    ));
    Engine_Form::addDefaultDecorators($this->current);
    
    $this->addElement('File', 'Filedata', array(
      'label' => 'Choose New Photo',
      'destination' => APPLICATION_PATH.'/public/temporary/',
      'multiFile' => 1,
      'validators' => array(
        array('Count', false, 1),
        // array('Size', false, 612000),
        array('Extension', false, 'jpg,jpeg,png,gif'),
      ),
      'onchange'=>'javascript:uploadSignupPhoto();'
    ));
	
	// Init url
    $this->addElement('Text', 'url', array(
      'label' => 'Photo Link (URL)',
      'description' => 'Paste the web address of the photo here (jpg,jpeg,png,gif).',
      'onchange'=>'javascript:uploadSignupPhoto();',
      'maxlength' => '200',
      'value' => ''
    ));
    $this->url->getDecorator("Description")->setOption("placement", "append");

    $this->addElement('Hidden', 'coordinates', array(
      'filters' => array(
        'HtmlEntities',
      )
    ));

    $this->addElement('Button', 'done', array(
      'label' => 'Save Photo',
      'type' => 'submit',
      'decorators' => array(
        'ViewHelper'
      ),
    ));

    $this->addElement('Cancel', 'cancel', array(
          'label' => 'cancel',
          'link' => true,
          'prependText' => ' or ',
          'href' => '',
          'onclick' => 'parent.Smoothbox.close();',
          'decorators' => array(
            'ViewHelper'
          )
        ));
        
    $this->addDisplayGroup(array('done', 'cancel'), 'buttons');
    
  }
}