<?php
/**
 * YouNet Company
 *
 * @category   Application_Extensions
 * @package    Ynvideo
 * @author     YouNet Company
 */
?>
<div class="ynvideo_thumb_wrapper video_thumb_wrapper">
    <?php
    if ($this->video->photo_id) {
        echo $this->htmlLink($this->video->getHref(), $this->itemPhoto($this->video, 'thumb.normal'));
    } else {
        echo '<img alt="" src="' . $this->escape($this->layout()->staticBaseUrl) . 'application/modules/Ynvideo/externals/images/video.png">';
    }
    ?>
</div>
<?php if ($this->video->parent_type == 'user_playercard') :?>
<?php $player = $this->video->getParent();?>
<?php if ($player):?>
<?php $sport = $player->getSport();?>
<?php if ($sport):?>	
<div class="player-sport-icon">
	<?php echo $this->itemPhoto($sport, 'thumb.icon')?>
</div>
<?php endif;?>
<div class="player-info">
	<div class="player-photo">
		<?php echo $this->itemPhoto($player, 'thumb.icon')?>
	</div>
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
<?php endif;?>
<?php endif;?>

<div class="video-title">
	<?php echo $this->htmlLink($this->video->getHref(), $this->video->getTitle(), array('class'=>'smoothbox'))?>
</div>S

<div class="video-statistic-rating">
	<div class="video-statistic">
		<p><?php echo $this->translate(array('%s view','%s views', $this->video->view_count), $this->video->view_count)?></p>
		<?php $commentCount = $this->video->comments()->getCommentCount(); ?>
		<p><?php echo $this->translate(array('%s comment','%s comments', $commentCount), $commentCount)?></p>
	</div>
	<div class="video-rating">
		<?php 
        	echo $this->partial('_video_rating_big.tpl', 'ynvideo', array('video' => $this->video));
    	?>
	</div>
</div>

<?php if ($player):?>
<div class="video-player-rating">
	<?php 
		$tableRatingType = Engine_Api::_() -> getItemTable('ynvideo_ratingtype');
		$rating_types = $tableRatingType -> getAllRatingTypes();
    	echo $this->partial('_view_rate_video.tpl', 'ynvideo', array(
	        'ratingTypes' => $rating_types,
	        'video_id' => $this->video->getIdentity(),
        )); 
	        
	?>
</div>
<?php endif;?>
<div class="video_author">
    <?php $user = $this->video->getOwner() ?>
    <?php $user = ($user) ? $user : $this->translate('Unknown')?>
    <?php echo $this->translate('post by %s', $user);?>
</div>