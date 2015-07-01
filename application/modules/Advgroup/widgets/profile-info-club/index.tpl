<div id="club-profile-info-widget">
	<?php $photoUrl = ($this ->group -> getPhotoUrl('thumb.main')) ? $this ->group->getPhotoUrl('thumb.main') : "application/modules/Advgroup/externals/images/nophoto_group_thumb_profile.png" ?>

	<div class="club-photo" style="background-image: url(<?php echo $photoUrl; ?>)">

	</div>
	<div class="club-info-general">
		<div class="club-title">
			<?php echo $this->group->getTitle()?>
		</div>
		<?php if ($this->group->getCountry()) :?>
		<div class="club-country">
			<?php echo $this->group->getCountry()->getTitle()?>
		</div>
		<?php endif;?>
		
		<?php if ($this->group->getProvince()) :?>
		<div class="club-province">
			<?php echo $this->group->getProvince()->getTitle()?>
		</div>
		<?php endif;?>
		
		<?php if ($this->group->getCity()) :?>
		<div class="club-city">
			<?php echo $this->group->getCity()->getTitle()?>
		</div>
		<?php endif;?>
		
		<div class="club-like-count">
			<i class="fa fa-heart"></i>
			<span class="like-count"><?php echo number_format($this->group->likes()->getLikeCount())?></span>
		</div>
	</div>
	<?php if($this->aJoinButton && is_array($this->aJoinButton)):?>
        <?php if (count($this->aJoinButton) == '2'):?>
			<div id="advgroup_widget_cover_invitation_proceed">               				
				<a title="<?php echo $this->aJoinButton[0]['label']; ?>" class='smoothbox <?php echo $this->aJoinButton[0]['class'];?>' href="<?php echo $this->url($this->aJoinButton[0]['params'], $this->aJoinButton[0]['route'], array());?>">
					<i class="ynicon-joining"></i>
				</a>
			</div>
			<div id="advgroup_widget_cover_invitation_proceed">               				
				<a title="<?php echo $this->aJoinButton[1]['label']; ?>" class='smoothbox <?php echo $this->aJoinButton[1]['class'];?>' href="<?php echo $this->url($this->aJoinButton[1]['params'], $this->aJoinButton[1]['route'], array());?>">
					<i class="ynicon-cancel"></i>
				</a>
			</div>
		<?php else:?>
			<?php if (isset($this->aJoinButton['params']['action'])) 
			{
				$action = $this->aJoinButton['params']['action'];
			}
			?>
			<div class="tf_btn_action">
            	<a href="<?php echo $this->url($this->aJoinButton['params'], $this->aJoinButton['route'], array());?>" class="<?php echo $this->aJoinButton['class'];?>" title="<?php echo $this->aJoinButton['label']; ?>">
            		<?php echo $this -> translate($action);?>
            	</a>
			</div>
		<?php endif;?>                
    <?php endif;?>
	<?php if ($this->viewer()->getIdentity()): ?>
    	<a id="club_info_follow" href="javascript:void(0)" onclick="<?php echo ($this->follow) ? "setFollowClub(0);" : "setFollowClub(1);"; ?>"><?php echo ($this->follow) ? $this -> translate("Followed") : $this -> translate("Follow")?></a>
    <?php endif;?>
</div>

<script type="text/javascript">
function setFollowClub(option_id) {
	new Request.JSON({
        url: '<?php echo $this->url(array('action' => 'follow'), 'group_general', true); ?>',
        method: 'post',
        data : {
        	format: 'json',
            'group_id': <?php echo $this->subject()->group_id ?>,
            'option_id' : option_id
        },
        onComplete: function(responseJSON, responseText) {
            if (option_id == '0')
            {
            	$("club_info_follow").set("text", '<?php echo $this -> translate("Follow") ?>');
            	$("club_info_follow").set("onclick", "setFollowClub(1)");
            }
            else if (option_id == '1')
            {
            	$("club_info_follow").set("text", '<?php echo $this -> translate("Followed") ?>');
            	$("club_info_follow").set("onclick", "setFollowClub(0)");
            }
            
        }
    }).send();
}
</script>