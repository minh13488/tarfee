<?php
class Ynresponsiveevent_Widget_EventMiniMenuController extends Engine_Content_Widget_Abstract
{
  private $_mode;
  public function getMode()
  {
	if( null === $this->_mode ) {
	  $this->_mode = 'page';
	}
	return $this->_mode;
  }
  public function indexAction()
  {
  	if(YNRESPONSIVE_ACTIVE != 'ynresponsive-event')
	{
		return $this -> setNoRender(true);
	} 
	$this->view->logo = $this->_getParam('logo');
	$this->view->viewer = $viewer = Engine_Api::_()->user()->getViewer();
    $this->view->navigation = $navigation = Engine_Api::_()
      ->getApi('menus', 'core')
      ->getNavigation('core_mini');

	//Search
    $require_check = Engine_Api::_()->getApi('settings', 'core')->core_general_search;
    if(!$require_check){
      if( $viewer->getIdentity()){
        $this->view->search_check = true;
      }
      else{
        $this->view->search_check = false;
      }
    }
    else $this->view->search_check = true;	
	
	//Facebook Connect
    $settings = Engine_Api::_()->getApi('settings', 'core');
    
    if ('none' != $settings->getSetting('core_facebook_enable', 'none') && $settings->core_facebook_secret) {
     $this->view->fblogin =  new Engine_Form_Element_Dummy('facebook', array(
         'content' => User_Model_DbTable_Facebook::loginButton(),
      'decorators'=>array('ViewHelper'),
       ));
       $this->view->fbLoginEnabled =  true;
    }else{
     $this->view->fbLoginEnabled =  false;
     $this->view->fblogin = new Engine_Form_Element_Dummy('facebook', array(
         'content' => 'fblogin here',
      'decorators'=>array('ViewHelper'),
     ));
    } 
	//Facebook Connect end
	
	//Twitter Connect
	// Init twitter login link
	$settings = Engine_Api::_()->getApi('settings', 'core');
	
	if( 'none' != $settings->getSetting('core_twitter_enable', 'none') && $settings->core_twitter_secret ) {
	  $this->view->twlogin =  new Engine_Form_Element_Dummy('twitter', array(
		'content' => User_Model_DbTable_Twitter::loginButton(),
		'decorators'=>array('ViewHelper'),
	  ));
	   $this->view->TwLoginEnabled =  true;
	}else{
	 $this->view->TwLoginEnabled =  false;
	 $this->view->twlogin = new Engine_Form_Element_Dummy('twitter', array(
		 'content' => 'twlogin here',
	  'decorators'=>array('ViewHelper'),
	 ));	   
	}
		
	//Twitter Connect end
	//Janrain Connect
	// Init janrain login link
    if( 'none' != $settings->getSetting('core_janrain_enable', 'none')
        && $settings->core_janrain_key ) {
      $mode = $this->getMode();
	  $this->view->jrlogin =  new Engine_Form_Element_Dummy('janrain', array(
        'content' => User_Model_DbTable_Janrain::loginButton($mode),
		'decorators'=>array('ViewHelper'),
      ));
	  $this->view->JrLoginEnabled =  true;
    }else{
     $this->view->JrLoginEnabled =  false;
     $this->view->jrlogin = new Engine_Form_Element_Dummy('janrain', array(
         'content' => 'janrain here',
      'decorators'=>array('ViewHelper'),
     ));	   
    }
	//Janrain Connect end	
	// Languages
    $translate    = Zend_Registry::get('Zend_Translate');
    $languageList = $translate->getList();

    // Prepare default langauge
    $defaultLanguage = Engine_Api::_()->getApi('settings', 'core')->getSetting('core.locale.locale', 'en');
    if( !in_array($defaultLanguage, $languageList) ) {
      if( $defaultLanguage == 'auto' && isset($languageList['en']) ) {
        $defaultLanguage = 'en';
      } else {
        $defaultLanguage = null;
      }
    }
	
	if(empty($_COOKIE['en4_language']) || empty($_COOKIE['en4_locale']))
	{
		$ipaddress = '';
	    if ($_SERVER['HTTP_CLIENT_IP'])
	        $ipaddress = $_SERVER['HTTP_CLIENT_IP'];
	    else if($_SERVER['HTTP_X_FORWARDED_FOR'])
	        $ipaddress = $_SERVER['HTTP_X_FORWARDED_FOR'];
	    else if($_SERVER['HTTP_X_FORWARDED'])
	        $ipaddress = $_SERVER['HTTP_X_FORWARDED'];
	    else if($_SERVER['HTTP_FORWARDED_FOR'])
	        $ipaddress = $_SERVER['HTTP_FORWARDED_FOR'];
	    else if($_SERVER['HTTP_FORWARDED'])
	        $ipaddress = $_SERVER['HTTP_FORWARDED'];
	    else if($_SERVER['REMOTE_ADDR'])
	        $ipaddress = $_SERVER['REMOTE_ADDR'];
		if($ipaddress)
		{
			$ch = curl_init('http://www.geoplugin.net/php.gp?ip='.$ipaddress);
			curl_setopt($ch,CURLOPT_RETURNTRANSFER, 1);
			$response = unserialize(curl_exec($ch));
			$country = $response['geoplugin_countryCode'];
			curl_close($ch);
			// check mapping
			$table = Engine_Api::_() -> getDbTable('langcountrymappings', 'core');
			$select = $table -> select() -> where('country_code = ?', $country) -> limit(1);
			$countryLanguage = '';
			if($row = $table -> fetchRow($select))
			{
				$countryLanguage = $row -> language_code;
			}
			$this -> view -> countryLanguage = $countryLanguage;
	    	if($countryLanguage)
			{
				setcookie('en4_language', $countryLanguage, time() + (86400*365), '/');
				setcookie('en4_locale', $countryLanguage, time() + (86400*365), '/');
				header("Refresh:0");
			}
		}
	}
	
    // Prepare language name list
    $languageNameList  = array();
    $languageDataList  = Zend_Locale_Data::getList(null, 'language');
    $territoryDataList = Zend_Locale_Data::getList(null, 'territory');

    foreach( $languageList as $localeCode ) {
      $languageNameList[$localeCode] = Engine_String::ucfirst(Zend_Locale::getTranslation($localeCode, 'language', $localeCode));
      if (empty($languageNameList[$localeCode])) {
        if( false !== strpos($localeCode, '_') ) {
          list($locale, $territory) = explode('_', $localeCode);
        } else {
          $locale = $localeCode;
          $territory = null;
        }
        if( isset($territoryDataList[$territory]) && isset($languageDataList[$locale]) ) {
          $languageNameList[$localeCode] = $territoryDataList[$territory] . ' ' . $languageDataList[$locale];
        } else if( isset($territoryDataList[$territory]) ) {
          $languageNameList[$localeCode] = $territoryDataList[$territory];
        } else if( isset($languageDataList[$locale]) ) {
          $languageNameList[$localeCode] = $languageDataList[$locale];
        } else {
          continue;
        }
      }
    }
    $languageNameList = array_merge(array(
      $defaultLanguage => $defaultLanguage
    ), $languageNameList);
	
	ksort($languageNameList);
    $this->view->languageNameList = $languageNameList;	
  }
}