<?php
return array(
	array(
	    'title' => 'Business Pages Profile Members',
	    'description' => 'Displays a business\'s members on it\'s profile.',
	    'category' => 'Business Pages',
	    'type' => 'widget',
	    'name' => 'ynbusinesspages.business-profile-members',
	    'isPaginated' => true,
	    'defaultParams' => array(
	      'title' => 'Members',
	      'titleCount' => true,
	      'itemCountPerPage' => 10
	    ),
	    'requirements' => array(
	      'subject' => 'ynbusinesspages_business',
	    ),
	),
	
	array(
        'title' => 'Business Pages Main Menu',
        'description' => 'Displays main menu.',
        'category' => 'Business Pages',
        'type' => 'widget',
        'name' => 'ynbusinesspages.main-menu'
	),
	
	array(
        'title' => 'Business Pages Profile Reviews',
        'description' => 'Displays a list of reviews on the business.',
        'category' => 'Business Pages',
        'type' => 'widget',
        'name' => 'ynbusinesspages.business-profile-reviews',
        'isPaginated' => true,
        'defaultParams' => array(
          'title' => 'Reviews',
          'titleCount' => true,
          'itemCountPerPage' => 4
        ),
        'requirements' => array(
          'subject' => 'ynbusinesspages_business',
        ),
    ),
    
    array(
        'title' => 'Business Pages Profile Check-in',
        'description' => 'Displays a list of user has checked-in on the business.',
        'category' => 'Business Pages',
        'type' => 'widget',
        'name' => 'ynbusinesspages.business-profile-checkins',
        'isPaginated' => true,
        'defaultParams' => array(
            'title' => 'People check-in here',
            'itemCountPerPage' => 20,
        ),
        'requirements' => array(
          'subject' => 'ynbusinesspages_business',
        ),
    ),
	
	array(
	    'title' => 'Business Pages Create Link',
	    'description' => 'Displays business create link.',
	    'category' => 'Business Pages',
	    'type' => 'widget',
	    'name' => 'ynbusinesspages.business-create-link',
    ),
	
	array(
	    'title' => 'Business Pages Profile Announcements',
	    'description' => 'Displays recent announcements.',
	    'category' => 'Business Pages',
	    'type' => 'widget',
	    'name' => 'ynbusinesspages.business-profile-announcements',
	    'defaultParams' => array(
            'title' => 'Announcements',
        ),
	    'requirements' => array(
	      'subject'=>'ynbusinesspages_business',
	    ),
    ),
	
	array(
	    'title' => 'Business Pages Profile Operating Hours',
	    'description' => 'Displays business operating hours.',
	    'category' => 'Business Pages',
	    'type' => 'widget',
	    'name' => 'ynbusinesspages.business-profile-operating-hours',
	    'defaultParams' => array(
            'title' => 'Operating Hours',
        ),
	    'requirements' => array(
	      'subject'=>'ynbusinesspages_business',
	    ),
    ),
	
	array(
	    'title' => 'Business Pages Profile Contact Information',
	    'description' => 'Displays business contact information.',
	    'category' => 'Business Pages',
	    'type' => 'widget',
	    'name' => 'ynbusinesspages.business-profile-contact-info',
	    'defaultParams' => array(
            'title' => 'Contact Information',
        ),
	    'requirements' => array(
	      'subject'=>'ynbusinesspages_business',
	    ),
	    'adminForm' => array(
            'elements' => array(
				array(
					'Heading',
					'heading',
					array(
						'label' => 'Show/hide all information?'
					)
				),
				array(
					'Radio',
					'phone',
					array(
						'label' => 'Phone',
						'multiOptions' => array(
							1 => 'Yes.',
							0 => 'No.',
						),
						'value' => 1,
					)
				),
				array(
					'Radio',
					'fax',
					array(
						'label' => 'Fax',
						'multiOptions' => array(
							1 => 'Yes.',
							0 => 'No.',
						),
						'value' => 1,
					)
				),
				array(
                    'Radio',
                    'email',
                    array(
                        'label' => 'Email',
                        'multiOptions' => array(
                            1 => 'Yes.',
                            0 => 'No.',
                        ),
                        'value' => 1,
                    )
                ),
				array(
					'Radio',
					'website',
					array(
						'label' => 'Website',
						'multiOptions' => array(
							1 => 'Yes.',
							0 => 'No.',
						),
						'value' => 1,
					)
				),
			)
		)
    ),
	
	array(
        'title' => 'Business Pages Profile Cover Style 1',
        'description' => 'Displays Business Cover on Business Detail page',
        'category' => 'Business Pages',
        'type' => 'widget',
        'name' => 'ynbusinesspages.business-profile-cover-style1',
        'defaultParams' => array(
        ),
        'requirements' => array(
	      'subject' => 'ynbusinesspages_business',
	    ),
    ),
    
     array(
        'title' => 'Business Pages Profile Cover Style 2',
        'description' => 'Displays Business Cover on Business Detail page',
        'category' => 'Business Pages',
        'type' => 'widget',
        'name' => 'ynbusinesspages.business-profile-cover-style2',
        'defaultParams' => array(
        ),
        'requirements' => array(
	      'subject' => 'ynbusinesspages_business',
	    ),
    ),
    
	array(
        'title' => 'Business Pages Profile Cover Style 3',
        'description' => 'Displays Business Cover on Business Detail page',
        'category' => 'Business Pages',
        'type' => 'widget',
        'name' => 'ynbusinesspages.business-profile-cover-style3',
        'defaultParams' => array(
        ),
        'requirements' => array(
	      'subject' => 'ynbusinesspages_business',
	    ),
    ),
	
	 array(
        'title' => 'Business Pages Profile Overview',
        'description' => 'Displays Business Overview on Business Detail page',
        'category' => 'Business Pages',
        'type' => 'widget',
        'name' => 'ynbusinesspages.business-profile-overview',
        'defaultParams' => array(
            'title' => 'Overview',
        ),
        'requirements' => array(
	      'subject' => 'ynbusinesspages_business',
	    ),
    ),
    
	array(
        'title' => 'Business Pages Profile Contact',
        'description' => 'Displays Business Contact Form on Business Detail page',
        'category' => 'Business Pages',
        'type' => 'widget',
        'name' => 'ynbusinesspages.business-profile-contact',
        'defaultParams' => array(
            'title' => 'Contact Us',
        ),
        'requirements' => array(
	      'subject' => 'ynbusinesspages_business',
	    ),
    ),
	
	array(
        'title' => 'Business Pages Profile Photos',
        'description' => 'Displays Business Photos on Business Detail page',
        'category' => 'Business Pages',
        'type' => 'widget',
        'name' => 'ynbusinesspages.business-profile-photos',
        'isPaginated' => true,
        'defaultParams' => array(
            'title' => 'Photos',
            'titleCount' => true,
            'itemCountPerPage' => 8
        ),
        'requirements' => array(
	      'subject' => 'ynbusinesspages_business',
	    ),
    ),
    
	array(
        'title' => 'Business Pages Profile Discussions',
        'description' => 'Displays Business Discussions on Business Detail page',
        'category' => 'Business Pages',
        'type' => 'widget',
        'name' => 'ynbusinesspages.business-profile-discussions',
        'isPaginated' => true,
        'defaultParams' => array(
            'title' => 'Discussions',
            'titleCount' => true,
            'itemCountPerPage' => 5
        ),
        'requirements' => array(
	      'subject' => 'ynbusinesspages_business',
	    ),
    ),
    
	array(
        'title' => 'Business Pages Profile Videos',
        'description' => 'Displays Business Videos on Business Detail page',
        'category' => 'Business Pages',
        'type' => 'widget',
        'name' => 'ynbusinesspages.business-profile-videos',
        'isPaginated' => true,
        'defaultParams' => array(
            'title' => 'Videos',
            'titleCount' => true,
            'itemCountPerPage' => 5
        ),
        'requirements' => array(
	      'subject' => 'ynbusinesspages_business',
	    ),
    ),
    
	array(
        'title' => 'Business Pages Profile Events',
        'description' => 'Displays Business Events on Business Detail page',
        'category' => 'Business Pages',
        'type' => 'widget',
        'name' => 'ynbusinesspages.business-profile-events',
        'isPaginated' => true,
        'defaultParams' => array(
            'title' => 'Events',
            'titleCount' => true,
            'itemCountPerPage' => 5
        ),
        'requirements' => array(
	      'subject' => 'ynbusinesspages_business',
	    ),
    ),
    
	array(
        'title' => 'Business Pages Profile Options',
        'description' => 'Displays Options on Business Detail page',
        'category' => 'Business Pages',
        'type' => 'widget',
        'name' => 'ynbusinesspages.business-profile-options',
        'defaultParams' => array(
            'title' => '',
        ),
        'requirements' => array(
	      'subject' => 'ynbusinesspages_business',
	    ),
    ),
    
	array(
        'title' => 'Business Pages Profile Wikis',
        'description' => 'Displays Business Wikis on Business Detail page',
        'category' => 'Business Pages',
        'type' => 'widget',
        'name' => 'ynbusinesspages.business-profile-wikis',
        'isPaginated' => true,
        'defaultParams' => array(
            'title' => 'Wikis',
            'titleCount' => true,
            'itemCountPerPage' => 5
        ),
        'requirements' => array(
	      'subject' => 'ynbusinesspages_business',
	    ),
    ),
    
	array(
        'title' => 'Business Pages Profile Files',
        'description' => 'Displays Business Files on Business Detail page',
        'category' => 'Business Pages',
        'type' => 'widget',
        'name' => 'ynbusinesspages.business-profile-files',
        'defaultParams' => array(
            'title' => 'Files',
            'titleCount' => true,
        ),
        'requirements' => array(
	      'subject' => 'ynbusinesspages_business',
	    ),
    ),
	
    array(
        'title' => 'Business Pages Profile Followers',
        'description' => 'Displays Business Followers on Business Detail page',
        'category' => 'Business Pages',
        'type' => 'widget',
        'name' => 'ynbusinesspages.business-profile-followers',
        'isPaginated' => true,
        'defaultParams' => array(
            'title' => 'Followers',
            'titleCount' => true,
            'itemCountPerPage' => 15
        ),
        'requirements' => array(
	      'subject' => 'ynbusinesspages_business',
	    ),
    ),
	   
    array(
        'title' => 'Business Pages Profile Musics',
        'description' => 'Displays Business Musics on Business Detail page',
        'category' => 'Business Pages',
        'type' => 'widget',
        'name' => 'ynbusinesspages.business-profile-musics',
        'isPaginated' => true,
        'defaultParams' => array(
            'title' => 'Musics',
            'titleCount' => true,
            'itemCountPerPage' => 10
        ),
        'requirements' => array(
	      'subject' => 'ynbusinesspages_business',
	    ),
    ),
    
    array(
        'title' => 'Business Pages Profile Mp3Musics',
        'description' => 'Displays Business Mp3Musics on Business Detail page',
        'category' => 'Business Pages',
        'type' => 'widget',
        'name' => 'ynbusinesspages.business-profile-mp3musics',
        'isPaginated' => true,
        'defaultParams' => array(
            'title' => 'Mp3Musics',
            'titleCount' => true,
            'itemCountPerPage' => 10
        ),
        'requirements' => array(
            'subject' => 'ynbusinesspages_business',
        ),
    ),
    
    array(
        'title' => 'Business Pages Profile Blogs',
        'description' => 'Displays Business Blogs on Business Detail page',
        'category' => 'Business Pages',
        'type' => 'widget',
        'name' => 'ynbusinesspages.business-profile-blogs',
        'isPaginated' => true,
        'defaultParams' => array(
            'title' => 'Blogs',
            'titleCount' => true,
            'itemCountPerPage' => 10
        ),
        'requirements' => array(
            'subject' => 'ynbusinesspages_business',
        ),
    ),
    
    array(
        'title' => 'Business Pages Profile Classifieds',
        'description' => 'Displays Business Classifieds on Business Detail page',
        'category' => 'Business Pages',
        'type' => 'widget',
        'name' => 'ynbusinesspages.business-profile-classifieds',
        'isPaginated' => true,
        'defaultParams' => array(
            'title' => 'Classifieds',
            'titleCount' => true,
            'itemCountPerPage' => 10
        ),
        'requirements' => array(
            'subject' => 'ynbusinesspages_business',
        ),
    ),
    
    array(
        'title' => 'Business Pages Profile Groupbuys',
        'description' => 'Displays Business Groupbuys on Business Detail page',
        'category' => 'Business Pages',
        'type' => 'widget',
        'name' => 'ynbusinesspages.business-profile-groupbuys',
        'isPaginated' => true,
        'defaultParams' => array(
            'title' => 'Groupbuys',
            'titleCount' => true,
            'itemCountPerPage' => 10
        ),
        'requirements' => array(
            'subject' => 'ynbusinesspages_business',
        ),
    ),
    
    array(
        'title' => 'Business Pages Profile Contests',
        'description' => 'Displays Business Contests on Business Detail page',
        'category' => 'Business Pages',
        'type' => 'widget',
        'name' => 'ynbusinesspages.business-profile-contests',
        'isPaginated' => true,
        'defaultParams' => array(
            'title' => 'Contests',
            'titleCount' => true,
            'itemCountPerPage' => 10
        ),
        'requirements' => array(
            'subject' => 'ynbusinesspages_business',
        ),
    ),
    
    array(
        'title' => 'Business Pages Profile Listings',
        'description' => 'Displays Business Listings on Business Detail page',
        'category' => 'Business Pages',
        'type' => 'widget',
        'name' => 'ynbusinesspages.business-profile-listings',
        'isPaginated' => true,
        'defaultParams' => array(
            'title' => 'Listings',
            'titleCount' => true,
            'itemCountPerPage' => 10
        ),
        'requirements' => array(
            'subject' => 'ynbusinesspages_business',
        ),
    ),
    
    array(
        'title' => 'Business Pages Profile Polls',
        'description' => 'Displays Business Polls on Business Detail page',
        'category' => 'Business Pages',
        'type' => 'widget',
        'name' => 'ynbusinesspages.business-profile-polls',
        'isPaginated' => true,
        'defaultParams' => array(
            'title' => 'Polls',
            'titleCount' => true,
            'itemCountPerPage' => 10
        ),
        'requirements' => array(
            'subject' => 'ynbusinesspages_business',
        ),
    ),
    
    array(
        'title' => 'Business Pages Profile Jobs',
        'description' => 'Displays Business Jobs on Business Detail page',
        'category' => 'Business Pages',
        'type' => 'widget',
        'name' => 'ynbusinesspages.business-profile-jobs',
        'isPaginated' => true,
        'defaultParams' => array(
            'title' => 'Jobs',
            'titleCount' => true,
            'itemCountPerPage' => 10
        ),
        'requirements' => array(
            'subject' => 'ynbusinesspages_business',
        ),
    ),
    
    array(
        'title' => 'Business Pages Newest Blogs',
        'description' => 'Displays Newest Blogs of Business on Business Detail page',
        'category' => 'Business Pages',
        'type' => 'widget',
        'name' => 'ynbusinesspages.business-newest-blogs',
        'isPaginated' => true,
        'defaultParams' => array(
            'title' => 'Newest Blogs',
            'itemCountPerPage' => 1,
        ),
        'requirements' => array(
            'subject' => 'ynbusinesspages_business',
        ),
    ),
    
    array(
        'title' => 'Business Pages Newest Photos',
        'description' => 'Displays Newest Photos of Business on Business Detail page',
        'category' => 'Business Pages',
        'type' => 'widget',
        'name' => 'ynbusinesspages.business-newest-photos',
        'isPaginated' => true,
        'defaultParams' => array(
            'title' => 'Newest Photos',
            'itemCountPerPage' => 1,
        ),
        'requirements' => array(
            'subject' => 'ynbusinesspages_business',
        ),
    ),
    
    array(
        'title' => 'Business Pages Newest Videos',
        'description' => 'Displays Newest Videos of Business on Business Detail page',
        'category' => 'Business Pages',
        'type' => 'widget',
        'name' => 'ynbusinesspages.business-newest-videos',
        'isPaginated' => true,
        'defaultParams' => array(
            'title' => 'Newest Videos',
            'itemCountPerPage' => 1,
        ),
        'requirements' => array(
            'subject' => 'ynbusinesspages_business',
        ),
    ),
    
    array(
        'title' => 'Business Pages Newest Discussions',
        'description' => 'Displays Newest Discussions of Business on Business Detail page',
        'category' => 'Business Pages',
        'type' => 'widget',
        'name' => 'ynbusinesspages.business-newest-discussions',
        'isPaginated' => true,
        'defaultParams' => array(
            'title' => 'Newest Discussions',
            'itemCountPerPage' => 1,
        ),
        'requirements' => array(
            'subject' => 'ynbusinesspages_business',
        ),
    ),
    
    array(
        'title' => 'Business Pages Newest Files',
        'description' => 'Displays Newest Files of Business on Business Detail page',
        'category' => 'Business Pages',
        'type' => 'widget',
        'name' => 'ynbusinesspages.business-newest-files',
        'isPaginated' => true,
        'defaultParams' => array(
            'title' => 'Newest Files',
            'itemCountPerPage' => 1,
        ),
        'requirements' => array(
            'subject' => 'ynbusinesspages_business',
        ),
    ),
    
    array(
        'title' => 'Business Pages Newest Events',
        'description' => 'Displays Newest Events of Business on Business Detail page',
        'category' => 'Business Pages',
        'type' => 'widget',
        'name' => 'ynbusinesspages.business-newest-events',
        'isPaginated' => true,
        'defaultParams' => array(
            'title' => 'Newest Events',
            'itemCountPerPage' => 1,
        ),
        'requirements' => array(
            'subject' => 'ynbusinesspages_business',
        ),
    ),
    
    array(
        'title' => 'Business Pages Newest Wikis',
        'description' => 'Displays Newest Wikis of Business on Business Detail page',
        'category' => 'Business Pages',
        'type' => 'widget',
        'name' => 'ynbusinesspages.business-newest-wikis',
        'isPaginated' => true,
        'defaultParams' => array(
            'title' => 'Newest Wikis',
            'itemCountPerPage' => 1,
        ),
        'requirements' => array(
            'subject' => 'ynbusinesspages_business',
        ),
    ),
    
    array(
        'title' => 'Business Pages Newest Classifieds',
        'description' => 'Displays Newest Classifieds of Business on Business Detail page',
        'category' => 'Business Pages',
        'type' => 'widget',
        'name' => 'ynbusinesspages.business-newest-classifieds',
        'isPaginated' => true,
        'defaultParams' => array(
            'title' => 'Newest Classifieds',
            'itemCountPerPage' => 1,
        ),
        'requirements' => array(
            'subject' => 'ynbusinesspages_business',
        ),
    ),
    
    array(
        'title' => 'Business Pages Newest Contests',
        'description' => 'Displays Newest Contests of Business on Business Detail page',
        'category' => 'Business Pages',
        'type' => 'widget',
        'name' => 'ynbusinesspages.business-newest-contests',
        'isPaginated' => true,
        'defaultParams' => array(
            'title' => 'Newest Contests',
            'itemCountPerPage' => 1,
        ),
        'requirements' => array(
            'subject' => 'ynbusinesspages_business',
        ),
    ),
    
    array(
        'title' => 'Business Pages Newest Polls',
        'description' => 'Displays Newest Polls of Business on Business Detail page',
        'category' => 'Business Pages',
        'type' => 'widget',
        'name' => 'ynbusinesspages.business-newest-polls',
        'isPaginated' => true,
        'defaultParams' => array(
            'title' => 'Newest Polls',
            'itemCountPerPage' => 1,
        ),
        'requirements' => array(
            'subject' => 'ynbusinesspages_business',
        ),
    ),
    
    array(
        'title' => 'Business Pages Newest Listings',
        'description' => 'Displays Newest Listings of Business on Business Detail page',
        'category' => 'Business Pages',
        'type' => 'widget',
        'name' => 'ynbusinesspages.business-newest-listings',
        'isPaginated' => true,
        'defaultParams' => array(
            'title' => 'Newest Listings',
            'itemCountPerPage' => 1,
        ),
        'requirements' => array(
            'subject' => 'ynbusinesspages_business',
        ),
    ),
    
    array(
        'title' => 'Business Pages Newest Jobs',
        'description' => 'Displays Newest Jobs of Business on Business Detail page',
        'category' => 'Business Pages',
        'type' => 'widget',
        'name' => 'ynbusinesspages.business-newest-jobs',
        'isPaginated' => true,
        'defaultParams' => array(
            'title' => 'Newest Jobs',
            'itemCountPerPage' => 1,
        ),
        'requirements' => array(
            'subject' => 'ynbusinesspages_business',
        ),
    ),
    
    array(
        'title' => 'Business Pages Newest Deals',
        'description' => 'Displays Newest Deals of Business on Business Detail page',
        'category' => 'Business Pages',
        'type' => 'widget',
        'name' => 'ynbusinesspages.business-newest-groupbuys',
        'isPaginated' => true,
        'defaultParams' => array(
            'title' => 'Newest Deals',
            'itemCountPerPage' => 1,
        ),
        'requirements' => array(
            'subject' => 'ynbusinesspages_business',
        ),
    ),
    
    array(
        'title' => 'Business Pages Newest Mp3Music Albums',
        'description' => 'Displays Newest Mp3Music Albums of Business on Business Detail page',
        'category' => 'Business Pages',
        'type' => 'widget',
        'name' => 'ynbusinesspages.business-newest-mp3musics',
        'isPaginated' => true,
        'defaultParams' => array(
            'title' => 'Newest Albums',
            'itemCountPerPage' => 1,
        ),
        'requirements' => array(
            'subject' => 'ynbusinesspages_business',
        ),
    ),
    
    array(
        'title' => 'Business Pages Newest Musics Playlists',
        'description' => 'Displays Newest Musics Playlists of Business on Business Detail page',
        'category' => 'Business Pages',
        'type' => 'widget',
        'name' => 'ynbusinesspages.business-newest-musics',
        'isPaginated' => true,
        'defaultParams' => array(
            'title' => 'Newest Playlists',
            'itemCountPerPage' => 1,
        ),
        'requirements' => array(
            'subject' => 'ynbusinesspages_business',
        ),
    ),
    
    array(
        'title' => 'Business Pages Featured Businesses',
        'description' => 'Displays featured Businesses',
        'category' => 'Business Pages',
        'type' => 'widget',
        'name' => 'ynbusinesspages.featured-businesses',
        'defaultParams' => array(
            'title' => 'Featured Businesses',
        ),
        'adminForm' => array(
            'elements' => array(
                array(
                    'Text',
					'title',
					array(
					   'label' => 'Title'
					)
				),	
				array(
					'Select',
					'max_business',
					array(
						'label' => 'Count(number of items to show)?',
						'multiOptions' => array(
							'4' => '4',
							'8' => '8',
							'12' => '12',
							'16' => '16',
							'20' => '20',
						),
						'value' => 'list',
					)
				),
			)
		)
    ),
    
    array(
        'title' => 'Business Pages Browse Categories',
        'description' => 'Displays categories level 1 and child.',
        'category' => 'Business Pages',
        'type' => 'widget',
        'name' => 'ynbusinesspages.browse-categories',
        'defaultParams' => array(
          'title' => 'Browse Categories',
        ),
    ),
    
    array(
        'title' => 'Business Pages Newest Businesses',
        'description' => 'Displays newest businesses.',
        'category' => 'Business Pages',
        'type' => 'widget',
        'name' => 'ynbusinesspages.newest-businesses',
        'isPaginated' => true,
        'defaultParams' => array(
          'title' => 'Newest Businesses',
           'itemCountPerPage' => 12
        ),
    ),
    
    array(
        'title' => 'Business Pages Search',
        'description' => 'Displays form for searching businesses',
        'category' => 'Business Pages',
        'type' => 'widget',
        'name' => 'ynbusinesspages.business-search',
        'defaultParams' => array(
            'title' => 'Business Search',
        ),
    ),
    
    array(
        'title' => 'Business Pages Manage Menu',
        'description' => 'Displays manage menu in my business page',
        'category' => 'Business Pages',
        'type' => 'widget',
        'name' => 'ynbusinesspages.business-manage-menu',
        'defaultParams' => array(
        ),
    ),
    
    array(
        'title' => 'Business Pages List Categories',
        'description' => 'Displays a list of categories.',
        'category' => 'Business Pages',
        'type' => 'widget',
        'name' => 'ynbusinesspages.list-categories',
        'defaultParams' => array(
            'title' => 'Categories',
        ),
    ),
    
    array(
        'title' => 'Business Pages Most Liked Businesses',
        'description' => 'Displays a list of most liked businesses.',
        'category' => 'Business Pages',
        'type' => 'widget',
        'name' => 'ynbusinesspages.most-liked-businesses',
        'isPaginated' => true,
        'defaultParams' => array(
            'title' => 'Most Liked Businesses',
        ),
    ),
    
    array(
        'title' => 'Business Pages Most Viewed Businesses',
        'description' => 'Displays a list of most viewed businesses.',
        'category' => 'Business Pages',
        'type' => 'widget',
        'name' => 'ynbusinesspages.most-viewed-businesses',
        'isPaginated' => true,
        'defaultParams' => array(
            'title' => 'Most Viewed Businesses',
        ),
    ),
    
    array(
        'title' => 'Business Pages Most Rated Businesses',
        'description' => 'Displays a list of most rated businesses.',
        'category' => 'Business Pages',
        'type' => 'widget',
        'name' => 'ynbusinesspages.most-rated-businesses',
        'isPaginated' => true,
        'defaultParams' => array(
            'title' => 'Most Rated Businesses',
        ),
    ),
    
    array(
        'title' => 'Business Pages Recent Reviews',
        'description' => 'Displays a list of recent reviews',
        'category' => 'Business Pages',
        'type' => 'widget',
        'name' => 'ynbusinesspages.recent-reviews',
        'isPaginated' => true,
        'defaultParams' => array(
            'title' => 'Recent Reviews',
        ),
    ),
    
    array(
        'title' => 'Business Pages Businesses You May Like',
        'description' => 'Displays a list of busineses you may like.',
        'category' => 'Business Pages',
        'type' => 'widget',
        'name' => 'ynbusinesspages.businesses-you-may-like',
        'isPaginated' => true,
        'defaultParams' => array(
            'title' => 'Businesses You May Like',
        ),
    ),
    
    array(
        'title' => 'Business Pages Profile Related Businesses',
        'description' => 'Displays a list related Businesses on Business Detail Page.',
        'category' => 'Business Pages',
        'type' => 'widget',
        'name' => 'ynbusinesspages.business-profile-related-businesses',
        'isPaginated' => true,
        'defaultParams' => array(
            'title' => 'Related Businesses',
        ),
        'requirements' => array(
            'subject' => 'ynbusinesspages_business',
        ),
    ),
    
    array(
        'title' => 'Business Pages Most Discussed Businesses',
        'description' => 'Displays a list of most discussed businesses.',
        'category' => 'Business Pages',
        'type' => 'widget',
        'name' => 'ynbusinesspages.most-discussed-businesses',
        'isPaginated' => true,
        'defaultParams' => array(
            'title' => 'Most Discussed Businesses',
        ),
    ),
    
    array(
        'title' => 'Business Pages Most Checked-in Businesses',
        'description' => 'Displays a list of most checked-in businesses.',
        'category' => 'Business Pages',
        'type' => 'widget',
        'name' => 'ynbusinesspages.most-checkedin-businesses',
        'isPaginated' => true,
        'defaultParams' => array(
            'title' => 'Most Checked-in Businesses',
        ),
    ),
    
    array(
        'title' => 'Business Pages Businesses Tags',
        'description' => 'Displays businesses tags.',
        'category' => 'Business Pages',
        'type' => 'widget',
        'name' => 'ynbusinesspages.businesses-tags',
          'defaultParams' => array(
            'title' => 'Tags',
        ),
    ),
    
	array(
        'title' => 'Business Pages Businesses Listing',
        'description' => 'Displays Businesses Listing',
        'category' => 'Business Pages',
        'type' => 'widget',
        'name' => 'ynbusinesspages.businesses-listing',
        'isPaginated' => true,
		'defaultParams' => array(
      		'title' => '',
      		'itemCountPerPage' => 12
    	),
        'requirements' => array(
        ),
        'adminForm' => array(
            'elements' => array(
                array(
                    'Text',
					'title',
					array(
					   'label' => 'Title'
					)
				),	
				array(
					'Heading',
					'mode_enabled',
					array(
						'label' => 'Which view modes are enabled?'
					)
				),
				array(
					'Radio',
					'mode_list',
					array(
						'label' => 'List view.',
						'multiOptions' => array(
							1 => 'Yes.',
							0 => 'No.',
						),
						'value' => 1,
					)
				),
				array(
					'Radio',
					'mode_grid',
					array(
						'label' => 'Grid view.',
						'multiOptions' => array(
							1 => 'Yes.',
							0 => 'No.',
						),
						'value' => 1,
					)
				),
				array(
                    'Radio',
                    'mode_pin',
                    array(
                        'label' => 'Pin view.',
                        'multiOptions' => array(
                            1 => 'Yes.',
                            0 => 'No.',
                        ),
                        'value' => 1,
                    )
                ),
				array(
					'Radio',
					'mode_map',
					array(
						'label' => 'Map view.',
						'multiOptions' => array(
							1 => 'Yes.',
							0 => 'No.',
						),
						'value' => 1,
					)
				),
				array(
					'Radio',
					'view_mode',
					array(
						'label' => 'Which view mode is default?',
						'multiOptions' => array(
							'list' => 'List view.',
							'grid' => 'Grid view.',
							'map' => 'Map view.',
							'pin' => 'Pin view.',
						),
						'value' => 'list',
					)
				),
			)
		)
	),
    
    array(
        'title' => 'Business Pages Compare Businesses Bar',
        'description' => 'Displays Compare Businesses Bar.',
        'category' => 'Business Pages',
        'type' => 'widget',
        'name' => 'ynbusinesspages.compare-bar',
        'defaultParams' => array(
            'title' => '',
        ),
    ),
    array(
        'title' => 'Business Pages Dashboard Menu',
        'description' => 'Business Pages Dashboard Menu',
        'category' => 'Business Pages',
        'type' => 'widget',
        'name' => 'ynbusinesspages.dashboard-menu',
        'defaultParams' => array(
            'title' => '',
        ),
    ),
    
    array(
        'title' => 'Business Pages Item Business Info',
        'description' => 'Business Pages Item Business Info',
        'category' => 'Business Pages',
        'type' => 'widget',
        'name' => 'ynbusinesspages.item-business',
        'defaultParams' => array(
            'title' => 'Business Info',
        ),
    ),
);