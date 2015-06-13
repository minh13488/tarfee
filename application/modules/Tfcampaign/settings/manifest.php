<?php return array (
  'package' => 
  array (
    'type' => 'module',
    'name' => 'tfcampaign',
    'version' => '4.01',
    'path' => 'application/modules/Tfcampaign',
    'title' => 'Tarfee Campaign',
    'description' => '',
    'author' => '',
    'callback' => 
    array (
        'path' => 'application/modules/Tfcampaign/settings/install.php',    
        'class' => 'Tfcampaign_Installer',
    ),
    'actions' => 
    array (
      0 => 'install',
      1 => 'upgrade',
      2 => 'refresh',
      3 => 'enable',
      4 => 'disable',
    ),
    'directories' => 
    array (
      0 => 'application/modules/Tfcampaign',
    ),
    'files' => 
    array (
      0 => 'application/languages/en/tfcampaign.csv',
    ),
  ),
  // Items ---------------------------------------------------------------------
    'items' => array(
  		'tfcampaign_campaign',
  		'tfcampaign_submission',
    ),
 	// Routes ---------------------------------------------------------------------
	'routes' => array(
		'tfcampaign_extended' => array(
			'route' => 'campaign/:controller/:action/*',
			'defaults' => array(
				'module' => 'tfcampaign',
				'controller' => 'index',
				'action' => 'index',
			),
			'reqs' => array(
				'controller' => '\D+',
				'action' => '\D+',
			)
		),
		'tfcampaign_general' => array(
			'route' => 'campaign/:action/*',
			'defaults' => array(
				'module' => 'tfcampaign',
				'controller' => 'index',
				'action' => 'browse',
			),
			'reqs' => array(
	            'action' => '(create|browse|view-campaigns)',
	        )
		),
		'tfcampaign_specific' => array(
			'route' => 'campaign/:action/:campaign_id/*',
	        'defaults' => array(
	            'module' => 'tfcampaign',
	            'controller' => 'campaign',
	            'action' => 'index',
	        ),
	        'reqs' => array(
	            'action' => '(edit|delete|submit|hide|unhide|withdraw|save)',
	            'campaign_id' => '\d+',
	        )
	    ),
	    'tfcampaign_profile' => array(
			'route' => 'campaign/:id/:slug/*',
			'defaults' => array(
					'module' => 'tfcampaign',
					'controller' => 'profile',
					'action' => 'index',
					'slug' => '',
			),
			'reqs' => array(
					'id' => '\d+',
			)
	    ),
    ),
); ?>