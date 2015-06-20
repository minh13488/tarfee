<?php
?>
<div class="ynvideo_thumb_wrapper video_thumb_wrapper">
    <?php
    if ($this->video->photo_id) {
        echo $this->htmlLink($this->video->getHref(), $this->itemPhoto($this->video, 'thumb.large'));
    } else {
        echo '<img alt="" src="' . $this->escape($this->layout()->staticBaseUrl) . 'application/modules/Ynvideo/externals/images/video.png">';
    }
    ?>
</div>

<div class="player-info-author">
	<?php $player = $this->video->getParent();?>
	<?php if ($player):?>


	<div class="player-info">
	    <div class="player-photo">
	        <?php echo $this->itemPhoto($player, 'thumb.icon')?>
	    </div>
	    <div class="player_info_detail">
	        <div class="player-title">
	            <?php echo $player?>
	        </div>
	        <div class="player-position">
	        <?php $position = $player->getPosition()?>
	        <?php if ($position) : ?>
	            <?php //echo $position?>

	        <?php echo substr($position,0, 2)?>

	        <?php endif;?>

	        <?php $sport = $player->getSport();?>
	            <?php if ($sport):?>    
	                <?php //echo ' - '.$sport->title ?>
	            <?php endif;?>
	        </div>
	    </div>
	</div>

	<?php endif;?>

	<div class="video_author">
	    <?php $user = $this->video->getOwner() ?>
	    <?php $user = ($user) ? $user : $this->translate('Unknown')?>

        <?php echo $this->itemPhoto($user, 'thumb.icon')?>
	    <?php echo $this->translate('%s', $user);?>
	    <?php echo $this->timestamp($user -> getOwner() -> creation_date);?>
	</div>
</div>


<div class="video-title">
	<?php echo $this->htmlLink($this->video->getHref(), $this->video->getTitle(), array('class'=>'smoothbox'))?>
</div>

<div class="video-statistic-rating">
	<div class="video-statistic">
		<span><?php echo $this->translate(array('%s view','%s views', $this->video->view_count), $this->video->view_count)?></span>
		<?php $commentCount = $this->video->comments()->getCommentCount(); ?>
		<span><?php echo $this->translate(array('%s comment','%s comments', $commentCount), $commentCount)?></span>
	</div>
	<div class="video-rating">
		<?php 
        	echo $this->partial('_video_rating_big.tpl', 'ynvideo', array('video' => $this->video));
    	?>
	</div>
</div>