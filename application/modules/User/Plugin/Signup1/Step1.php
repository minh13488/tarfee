<?php

class User_Plugin_Signup1_Step1 extends Core_Plugin_FormSequence_Abstract
{
  protected $_name = 'step1';

  protected $_formClass = 'User_Form_Signup1_Step1';

  protected $_script = array('signup/form/account.tpl', 'user');

  public $email = null;

}
