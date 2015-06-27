<div id="club-profile-info-widget">
	<div class="club-photo">
		<?php echo $this->itemPhoto($this->group, 'thumb.profile')?>
	</div>
	<div class="club-title">
		<?php echo $this->group->getTitle()?>
	</div>
	<div class="club-like-count">
		<i class="fa fa-heart"></i>
		<span class="like-count"><?php echo number_format($this->group->like_count)?></span>
	</div>
	<?php if ($this->viewer()->getIdentity()): ?>
    	<div id="club_info_follow" onclick="<?php echo ($this->follow) ? "setFollow(0);" : "setFollow(1);"; ?>"><?php echo ($this->follow) ? $this -> translate("Followed") : $this -> translate("Follow")?></div>
    <?php endif;?>
</div>

<script type="text/javascript">
function setFollow(option_id) {
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
            	$("club_info_follow").set("html", '<?php $this -> translate("Follow") ?>');
            	$("club_info_follow").set("onclick", "setFollow(1)");
            }
            else if (option_id == '1')
            {
            	$("club_info_follow").set("html", '<?php $this -> translate("Followed") ?>');
            	$("club_info_follow").set("onclick", "setFollow(0)");
            }
            
        }
    }).send();
}
</script>