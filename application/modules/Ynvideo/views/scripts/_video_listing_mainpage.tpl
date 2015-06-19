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
</div>
<div class="video_author">
    <?php $user = $this->video->getOwner() ?>
    <?php if ($user) : ?>
        <?php echo $this->translate('By') ?>
        <?php echo $this->htmlLink($user->getHref(), htmlspecialchars ($this->string()->truncate($user->getTitle(), 25)), array('title' => $user->getTitle())) ?>
    <?php endif; ?>
    <?php 
    	$session = new Zend_Session_Namespace('mobile');
		 if(!$session -> mobile)
		 {
    ?>
    |
    <?php } ?>
    <span class="video_views">
        <?php if (!isset($this->infoCol) || ($this->infoCol == 'view')) : ?>
            <?php echo $this->translate(array('%1$s view', '%1$s views', $this->video->view_count), $this->locale()->toNumber($this->video->view_count)) ?>
        <?php else : ?>
            <?php if ($this->infoCol == 'like') : ?>
                <?php
                    $likeCount = $this->video->likes()->getLikeCount();
                    echo $this->translate(array('%1$s like', '%1$s likes', $likeCount), $this->locale()->toNumber($likeCount));
                ?>
            <?php elseif ($this->infoCol == 'comment') : ?>
                <?php
                    $commentCount = $this->video->comments()->getCommentCount();
                    echo $this->translate(array('%1$s comment', '%1$s comments', $commentCount), $this->locale()->toNumber($commentCount));
                ?>
            <?php elseif ($this->infoCol == 'favorite') : ?>
            <?php
                echo $this->translate(array('%1$s favorite', '%1$s favorites', $this->video->favorite_count), $this->locale()->toNumber($this->video->favorite_count));
            ?>
            <?php endif; ?>
        <?php endif; ?>
    </span>
</div>

    <?php 
        echo $this->partial('_video_rating_big.tpl', 'ynvideo', array('video' => $this->video));
    ?>