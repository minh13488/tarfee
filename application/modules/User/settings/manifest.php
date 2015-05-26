<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @author     John
 */
return array(
  // Package -------------------------------------------------------------------
  'package' => array(
    'type' => 'module',
    'name' => 'user',
    'version' => '4.8.7',
    'revision' => '$Revision: 10271 $',
    'path' => 'application/modules/User',
    'repository' => 'socialengine.com',
    'title' => 'Members',
    'description' => 'Members',
    'author' => 'Webligo Developments',
    'changeLog' => 'settings/changelog.php',
    'dependencies' => array(
      array(
        'type' => 'module',
        'name' => 'core',
        'minVersion' => '4.2.0',
      ),
    ),
    'actions' => array(
       'install',
       'upgrade',
       'refresh',
       //'enable',
       //'disable',
     ),
    'callback' => array(
      'path' => 'application/modules/User/settings/install.php',
      'class' => 'User_Installer',
      'priority' => 3000,
    ),
    'directories' => array(
      'application/modules/User',
    ),
    'files' => array(
      'application/languages/en/user.csv',
    ),
  ),
  // Compose -------------------------------------------------------------------
  'compose' => array(
    array('_composeFacebook.tpl', 'user'),
    array('_composeTwitter.tpl', 'user'),
  ),
  'composer' => array(
    'facebook' => array(
      'script' => array('_composeFacebook.tpl', 'user'),
    ),
    'twitter' => array(
      'script' => array('_composeTwitter.tpl', 'user'),
    ),
  ),
  // Hooks ---------------------------------------------------------------------
  'hooks' => array(
    array(
      'event' => 'onUserEnable',
      'resource' => 'User_Plugin_Core',
    ),
    array(
      'event' => 'onUserDeleteBefore',
      'resource' => 'User_Plugin_Core',
    ),
    array(
      'event' => 'onUserCreateAfter',
      'resource' => 'User_Plugin_Core',
    ),
    array(
      'event' => 'getAdminNotifications',
      'resource' => 'User_Plugin_Core',
    ),
    array(
      'event' => 'onItemCreateAfter',
      'resource' => 'User_Plugin_Core',
    ),
    array(
      'event' => 'onItemUpdateAfter',
      'resource' => 'User_Plugin_Core',
    ),
     array(
      'event' => 'onItemDeleteAfter',
      'resource' => 'User_Plugin_Core',
    ),
  ),
  // Items ---------------------------------------------------------------------
  'items' => array(
    'user',
    'user_list',
    'user_list_item',
    'user_offerservice',
    'user_service',
    'user_archievement',
    'user_license',
    'user_experience',
    'user_education',
    'user_recommendation',
    'user_sportcategory',
    'user_library',
    'user_sportcategory',
    'user_playercard',
  ),
  // Routes --------------------------------------------------------------------
  'routes' => array(
    // User - General
    'user_extended' => array(
      'route' => 'members/:controller/:action/*',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'index',
        'action' => 'index'
      ),
      'reqs' => array(
        'controller' => '\D+',
        'action' => '\D+',
      )
    ),
    'user_general' => array(
      'route' => 'members/:action/*',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'index',
        'action' => 'browse'
      ),
      'reqs' => array(
        'action' => '(home|browse|render-section|get-my-location|upload-photo)',
      )
    ),
	
	'user_recommendation' => array(
      'route' => 'members/recommendation/:action/*',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'recommendation',
        'action' => 'received'
      ),
    ),
	'user_library' => array(
      'route' => 'members/library/:action/*',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'library',
        'action' => 'create-sub-library'
      ),
      'reqs' => array(
        'action' => '(create-sub-library|edit|delete|give-ownership|move-to-sub|move-to-main|move-to-player)',
      )
    ),
	
	/*
    // User - Specific
    'user_profile' => array(
      'route' => 'profile/:id/*',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'profile',
        'action' => 'index'
      )
    ),*/
    
    'user_login' => array(
      'route' => '/login/*',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'auth',
        'action' => 'login'
      )
    ),
    'user_logout' => array(
      'type' => 'Zend_Controller_Router_Route_Static',
      'route' => '/logout',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'auth',
        'action' => 'logout'
      )
    ),
    'user_signup' => array(
      'route' => '/signup/:action/*',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'signup',
        'action' => 'index'
      )
    ),
  )
); ?>
