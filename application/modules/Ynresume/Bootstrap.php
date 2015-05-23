<?php 
class Ynresume_Bootstrap extends Engine_Application_Bootstrap_Abstract {
	public function _initCss() {
        $view = Zend_Registry::get('Zend_View');
        // add font Awesome 4.1.0
        $url = $view -> baseUrl() . '/application/modules/Ynresume/externals/styles/font-awesome.min.css';
        $view -> headLink() -> appendStylesheet($url);
    }
}
?>