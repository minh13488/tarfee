<?php
$this -> headScript() 
        -> appendFile($this->baseUrl() . '/application/modules/User/externals/scripts/jquery.min.js')
        -> appendFile($this->baseUrl() . '/application/modules/User/externals/scripts/jquery-ui-1.10.4.min.js')
        -> appendFile($this->baseUrl() . '/application/modules/User/externals/scripts/jquery.form.min.js');

$coverPhotoUrl = "";
$hasCover = true;
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
            y1 = jQuery('.user-profile-cover-picture').height();
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
                    alert(responseJSON.message);
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
<div class="user-widget-profile-cover">
    <div class="user-profile-cover-picture">
	        <div class="cover-reposition">
	        <span id="edit-cover-btn">
	        <?php echo $this->htmlLink(array('action'=>'cover', 'route'=>'user_extended', 'controller'=>'edit', 'id'=>$this->user->getIdentity()), $this->translate('Upload New Cover'), array('class'=>'smoothbox'))?>
	        </span>
	        <?php if ($hasCover) :?>
		        <span class="edit-position-buttons"><a href="javascript:void(0)" onclick="repositionCover();"><?php echo $this->translate('Reposition Cover Photo')?></a></span>
		        <div class="cover-resize-buttons" style="display: none;">
		            <span><a href="javascript:void(0)" onclick="saveReposition();"><?php echo $this->translate('Save Position')?></a></span>
		            <span><a href="javascript:void(0)" onclick="cancelReposition();"><?php echo $this->translate('Cancel')?></a></span>
		            <input class="cover-position" name="pos" value="<?php echo ($hasCover) ? $this->user->cover_top : 0?>" type="hidden">
		        </div>
		        </div>
		        <img class="reposition-cover profile-cover-picture-span" src="<?php echo $coverPhotoUrl; ?>" style="display: none; <?php if ($hasCover) echo 'top: '.$this->user->cover_top.'px'?>"></img>
	        <?php else: ?>
	        	</div>
	        <?php endif; ?>
        <img class="view-cover profile-cover-picture-span" src="<?php echo $coverPhotoUrl; ?>" style="<?php if ($hasCover) echo 'top: '.$this->user->cover_top.'px'?>"></img>
</div>


<div class="tarfee_profile_cover_wrapper">
   <div class="prelative">
   </div>
   <div class="tarfee_profile_cover_photo_wrapper tarfee_profile_cover_has_tabs" id="siteuser_cover_photo" style="min-height:200px; height:400px;">
      <div class="tarfee_profile_cover_photo cover_photo_wap b_dark">
         <a href="/albums/photo/view/album_id/516/photo_id/5292" onclick="opentarfeeLightBox(&quot;/albums/photo/view/album_id/516/photo_id/5292&quot;);return false;">
         <img src="http://d39w600kmgi0wz.cloudfront.net/public/album_photo/21/e4/e33d_492d.jpg?c=ea00" alt="" align="left" class="cover_photo thumb_cover item_photo_album_photo  thumb_cover" style="top:0px">				</a>					
      </div>
      <!--//empty($this->user->user_cover) && !$this->photo &&--> 
      <div class="clr"></div>
   </div>
   <div class="tarfee_profile_cover_head_section b_medium tarfee_profile_cover_has_tabs tarfee_profile_cover_has_tarfee_button " id="siteuser_main_photo">
      <div class="tarfee_profile_main_photo_wrapper">
         <div class="tarfee_profile_main_photo b_dark">
            <div class="item_photo ">
               <table class="siteuser_main_thumb_photo">
                  <tbody>
                     <tr valign="middle">
                        <td>
                           <a href="/albums/photo/view/album_id/422/photo_id/5293" onclick="opentarfeeLightBox(&quot;/albums/photo/view/album_id/422/photo_id/5293&quot;);
                              return false;">
                           <img src="http://d39w600kmgi0wz.cloudfront.net/public/album_photo/22/e4/e33e_7619.jpg?c=888b" alt="" align="left" id="user_profile_photo" class="thumb_profile item_photo_user  thumb_profile">                  </a>              
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
               <a href="/profile/linda">
                  <h2>Linda Johnson</h2>
               </a>
            </div>
            <div class="mtop5">
               <div></div>
            </div>
         </div>
         <div class="tarfee_profile_cover_tarfee_button">
            <div>
               <div class="generic_layout_container layout_tarfee_social_button">
                  <ul>
                     <li>
                     	<a><span class="profile_follow_button">follow</span></a>
                     </li>
                     <li>
                     	<a><span class="profile_inbox_button">inbox</span></a>
                     </li>
                     <li>
                     	<a><span class="profile_share_button">share</span></a>
                     </li>
                  </ul>
               </div>
            </div>
         </div>
      </div>
      <div class="clr"></div>
     <div class='tabs_alt tabs_parent'>
	  <ul id='main_tabs'>
		<li>
	   <a href="#">
	      <div><span class="number_tabs">120</span></div>
	      <div>following</div>
	   </a>
		</li>
		</li>
		<li>
		   <a href="#">
		      <div><span class="number_tabs">1000</span></div>
		      <div>followers</div>
		   </a>
		</li>
		<li>
		   <a href="#">
		      <div><span class="number_tabs">90</span></div>
		      <div>eye on</div>
		   </a>
		</li>
		<li>
		   <a href="#">
		      <div><span class="number_icons"><i class="fa fa-futbol-o"></i></span></div>
		      <div>football</div>
		   </a>
		</li>
		<li>
		   <a href="#">
		      <div><span class="number_icons"><i class="fa fa-futbol-o"></i></span></div>
		      <div>basketball</div>
		   </a>
		</li>
		<li>
		   <a href="#">
		      <div><span class="number_icons"><i class="fa fa-users"></i></span></div>
		      <div>club name 1</div>
		   </a>
		</li>
		<li>
		   <a href="#">
		      <div><span class="number_icons"><i class="fa fa-users"></i></span></div>
		      <div>club name 1</div>
		   </a>
		</li>
	  </ul>
	</div>
	<div class="tabs_alt tab_identify_account">
		<div class="user_icon"><i class="fa fa-user"></i></div>
		<div class="user_type_verify">Professtional individual verified by Tarfee</div>
	</div>
   </div>
</div>