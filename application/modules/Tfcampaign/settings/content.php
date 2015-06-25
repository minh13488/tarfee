<?php
return array(
	
	array(
        'title' => 'Campaign - Search Form',
        'description' => 'Displays campaign search form.',
        'category' => 'Campaign',
        'type' => 'widget',
        'name' => 'tfcampaign.search-form'
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
        'title' => 'Campaign - Profile Player Fulfill Info',
        'description' => 'Displays Suggest Info for users to fulfill the campaign info on Campaign Detail page',
        'category' => 'Campaign',
        'type' => 'widget',
        'name' => 'tfcampaign.profile-fulfill-info',
        'requirements' => array(
	      'subject' => 'tfcampaign_campaign',
	    ),
    ),
    
	array(
        'title' => 'Campaign - Recent Campaigns',
        'description' => 'Displays recent campaigns on main page.',
        'category' => 'Campaign',
        'type' => 'widget',
        'isPaginated' => true,
        'name' => 'tfcampaign.recent-campaign'
	),
	
	array(
        'title' => 'Campaign - Profile Player Submissions',
        'description' => 'Displays Player Submissions on Campaign Detail page',
        'category' => 'Campaign',
        'type' => 'widget',
        'name' => 'tfcampaign.profile-submission',
        'requirements' => array(
	      'subject' => 'tfcampaign_campaign',
	    ),
    ),
    
	array(
        'title' => 'Campaign - Profile Hidden Submissions',
        'description' => 'Displays Player Hidden Submissions on Campaign Detail page',
        'category' => 'Campaign',
        'type' => 'widget',
        'name' => 'tfcampaign.profile-hidden-submission',
        'requirements' => array(
	      'subject' => 'tfcampaign_campaign',
	    ),
    ),
);