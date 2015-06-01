<?php
$this -> headScript() 
        -> appendFile($this->baseUrl() . '/application/modules/User/externals/scripts/jquery.min.js')
        -> appendFile($this->baseUrl() . '/application/modules/User/externals/scripts/jquery-ui-1.10.4.min.js')
        -> appendFile($this->baseUrl() . '/application/modules/User/externals/scripts/jquery.form.min.js');

$coverPhotoUrl = "";
$hasCover = false;
if ($this->user->cover_photo) {
	$coverFile = Engine_Api::_()->getDbtable('files', 'storage')->find($this->user->cover_photo)->current();
	$coverPhotoUrl = $coverFile->map();
    if (!$coverPhotoUrl) {
        $coverPhotoUrl = 'application/modules/User/externals/images/user_default_cover.jpg';
    }
    else {
        $hasCover = true;
    }
    
}
else {
    $coverPhotoUrl = 'application/modules/User/externals/images/user_default_cover.jpg';
}
?>

<script type="text/javascript">
var cover_top = <?php echo ($hasCover) ? $this->user->cover_top : 0?>;
function repositionCover() {
    jQuery('.reposition-cover').show();
    jQuery('.cover-resize-buttons').show();
    jQuery('.edit-position-buttons').hide();
    jQuery('.view-cover').hide();
    jQuery('.reposition-cover')
    .css('cursor', 's-resize')
    .draggable({
        scroll: false,
        axis: "y",
        cursor: "s-resize",
        drag: function (event, ui) {
            y1 = jQuery('.tarfee_profile_cover_photo').height();
            y2 = jQuery('.reposition-cover').height();
            
            if (ui.position.top >= 0) {
                ui.position.top = 0;
            }
            else
            if (ui.position.top <= (y1-y2)) {
                ui.position.top = y1-y2;
            }
        },
        
        stop: function(event, ui) {
            jQuery('input.cover-position').val(ui.position.top);
        }
    });
}

function saveReposition() {
    if (jQuery('input.cover-position').length == 1) {
        posY = jQuery('input.cover-position').val();
        new Request.JSON({
            'url': '<?php echo $this->url(array('action'=>'reposition', 'controller'=>'edit'),'user_extended', true)?>',
            'method': 'post',
            'data' : {
                'position' : posY
            },
            'onSuccess': function(responseJSON, responseText) {
                if (responseJSON.status == true) {
                    cover_top = posY;
                    jQuery('.profile-cover-picture-span').css('top', posY+'px');
                    jQuery('.reposition-cover').hide();
                    jQuery('.cover-resize-buttons').hide();
                    jQuery('.edit-position-buttons').show();
                    jQuery('.view-cover').show();
                }
                else {
                }            
            }
        }).send();
    }
}

