<div class="ynvideo_thumb_wrapper video_thumb_wrapper">
    <?php
    if ($this->video->photo_id) {
        echo $this->htmlLink($this->video->getHref(), $this->itemPhoto($this->video, 'thumb.normal'));
    } else {
        echo '<img alt="" src="' . $this->escape($this->layout()->staticBaseUrl) . 'application/modules/Ynvideo/externals/images/video.png">';
    }
    ?>
</div>
<div class="video-title">
	<?php echo $this->htmlLink($this->video->getHref(), $this->video->getTitle(), array('class'=>'smoothbox'))?>
</div>
<div class="video-statistic-rating">
	<div class="video-statistic">
		<?php echo $this->translate(array('%s view','%s views', $this->video->view_count), $this->video->view_count)?>
		<br>
		<?php $commentCount = $this->video->comments()->getCommentCount(); ?>
		<?php echo $this->translate(array('%s comment','%s comments', $commentCount), $commentCount)?>
	</div>

	<?php 
    	echo $this->partial('_video_rating_big.tpl', 'ynvideo', array('video' => $this->video));
	?>
</div>

<?php if ($this->video->parent_type == 'user_playercard') :?>
<?php $player = $this->video->getParent();?>
<?php if ($player):?>
<?php $sport = $player->getSport();?>
<?php if ($sport):?>	
<div class="player-sport-icon" style="display: none">
	<?php echo $this->itemPhoto($sport, 'thumb.icon')?>
</div>
<?php endif;?>
<div class="player-info">
	<div class="player-photo">
		<?php echo $this->itemPhoto($player, 'thumb.icon')?>
	</div>
	<div class="player_info_detail">
		<div class="player-title">
			<?php echo $player?>
		</div>
		<?php $position = $player->getPosition()?>
		<?php if ($position) : ?>
		<div class="player-position">
			<?php echo $position?>
		</div>
		<?php endif;?>
	</div>
</div>
<?php endif;?>
<?php endif;?>




<?php $user = $this->video->getOwner() ?>
<?php if ($user) : ?>
	<div class="nickname">
    <?php echo $this->htmlLink($user->getHref(),$this->itemPhoto($user, 'thumb.icon'));?>

	    <div class="members_info">
		    <div class="members_name">
		    <?php echo $this->htmlLink($user->getHref(), htmlspecialchars ($this->string()->truncate($user->getTitle(), 25)), array('title' => $user->getTitle())) ?>
		    </div>
	    	<div class="members_date">
				<span title="Wed, 20 May 2015 0:55:31 +0700" class="timestamp">20 tháng năm</span>					    
			</div>
	    </div>

    </div>


<?php endif; ?>