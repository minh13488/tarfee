<?php
class Advgroup_Form_Admin_Settings_Level extends Authorization_Form_Admin_Level_Abstract
{
  public function init()
  {
    parent::init();

    // My stuff
    $this
      ->setTitle('Member Level Settings')
      ->setDescription('GROUP_FORM_ADMIN_LEVEL_DESCRIPTION');

    // Element: view
    $this->addElement('Radio', 'view', array(
      'label' => 'Allow Viewing of organizations?',
      'description' => 'GROUP_FORM_ADMIN_LEVEL_VIEW_DESCRIPTION',
      'multiOptions' => array(
        2 => 'Yes, allow members to view all organizations, even private ones.',
        1 => 'Yes, allow viewing and subscription of organizations.',
        0 => 'No, do not allow organizations to be viewed.',
      ),
      'value' => ( $this->isModerator() ? 2 : 1 ),
    ));
    if( !$this->isModerator() ) {
      unset($this->view->options[2]);
    }
	
	/*
    if($this->isModerator()){
         $this->addElement('Radio', 'announcement', array(
        'label' => 'Allow  to manage Announcements of organizations?',
        'description' => 'Do you want to allow this user level to manage announcements of all organizations?',
        'multiOptions' => array(
          1 => 'Yes, allow to manage announcemnents of all organizations.',
          0 => 'No, do not allow to manage announcemnents of any organizations.',
        ),
        'value' => 0,
      ));
    }
	
    if($this->isModerator()){
         $this->addElement('Radio', 'invitation', array(
        'label' => 'Allow  to manage Invitations of organizations?',
        'description' => 'Do you want to allow this user level to manage invitations of all organizations?',
        'multiOptions' => array(
          1 => 'Yes, allow to manage invitations of all organizations.',
          0 => 'No, do not allow to manage invitations of any organizations.',
        ),
        'value' => 0,
      ));
    }
    */
    if( !$this->isPublic() ) {

      // Element: create
      $this->addElement('Radio', 'create', array(
        'label' => 'Allow Creation of organizations?',
        'description' => 'GROUP_FORM_ADMIN_LEVEL_CREATE_DESCRIPTION',
        'multiOptions' => array(
          1 => 'Yes, allow creation of organizations.',
          0 => 'No, do not allow organizations to be created.',
        ),
        'value' => 1,
      ));
	 /*
      $this->addElement('Text', 'numberSubgroup', array(
        'label' => 'Number of Sub organizations per Club',
        'description' => 'How many sub organizations that an user can create in a club? (Enter a number between 1 and 10)',
        'allowEmpty' =>false,
        'validators' => array(
            array('Int',true),
            array('Between',true,array(1,10)),
        ),
       ));
       */
      // Element: edit
      $this->addElement('Radio', 'edit', array(
        'label' => 'Allow Editing of organizations?',
        'description' => 'Do you want to let users edit organizations?',
        'multiOptions' => array(
          2 => 'Yes, allow members to edit everyone\'s organizations.',
          1 => 'Yes, allow  members to edit their own organizations.',
          0 => 'No, do not allow organizations to be edited.',
        ),
        'value' => ( $this->isModerator() ? 2 : 1 ),
      ));
      if( !$this->isModerator() ) {
        unset($this->edit->options[2]);
      }

      // Element: delete
      $this->addElement('Radio', 'delete', array(
        'label' => 'Allow Deletion of organizations?',
        'description' => 'Do you want to let members delete organizations? If set to no, some other settings on this page may not apply.',
        'multiOptions' => array(
          2 => 'Yes, allow members to delete all organizations.',
          1 => 'Yes, allow members to delete their own organizations.',
          0 => 'No, do not allow members to delete their organizations.',
        ),
        'value' => ( $this->isModerator() ? 2 : 1 ),
      ));
      if( !$this->isModerator() ) {
        unset($this->delete->options[2]);
      }
	/*
      // Element: comment
      $this->addElement('Radio', 'comment', array(
        'label' => 'Allow Commenting on organizations?',
        'description' => 'Do you want to let members of this level comment on organizations?',
        'multiOptions' => array(
          2 => 'Yes, allow members to comment on all organizations, including private ones.',
          1 => 'Yes, allow members to comment on organizations.',
          0 => 'No, do not allow members to comment on organizations.',
        ),
        'value' => ( $this->isModerator() ? 2 : 1 ),
      ));
      if( !$this->isModerator() ) {
        unset($this->comment->options[2]);
      }

      //Allow Upload photo
       $this->addElement('Radio', 'photo', array(
        'label' => 'Allow Upload Photo on organizations?',
        'description' => 'Do you want to let members of this level upload photo on organizations?',
        'multiOptions' => array(
          1 => 'Yes, allow members to upload photo on organizations.',
          0 => 'No, do not allow members to upload photo on organizations.',
        ),
        'value' => 1,
      ));
      $this->addElement('Text', 'numberPhoto', array(
        'label' => 'Number of Photos per Album',
        'description' => 'How many Photos that a user can upload in an album? (Enter a number between 0 and 999, 0 means unlimited)',
        'allowEmpty' => false,
        'validators' => array(
            array('Int',true),
            array('Between',true,array(0,999)),
            ),

       ));
      //Allow Create Album
       $this->addElement('Radio', 'album', array(
        'label' => 'Allow Create Photo Albums on organizations?',
        'description' => 'Do you want to let members of this level create photo albums on organizations?',
        'multiOptions' => array(
          1 => 'Yes, allow members to create photo albums on organizations.',
          0 => 'No, do not allow members to create photo albums on organizations.',
        ),
        'value' => 1,
      ));
      $this->addElement('Text', 'numberAlbum', array(
        'label' => 'Number of Albums per Club',
        'description' => 'How many Albums that a user can create in a club? (Enter a number between 0 and 999, 0 means unlimited)',
        'allowEmpty' => false,
        'validators' => array(
            array('Int',true),
            array('Between',true,array(0,999)),
        ),
       ));

      //Allow Create Poll
      $this->addElement('Radio', 'poll', array(
        'label' => 'Allow Create Polls on organizations?',
        'description' => 'Do you want to let members of this level create polls on organizations?',
        'multiOptions' => array(
          1 => 'Yes, allow members to create polls on organizations.',
          0 => 'No, do not allow members to create polls on organizations.',
        ),
        'value' => 1,
      ));

      //Allow Create Sub Club
      $this->addElement('Radio', 'sub_group', array(
        'label' => 'Allow Create Sub organizations on organizations?',
        'description' => 'Do you want to let members of this level create sub organizations on organizations?',
        'multiOptions' => array(
          1 => 'Yes, allow members to create sub organizations on organizations.',
          0 => 'No, do not allow members to create sub organizations on organizations.',
        ),
        'value' => 1,
      ));
      //Allow Create Video
      $this->addElement('Radio', 'video', array(
        'label' => 'Allow Create Videos on organizations?',
        'description' => 'Do you want to let members of this level create videos on organizations?',
        'multiOptions' => array(
          1 => 'Yes, allow members to create videos on organizations.',
          0 => 'No, do not allow members to create videos on organizations.',
        ),
        'value' => 1,
      ));
		
      //Allow Create Wiki Page
      $this->addElement('Radio', 'wiki', array(
        'label' => 'Allow Create Wiki Pages on organizations?',
        'description' => 'Do you want to let members of this level create wiki pages on organizations?',
        'multiOptions' => array(
          1 => 'Yes, allow members to create wiki pages on organizations.',
          0 => 'No, do not allow members to create wiki pages on organizations.',
        ),
        'value' => 1,
      ));
      
      //Allow Create Music Page
      $this->addElement('Radio', 'music', array(
        'label' => 'Allow Create Music Pages on organizations?',
        'description' => 'Do you want to let members of this level create music pages on organizations?',
        'multiOptions' => array(
          1 => 'Yes, allow members to create music pages on organizations.',
          0 => 'No, do not allow members to create music pages on organizations.',
        ),
        'value' => 1,
      ));
      
       //Allow Create Folder Page
      $this->addElement('Radio', 'folder', array(
        'label' => 'Allow Create Folder Pages on organizations?',
        'description' => 'Do you want to let members of this level create folder pages on organizations?',
        'multiOptions' => array(
          1 => 'Yes, allow members to create folder pages on organizations.',
          0 => 'No, do not allow members to create folder pages on organizations.',
        ),
        'value' => 1,
      ));
      
      //Allow Create Listing Page
      $this->addElement('Radio', 'listing', array(
        'label' => 'Allow Create Listing Pages on organizations?',
        'description' => 'Do you want to let members of this level create listing pages on organizations?',
        'multiOptions' => array(
          1 => 'Yes, allow members to create listing pages on organizations.',
          0 => 'No, do not allow members to create listing pages on organizations.',
        ),
        'value' => 1,
      ));
      */
      // Element: auth_view
      $this->addElement('MultiCheckbox', 'auth_view', array(
        'label' => 'Organization Viewing Options',
        'description' => 'GROUP_FORM_ADMIN_LEVEL_AUTHVIEW_DESCRIPTION',
        'multiOptions' => array(
          'everyone' => 'Everyone',
          'registered' => 'Registered Members',
          'member' => 'Members Only',
          //'officer' => 'Officers and Owner Only',
          //'owner' => 'Owner Only'
        )
      ));
		
		/*
      // Element: auth_comment
      $this->addElement('MultiCheckbox', 'auth_comment', array(
        'label' => 'Club Posting Options',
        'description' => 'GROUP_FORM_ADMIN_LEVEL_AUTHCOMMENT_DESCRIPTION',
        'multiOptions' => array(
          'registered' => 'Registered Members',
          'member' => 'All Members',
          'officer' => 'Officers and Owner Only',
          //'owner' => 'Owner Only',
        )
      ));

      // Element: auth_photo
      $this->addElement('MultiCheckbox', 'auth_photo', array(
        'label' => 'Photo Upload Options',
        'description' => 'GROUP_FORM_ADMIN_LEVEL_AUTHPHOTO_DESCRIPTION',
        'multiOptions' => array(
          'registered' => 'Registered Members',
          'member' => 'All Members',
          'officer' => 'Officers and Owner Only',
          //'owner' => 'Owner Only',
        )
      ));

      // Element: auth_event
      $this->addElement('MultiCheckbox', 'auth_event', array(
        'label' => 'Event Creation Options',
        'description' => 'GROUP_FORM_ADMIN_LEVEL_AUTHEVENT_DESCRIPTION',
        'multiOptions' => array(
          'registered' => 'Registered Members',
          'member' => 'All Members',
          'officer' => 'Officers and Owner Only',
          //'owner' => 'Owner Only',
        )
      ));

      // Element: auth_poll
      $this->addElement('MultiCheckbox', 'auth_poll', array(
        'label' => 'Poll Creation Options',
        'description' => 'GROUP_FORM_ADMIN_LEVEL_AUTHPOLL_DESCRIPTION',
        'multiOptions' => array(
          'registered' => 'Registered Members',
          'member' => 'All Members',
          'officer' => 'Officers and Owner Only',
          //'owner' => 'Owner Only',
        )
      ));

      // Element: auth_sub_Club
      $this->addElement('MultiCheckbox', 'auth_sub_group', array(
        'label' => 'Sub Club Creation Options',
        'description' => 'GROUP_FORM_ADMIN_LEVEL_AUTHSUBGROUP_DESCRIPTION',
        'multiOptions' => array(
          'registered' => 'Registered Members',
          'member' => 'All Members',
          'officer' => 'Officers and Owner Only',
          //'owner' => 'Owner Only',
        )
      ));

      // Element: auth_video
      $this->addElement('MultiCheckbox', 'auth_video', array(
        'label' => 'Video Creation Options',
        'description' => 'GROUP_FORM_ADMIN_LEVEL_AUTHVIDEO_DESCRIPTION',
        'multiOptions' => array(
          'registered' => 'Registered Members',
          'member' => 'All Members',
          'officer' => 'Officers and Owner Only',
          //'owner' => 'Owner Only',
        )
      ));

      // Element: auth_wiki
      $this->addElement('MultiCheckbox', 'auth_wiki', array(
        'label' => 'Wiki Page Creation Options',
        'description' => 'GROUP_FORM_ADMIN_LEVEL_AUTHWIKI_DESCRIPTION',
        'multiOptions' => array(
          'registered' => 'Registered Members',
          'member' => 'All Members',
          'officer' => 'Officers and Owner Only',
          //'owner' => 'Owner Only',
        )
      ));
      
      // Element: auth_music
      $this->addElement('MultiCheckbox', 'auth_music', array(
        'label' => 'Music Page Creation Options',
        'description' => 'GROUP_FORM_ADMIN_LEVEL_AUTHMUSIC_DESCRIPTION',
        'multiOptions' => array(
          'registered' => 'Registered Members',
          'member' => 'All Members',
          'officer' => 'Officers and Owner Only',
          //'owner' => 'Owner Only',
        )
      ));
      
      // Element: auth_folder
      $this->addElement('MultiCheckbox', 'auth_folder', array(
        'label' => 'Folder Page Creation Options',
        'description' => 'GROUP_FORM_ADMIN_LEVEL_AUTHFILE_DESCRIPTION',
        'multiOptions' => array(
          'registered' => 'Registered Members',
          'member' => 'All Members',
          'officer' => 'Officers and Owner Only',
          //'owner' => 'Owner Only',
        )
      ));
      
      // Element: auth_file_upload
      $this->addElement('MultiCheckbox', 'auth_file_upload', array(
        'label' => 'File Upload Options',
        'description' => 'GROUP_FORM_ADMIN_LEVEL_AUTHUPLOAD_DESCRIPTION',
        'multiOptions' => array(
          'registered' => 'Registered Members',
          'member' => 'All Members',
          'officer' => 'Officers and Owner Only',
          //'owner' => 'Owner Only',
        )
      ));
      
      // Element: auth_file_down
      $this->addElement('MultiCheckbox', 'auth_file_down', array(
        'label' => 'File Download Options',
        'description' => 'GROUP_FORM_ADMIN_LEVEL_AUTHDOWNLOAD_DESCRIPTION',
        'multiOptions' => array(
          'registered' => 'Registered Members',
          'member' => 'All Members',
          'officer' => 'Officers and Owner Only',
          //'owner' => 'Owner Only',
        )
      ));
      
      // Element: auth_listing
      $this->addElement('MultiCheckbox', 'auth_listing', array(
        'label' => 'Listing Page Creation Options',
        'description' => 'GROUP_FORM_ADMIN_LEVEL_AUTHLISTING_DESCRIPTION',
        'multiOptions' => array(
          'registered' => 'Registered Members',
          'member' => 'All Members',
          'officer' => 'Officers and Owner Only',
          //'owner' => 'Owner Only',
        )
      ));
      
      // Element: style
      $this->addElement('Radio', 'style', array(
        'label' => 'Allow Club Style',
        'required' => true,
        'multiOptions' => array(
          1 => 'Yes, allow custom club styles.',
          0 => 'No, do not allow custom club styles.'
        ),
        'value' => 1,
      ));
		 */
    }
  }
}