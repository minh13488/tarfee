<?php

return array(
    'package' =>
    array(
        'type' => 'module',
        'name' => 'webcamavatar',
        'version' => '4.01p1',
        'path' => 'application/modules/Webcamavatar',
        'title' => 'Webcamavatar',
        'description' => 'Webcam  Avatar Module',
        'author' => 'YouNet Developments',
        'callback' =>
        array(
            'class' => 'Engine_Package_Installer_Module',
        ),
        'actions' =>
        array(
            0 => 'install',
            1 => 'upgrade',
            2 => 'refresh',
            3 => 'enable',
            4 => 'disable',
        ),
        'directories' =>
        array(
            0 => 'application/modules/Webcamavatar',
        ),
        'files' =>
        array(
            0 => 'application/languages/en/webcamavatar.csv',
        ),
    ),
    'routes' => array(
        'user_editphoto' => array(
            'route' => 'members/edit/:action/*',
            'defaults' => array(
                'module' => 'webcamavatar',
                'controller' => 'edit',
                'action' => 'photo'
            ),
            'reqs'=>array(
                'action'=>'(photo)'
            ),
        ),
        'user_editwebcam' => array(
            'route' => 'members/edit/photocamera/*',
            'defaults' => array(
                'module' => 'webcamavatar',
                'controller' => 'camera',
                'action' => 'edit'
            )
        ),
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
        
    ),
);
?>

