<?php
return array(
	
	array(
        'title' => 'e-Tryouts - Filter e-Tryouts',
        'description' => 'Displays filter e-Tryouts in home page.',
        'category' => 'e-Tryouts',
        'type' => 'widget',
        'name' => 'tfcampaign.filter-campaigns'
	),
	
	array(
        'title' => 'e-Tryouts - My saved e-Tryouts',
        'description' => 'Displays saved e-Tryouts of user.',
        'category' => 'e-Tryouts',
        'type' => 'widget',
        'name' => 'tfcampaign.my-saved-campaigns'
	),
	
	array(
        'title' => 'e-Tryouts - My e-Tryouts',
        'description' => 'Displays e-Tryouts which are belong to user.',
        'category' => 'e-Tryouts',
        'type' => 'widget',
        'name' => 'tfcampaign.my-campaigns'
	),
	
	array(
        'title' => 'e-Tryouts - My submissions',
        'description' => 'Displays submissions which are belong to user.',
        'category' => 'e-Tryouts',
        'type' => 'widget',
        'name' => 'tfcampaign.my-submissions'
	),
	
	array(
        'title' => 'e-Tryouts - User Profile e-Tryouts',
        'description' => 'Displays campaign on user profile page.',
        'category' => 'e-Tryouts',
        'type' => 'widget',
        'isPaginated' => true,
        'name' => 'tfcampaign.user-profile-campaign'
	),
	
	array(
        'title' => 'e-Tryouts - Club Profile e-Tryouts',
        'description' => 'Displays campaign on club profile page.',
        'category' => 'e-Tryouts',
        'type' => 'widget',
        'isPaginated' => true,
        'name' => 'tfcampaign.club-profile-campaign'
	),
	
	array(
        'title' => 'e-Tryouts - Profile Player Fulfill Info',
        'description' => 'Displays Suggest Info for users to fulfill the campaign info on Campaign Detail page',
        'category' => 'e-Tryouts',
        'type' => 'widget',
        'name' => 'tfcampaign.profile-fulfill-info',
        'requirements' => array(
	      'subject' => 'tfcampaign_campaign',
	    ),
    ),
    
	array(
        'title' => 'e-Tryouts - Recent e-Tryouts',
        'description' => 'Displays recent e-Tryouts on main page.',
        'category' => 'e-Tryouts',
        'type' => 'widget',
        'isPaginated' => true,
        'name' => 'tfcampaign.recent-campaign'
	),
	
	array(
        'title' => 'e-Tryouts - Profile Player Submissions',
        'description' => 'Displays Player Submissions on campaign Detail page',
        'category' => 'e-Tryouts',
        'type' => 'widget',
        'name' => 'tfcampaign.profile-submission',
        'requirements' => array(
	      'subject' => 'tfcampaign_campaign',
	    ),
    ),
    
	array(
        'title' => 'e-Tryouts - Profile Hidden Submissions',
        'description' => 'Displays Player Hidden Submissions on campaign Detail page',
        'category' => 'e-Tryouts',
        'type' => 'widget',
        'name' => 'tfcampaign.profile-hidden-submission',
        'requirements' => array(
	      'subject' => 'tfcampaign_campaign',
	    ),
    ),
);