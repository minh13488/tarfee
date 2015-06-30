<?php
return array(
	
	array(
        'title' => 'Scout - Filter Scouts',
        'description' => 'Displays filter scouts in home page.',
        'category' => 'Scout',
        'type' => 'widget',
        'name' => 'tfcampaign.filter-campaigns'
	),
	
	array(
        'title' => 'Scout - My saved Scouts',
        'description' => 'Displays saved scouts of user.',
        'category' => 'Scout',
        'type' => 'widget',
        'name' => 'tfcampaign.my-saved-campaigns'
	),
	
	array(
        'title' => 'Scout - My Scouts',
        'description' => 'Displays scouts which are belong to user.',
        'category' => 'Scout',
        'type' => 'widget',
        'name' => 'tfcampaign.my-campaigns'
	),
	
	array(
        'title' => 'Scout - My submissions',
        'description' => 'Displays submissions which are belong to user.',
        'category' => 'Scout',
        'type' => 'widget',
        'name' => 'tfcampaign.my-submissions'
	),
	
	array(
        'title' => 'Scout - User Profile Scouts',
        'description' => 'Displays scout on user profile page.',
        'category' => 'Scout',
        'type' => 'widget',
        'isPaginated' => true,
        'name' => 'tfcampaign.user-profile-campaign'
	),
	
	array(
        'title' => 'Scout - Club Profile Scouts',
        'description' => 'Displays scout on club profile page.',
        'category' => 'Scout',
        'type' => 'widget',
        'isPaginated' => true,
        'name' => 'tfcampaign.club-profile-campaign'
	),
	
	array(
        'title' => 'Scout - Profile Player Fulfill Info',
        'description' => 'Displays Suggest Info for users to fulfill the scout info on Scout Detail page',
        'category' => 'Scout',
        'type' => 'widget',
        'name' => 'tfcampaign.profile-fulfill-info',
        'requirements' => array(
	      'subject' => 'tfcampaign_campaign',
	    ),
    ),
    
	array(
        'title' => 'Scout - Recent Scouts',
        'description' => 'Displays recent scouts on main page.',
        'category' => 'Scout',
        'type' => 'widget',
        'isPaginated' => true,
        'name' => 'tfcampaign.recent-campaign'
	),
	
	array(
        'title' => 'Scout - Profile Player Submissions',
        'description' => 'Displays Player Submissions on scout Detail page',
        'category' => 'Scout',
        'type' => 'widget',
        'name' => 'tfcampaign.profile-submission',
        'requirements' => array(
	      'subject' => 'tfcampaign_campaign',
	    ),
    ),
    
	array(
        'title' => 'Scout - Profile Hidden Submissions',
        'description' => 'Displays Player Hidden Submissions on scout Detail page',
        'category' => 'Scout',
        'type' => 'widget',
        'name' => 'tfcampaign.profile-hidden-submission',
        'requirements' => array(
	      'subject' => 'tfcampaign_campaign',
	    ),
    ),
);