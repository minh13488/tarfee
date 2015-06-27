<div id="club-profile-info-widget">
	<div class="club-photo">
		<?php echo $this->itemPhoto($this->group, 'thumb.profile')?>
	</div>
	<div class="club-title">
		<?php echo $this->group->getTitle()?>
	</div>
	<div class="club-like-count">
		<i class="fa fa-heart"></i>
		<span class="like-count"><?php echo number_format($this->group->likes()->getLikeCount())?></span>
	</div>
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