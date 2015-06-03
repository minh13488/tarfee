<?php

return array(

  // Profile Blogs Widget
  array(
    'title' => 'Profile Blogs',
    'description' => 'Displays a member\'s blog entries on their profile.',
    'category' => 'Advanced Blogs',
    'type' => 'widget',
    'name' => 'ynblog.profile-blogs',
    'defaultParams' => array(
        'title' => 'Blogs',
        'titleCount' => true,
    ),
  ),

  //Blogs Menu Widget
  array(
    'title' => 'Blog Menu',
    'description' => 'Displays menu blogs on Blog Browse Page.',
    'category' => 'Advanced Blogs',
    'type' => 'widget',
    'name' => 'ynblog.blogs-menu',
  ),
  
  // Top Blogs (Most Liked Blogs) Widget
  array(
    'title' => 'Top Blogs',
    'description' => 'Displays most liked blogs on Blog Browse Page.',
    'category' => 'Advanced Blogs',
    'type' => 'widget',
    'name' => 'ynblog.top-blogs',
    'defaultParams' => array(
      'title' => 'Top Blogs',
    ),
    'adminForm' => array(
        'elements' => array(
          array('Text', 'title', array( 'label' => 'Title')),
          array('Text', 'max', array('label' => 'Number of Blogs show on page.',
                                     'value' => 8)),
        )
    ),
  ),

  // New Blogs Widget
   array(
    'title' => 'New Blogs',
    'description' => 'Displays new blogs on Blog Browse Page.',
    'category' => 'Advanced Blogs',
    'type' => 'widget',
    'name' => 'ynblog.new-blogs',
    'defaultParams' => array(
      'title' => 'New Blogs',
    ),
    'adminForm' => array(
        'elements' => array(
          array('Text', 'title', array('label' => 'Title')),
          array('Text', 'max', array( 'label' => 'Number of Blogs show on page.',
                                      'value' => 8)),
        )
     ),
    ),

   //Most Viewed Blogs Widget
   array(
    'title' => 'Most Viewed Blogs',
    'description' => 'Displays most viewed blogs on Blog Browse Page.',
    'category' => 'Advanced Blogs',
    'type' => 'widget',
    'name' => 'ynblog.most-viewed-blogs',
    'defaultParams' => array(
      'title' => 'Most Viewed Blogs',
    ),
    'adminForm' => array(
        'elements' => array(
          array('Text', 'title', array( 'label' => 'Title')),
          array('Text', 'max',array( 'label' => 'Number of Blogs show on page.',
                                     'value' => 4)),
        )
     ),
   ),

   //Most Commented Blogs Widget
   array(
    'title' => 'Most Commented Blogs',
    'description' => 'Displays most commented blogs on Blog Browse Page.',
    'category' => 'Advanced Blogs',
    'type' => 'widget',
    'name' => 'ynblog.most-commented-blogs',
    'defaultParams' => array(
      'title' => 'Most Commented Blogs',
    ),
    'adminForm' => array(
        'elements' => array(
            array('Text', 'title', array('label' => 'Title')),
            array('Text', 'max', array('label' => 'Number of Blogs show on page.',
                                       'value' => 4)),
        )
     ),
  ),

  //Featured Blogs Widget
  array(
    'title' => 'Featured Blogs',
    'description' => 'Displays featured blogs on Blog Browse Page.',
    'category' => 'Advanced Blogs',
    'type' => 'widget',
    'name' => 'ynblog.featured-blogs',
      'defaultParams' => array(
      'title' => 'Featured Blogs',
    ),
  ),

  //Blog Categories Widget
  array(
    'title' => 'Blog Categories',
    'description' => 'Displays blog categories on browse blogs page.',
    'category' => 'Advanced Blogs',
    'type' => 'widget',
    'name' => 'ynblog.blog-categories',
  ),

  //Blog Search Widget
  array(
    'title' => 'Blogs Search',
    'description' => 'Displays blog search box on browse blogs page.',
    'category' => 'Advanced Blogs',
    'type' => 'widget',
    'name' => 'ynblog.blogs-search',
  ),
  
  //Blog Listing Widget
  array(
    'title' => 'Blogs Listing',
    'description' => 'Displays list of blogs on Listing Blogs Page.',
    'category' => 'Advanced Blogs',
    'type' => 'widget',
    'name' => 'ynblog.blogs-listing',
  ),

  //Blog Statistics
   array(
    'title' => 'Blog Statistics',
    'description' => 'Displays blog statistics on Blogs Browse Page.',
    'category' => 'Advanced Blogs',
    'type' => 'widget',
    'name' => 'ynblog.blogs-statistic',
  ),
  
  //Top Bloggers Widget
  array(
    'title' => 'Top Bloggers',
    'description' => 'Displays top bloggers on Blogs Browse Page.',
    'category' => 'Advanced Blogs',
    'type' => 'widget',
    'name' => 'ynblog.top-bloggers',
    'defaultParams' => array(
      'title' => 'Top Bloggers',
    ),
    'adminForm' => array(
        'elements' => array(
          array('Text', 'title', array('label' => 'Title')),
          array('Text', 'max', array( 'label' => 'Number of Bloggers show on page.',
                                      'value' => 12)),
        )
     ),
   ),

  //View By Date Blogs Widget
  array(
    'title' => 'View By Date',
    'description' => 'Displays view by date on Blogs Browse Page.',
    'category' => 'Advanced Blogs',
    'type' => 'widget',
    'name' => 'ynblog.view-by-date-blogs',
  ),

  //Blog Tags Widget
  array(
    'title' => 'Tags',
    'description' => 'Displays tags on Blogs Browse Page.',
    'category' => 'Advanced Blogs',
    'type' => 'widget',
    'name' => 'ynblog.blogs-tags',
  ),

  // Blog Owner Photo Widget
   array(
    'title' => 'Blog Owner Photo',
    'description' => 'Displays blog owner photo on User Blog List Page.',
    'category' => 'Advanced Blogs',
    'type' => 'widget',
    'name' => 'ynblog.owner-photo',
  ),

    // Blog Gluter Menu Widget
   array(
    'title' => 'Blog Side Menu',
    'description' => 'Displays blog side menu on User Blog List Page.',
    'category' => 'Advanced Blogs',
    'type' => 'widget',
    'name' => 'ynblog.blogs-side-menu',
   ),

     // Blog User Archieves Widget
   array(
    'title' => 'Blog User Archive',
    'description' => 'Displays user\'s blog archives Blog List Page.',
    'category' => 'Advanced Blogs',
    'type' => 'widget',
    'name' => 'ynblog.user-blog-archives',
   ),
)?>