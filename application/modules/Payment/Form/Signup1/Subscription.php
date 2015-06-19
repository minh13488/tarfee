<?php

class Payment_Form_Signup1_Subscription extends Engine_Form
{
  protected $_isSignup = true;
  
  protected $_packages;
  
  public function setIsSignup($flag)
  {
    $this->_isSignup = (bool) $flag;
  }
  
  public function init()
  {
    $this
      ->setTitle('Subscription Plan')
      ->setDescription('Please select a subscription plan from the list below.')
      ;

    // Get available subscriptions
    $packagesTable = Engine_Api::_()->getDbtable('packages', 'payment');
    $packagesSelect = $packagesTable
      ->select()
      ->from($packagesTable)
      ->where('enabled = ?', true)
      ;

    if( $this->_isSignup ) {
      $packagesSelect->where('signup = ?', true);
    }
    else{
      $packagesSelect->where('after_signup = ?', true);
    }
	
	$sessionStep2 = new Zend_Session_Namespace('User_Plugin_Signup1_Step2');
	$dataStep2 = $sessionStep2 -> data;
	
	if(isset($dataStep2['profile_type']) && $dataStep2['profile_type'] == 1){
		$packagesSelect -> where("level_id = 4");
	}
	if(isset($dataStep2['profile_type']) && $dataStep2['profile_type'] == 4){
		$packagesSelect -> where("level_id = 6");
	}
	
    $multiOptions = array();
    $this->_packages = $packagesTable->fetchAll($packagesSelect);
    foreach( $this->_packages as $package ) {
      $multiOptions[$package->package_id] = $package->title
        . ' (' . $package->getPackageDescription() . ')'
        ;
    }
    
    // Element: package_id
    //if( count($multiOptions) > 1 ) {
      $this->addElement('Radio', 'package_id', array(
        'label' => 'Choose Plan:',
        'required' => true,
        'allowEmpty' => false,
        'multiOptions' => $multiOptions,
      ));
    //}

    
    // Init submit
    $this->addElement('Button', 'submit', array(
      'label' => 'Continue',
      'type' => 'submit',
      'ignore' => true,
    ));
  }
  
  public function getPackages()
  {
    return $this->_packages;
  }
  
  public function setPackages($packages)
  {
    $this->_packages = $packages;
  }
}