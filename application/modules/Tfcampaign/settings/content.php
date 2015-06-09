<?php
return array(
	
	array(
        'title' => 'Campaign - Main Menu',
        'description' => 'Displays campaign main menu.',
        'category' => 'Campaign',
        'type' => 'widget',
        'name' => 'tfcampaign.main-menu'
	),
	
	array(
        'title' => 'Campaign - User Profile Campaigns',
        'description' => 'Displays campaign on user profile page.',
        'category' => 'Campaign',
        'type' => 'widget',
        'isPaginated' => true,
        'name' => 'tfcampaign.user-profile-campaign'
	),
	
	array(
        'title' => 'Search Campaign',
        'description' => 'Displays search campaign form.',
        'category' => 'Campaign',
        'type' => 'widget',
        'name' => 'tfcampaign.search-campaign',
        'isPaginated' => true,
        'defaultParams' => array(
            'title' => 'Search Campaigns'
        ),
    ),
);