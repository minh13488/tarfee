<?php
class Tfcampaign_Form_Edit extends Tfcampaign_Form_Create
{
  public function init()
  {
    parent::init();
	$this -> setTitle('Edit Scout');
	$this->submit->setLabel('Save Changes');
  }
}