<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: IndexController.php 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Core_IndexController extends Core_Controller_Action_Standard {
	public function indexAction() {
		if (Engine_Api::_() -> user() -> getViewer() -> getIdentity()) {
			return $this -> _helper -> redirector -> gotoRoute(array('action' => 'home'), 'user_general', true);
		}
		
		/*
		if (isset($_SESSION['skip_registration'])) {
			return $this -> _helper -> redirector -> gotoRoute(array(), 'user_home', true);
		}
		 */

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
		
		$this -> _helper -> layout -> disableLayout();

		// Render
		//$this -> _helper -> content 
			//-> setNoRender() 
		//	-> setEnabled();
	}

	public function howItWorksAction() {
		// Render
		$this -> _helper -> content -> setNoRender() -> setEnabled();
	}
	public function promoteLookAction() {
		// Render
		$this -> _helper -> content -> setNoRender() -> setEnabled();
	}
	public function aboutUsAction() {
		// Render
		$this -> _helper -> content -> setNoRender() -> setEnabled();
	}

}