function cancelReposition() {
    jQuery('.reposition-cover').hide();
    jQuery('.reposition-cover').css('top', cover_top+'px');
    jQuery('.cover-resize-buttons').hide();
    jQuery('.edit-position-buttons').show();
    jQuery('.view-cover').show();
    jQuery('input.cover-position').val(cover_top);
}
</script>
<div class="tarfee_profile_cover_wrapper">
   <div class="tarfee_profile_cover_photo_wrapper tarfee_profile_cover_has_tabs" id="siteuser_cover_photo">
      <div class="tarfee_profile_cover_photo cover_photo_wap b_dark">
      	  <div class="cover-reposition">
      	  	<?php if($this->user -> isSelf($this -> viewer())):?>
		        <span id="edit-cover-btn">
		        <?php echo $this->htmlLink(array('action'=>'cover', 'route'=>'user_extended', 'controller'=>'edit', 'id'=>$this->user->getIdentity()), $this->translate('Update Cover Photo'), array('class'=>'smoothbox'))?>
		        </span>
		    <?php endif; ?>
	        <?php if ($hasCover) :?>
		        <span class="edit-position-buttons"><a href="javascript:void(0)" onclick="repositionCover();"><?php echo $this->translate('Reposition Cover Photo')?></a></span>
		        <div class="cover-resize-buttons" style="display: none;">
		            <span><a href="javascript:void(0)" onclick="saveReposition();"><?php echo $this->translate('Save Position')?></a></span>
		            <span><a href="javascript:void(0)" onclick="cancelReposition();"><?php echo $this->translate('Cancel')?></a></span>
		            <input class="cover-position" name="pos" value="<?php echo ($hasCover) ? $this->user->cover_top : 0?>" type="hidden">
		        </div>
		        </div>
		        <img class="reposition-cover profile-cover-picture-span cover_photo thumb_cover item_photo_album_photo thumb_cover" src="<?php echo $coverPhotoUrl; ?>" style="display: none; <?php if ($hasCover) echo 'top: '.$this->user->cover_top.'px'?>"></img>
	        <?php else: ?>
	        	</div>
	        <?php endif; ?>
        <img class="cover_photo thumb_cover profile-cover-picture-span item_photo_album_photo thumb_cover" src="<?php echo $coverPhotoUrl; ?>" style="<?php if ($hasCover) echo 'top: '.$this->user->cover_top.'px'?>"></img>
      </div>
      <div class="clr"></div>
   </div>
   <div class="tarfee_profile_cover_head_section b_medium tarfee_profile_cover_has_tabs tarfee_profile_cover_has_tarfee_button " id="siteuser_main_photo">
      <div class="tarfee_profile_main_photo_wrapper">
         <div class="tarfee_profile_main_photo b_dark">
         	<?php if($this->user -> isSelf($this -> viewer())):?>
		        <span id="edit-photo-btn">
		        	<?php echo $this->htmlLink(array('action'=>'photo-popup', 'route'=>'user_extended', 'controller'=>'edit', 'id'=>$this->user->getIdentity()), $this->translate('Update Profile Photo'), array('class'=>'smoothbox'))?>
		        </span>
		    <?php endif; ?>
            <div class="item_photo ">
               <table class="siteuser_main_thumb_photo">
                  <tbody>
                     <tr valign="middle">
                        <td>
                        	<?php $profileUrl = $this -> user -> getPhotoUrl('thumb.profile');
                        	if(!$profileUrl)
                        	{
                        		$profileUrl = 'application/modules/User/externals/images/nophoto_user_thumb_profile.png';
                        	}?>
                           <img src="<?php echo $profileUrl?>" alt="" align="left" id="user_profile_photo" class="thumb_profile item_photo_user thumb_profile">           
                        </td>
                     </tr>
                  </tbody>
               </table>
            </div>
         </div>
      </div>
      <div class="tarfee_profile_cover_head_section_inner" id="tarfee_profile_cover_head_section_inner">
         <div class="tarfee_profile_coverinfo_buttons">
         </div>
         <div class="tarfee_profile_coverinfo_status">
            <div class="fleft">
               <a href="<?php echo $this -> user -> getHref();?>">
                  <h2><?php echo $this -> user -> getTitle()?></h2>
               </a>
               <?php
                $about_me = "";
                $fieldStructure = Engine_Api::_()->fields()->getFieldsStructurePartial($this -> user);
                foreach( $fieldStructure as $map ) {
             		$field = $map->getChild();
             		$value = $field->getValue($this -> user);
                 	if($field->type == 'about_me') {
                      	$about_me = $value['value'];
                 	}
                }
         		?>
         		<?php if ($about_me != "") :?>
         			<h4><?php echo $about_me?></h4>
         		<?php endif;?>
            </div>
            <div class="mtop5">
               <div></div>
            </div>
         </div>
         <div class="tarfee_profile_cover_tarfee_button">
            <div>
               <div class="generic_layout_container layout_tarfee_social_button">
                  <ul>
                  	<?php $viewer = Engine_Api::_()->user()->getViewer();
					    $subject = Engine_Api::_()->core()->getSubject();
						if(!$viewer -> isSelf($subject)):
					 ?>
                     <li>
                 		<?php 
						$subjectRow = $subject->membership()->getRow($viewer);
						if( null === $subjectRow ) 
						{
					        // Follow
					        echo $this->htmlLink(array(
						        'route' => 'user_extended',
						        'controller' => 'friends',
						        'action' => 'add',
						        'user_id' => $subject->getIdentity(),
						        'rev' => true
						    ), '<span class="profile_follow_button">'.$this -> translate("Follow").'</span>', array(
						        'class' => 'smoothbox profile_follow'
						    ));
					    }
						else if( $subjectRow->resource_approved == 0 ) {
							// Cancel Follow
					        echo $this->htmlLink(array(
						        'route' => 'user_extended',
						        'controller' => 'friends',
						        'action' => 'cancel',
						        'user_id' => $subject->getIdentity(),
						        'rev' => true
						    ), '<span class="profile_follow_button">'.$this -> translate("Unfollow").'</span>', array(
						        'class' => 'smoothbox profile_unfollow'
						    ));
						}
						else
						{
							// Unfollow
					        echo $this->htmlLink(array(
						        'route' => 'user_extended',
						        'controller' => 'friends',
						        'action' => 'remove',
						        'user_id' => $subject->getIdentity(),
						        'rev' => true
						    ), '<span class="profile_follow_button">'.$this -> translate("Unfollow").'</span>', array(
						        'class' => 'smoothbox profile_unfollow'
						    ));
						} 
						?>
                     </li>
                     <li>
                     	<?php echo $this->htmlLink(array(
				            'route' => 'messages_general',
				            'action' => 'compose',
				            'to' => $this -> subject() ->getIdentity()
				        ), '<span class="profile_inbox_button">'.$this -> translate('inbox').'</span>', array(
				            'class' => 'smoothbox'
				        ));
			    		?>
                     </li>
                     <?php endif;?>
                     <li>
                     	<?php echo $this->htmlLink(array(
				            'route' => 'default',
				            'module' => 'activity',
				            'controller' => 'index',
							'action' => 'share',
							'type' => 'user',
							'id' => $this->subject() -> getIdentity(),
				        ), '<span class="profile_share_button">'.$this -> translate('share').'</span>', array(
				            'class' => 'smoothbox'
				        ));
			    		?>
                     </li>
                     <li>
                     	<?php if(Engine_Api::_()->authorization()->isAllowed('user', $this->subject(), 'show_badge')):?>
							<?php 
							$badge = Engine_Api::_()->authorization()->getPermission($this->subject(), 'user', 'badge');
							if($badge && strpos($badge,'public/admin') !== false): ?>
								<img height="30" src="<?php echo $badge?>" />
							<?php endif;?>
						<?php endif;?>
                     </li>
                  </ul>
               </div>
            </div>
         </div>
      </div>
      <div class="clr"></div>
     <div class='status_alt status_parent'>
	  <ul id='main_tabs'>
	  	 <?php $direction = Engine_Api::_()->getApi('settings', 'core')->getSetting('user.friends.direction');
    	if ( $direction == 0 ): ?>
			<li>
			   <?php if($this->followingCount):?>
			      	<a href="<?php echo $this -> url(array('controller' => 'friends', 'action' => 'list-all-following', 'user_id' => $this->user -> getIdentity()), 'user_extended')?>" class="smoothbox">
				      	<div><span class="number_tabs"><?php echo $this->locale()->toNumber($this->followingCount);?></span></div>
				      	<div><?php echo $this -> translate('following')?></div>
			        </a>
		        <?php else:?>
		        	<a href="javascript:void(0)">
		        		<div><span class="number_tabs">0</span></div>
		        	 	<div><?php echo $this -> translate('following')?></div>
		        	 </a>
		        <?php endif;?>
			</li>
			<li>
				<?php if($this->user->member_count):?>
			      	<a href="<?php echo $this -> url(array('controller' => 'friends', 'action' => 'list-all-followers', 'user_id' => $this->user -> getIdentity()), 'user_extended')?>" class="smoothbox">
				      	<div><span class="number_tabs"><?php echo $this->locale()->toNumber($this->user->member_count);?></span></div>
				      	<div><?php echo $this->translate(array('follower', 'followers', $this->user->member_count),
				        	$this->locale()->toNumber($this->user->member_count)) ?></div>
			        </a>
		        <?php else:?>
		        	<a href="javascript:void(0)">
		        		<div><span class="number_tabs">0</span></div>
		        	 	<div><?php echo $this -> translate('followers')?></div>
		        	 </a>
		        <?php endif;?>
			</li>
		<?php else:?>
			<li>
				<?php if($this->user->member_count):?>
			      	<a href="<?php echo $this -> url(array('controller' => 'friends', 'action' => 'list-all-friends', 'user_id' => $this->user -> getIdentity()), 'user_extended')?>" class="smoothbox">
				      	<div><span class="number_tabs"><?php echo $this->locale()->toNumber($this->user->member_count);?></span></div>
				      	<div><?php echo $this->translate(array('friend', 'friends', $this->user->member_count),
				        	$this->locale()->toNumber($this->user->member_count)) ?></div>
			        </a>
		        <?php else:?>
		        	<a href="javascript:void(0)">
		        		<div><span class="number_tabs">0</span></div>
		        	 	<div><?php echo $this -> translate('friends')?></div>
		        	 </a>
		        <?php endif;?>
			</li>
		<?php endif;?>
		<li>
		   <a href="#">
		      <div><span class="number_tabs"><?php echo count($this->user->getEyeOns())?></span></div>
		      <div>eye on</div>
		   </a>
		</li>
		<?php foreach($this -> sports as $sport):?>
		<li>
			<a>
	      <div>
	      	<span class="number_icons">
	      		<?php echo $this -> itemPhoto($sport, 'thumb.icon');?>
			</span>
		  </div>
	      <div><?php echo $this -> string() -> truncate($sport -> getTitle(), 10)?></div>
	      </a>
		</li>
		<?php endforeach;?>
		
		<?php foreach($this -> clubs as $club):?>
		<li>
		   <a href="<?php echo $club -> getHref();?>">
		      <div>
		      	<span class="number_icons">
		      		<?php echo $this -> itemPhoto($club, 'thumb.icon');?>
				</span>
			  </div>
		      <div><?php echo $this -> string() -> truncate($club -> getTitle(), 10)?></div>
		   </a>
		</li>
		<?php endforeach;?>
	  </ul>
	</div>
		<?php if($this->src_img):?>
		<div class="status_alt tab_identify_account">
			<div class="user_icon"><img src='<?php echo $this->src_img;?>'></div>
			<div class="user_type_verify"><?php echo $this -> translate("professtional individual verified by Tarfee");?></div>
		</div>
		<?php endif;?>
	</div>
</div>