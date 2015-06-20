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
    <?php if ($this->video->parent_type == 'user_playercard') :?>
        <span class="icon-player">
            <img src="application\themes\ynresponsive-event\images\icon-player.png" />
        </span>
    <?php endif; ?>

    <?php
    if ($this->video->photo_id) {
        echo $this->htmlLink($this->video->getHref(), $this->itemPhoto($this->video, 'thumb.large'));
    } else {
        echo '<img alt="" src="' . $this->escape($this->layout()->staticBaseUrl) . 'application/modules/Ynvideo/externals/images/video.png">';
    }
    ?>
</div>

<?php if ($this->video->parent_type == 'user_playercard') :?>
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
<?php endif;?>



<div class="video-title">
    <?php echo $this->htmlLink($this->video->getHref(), $this->video->getTitle(), array('class'=>'smoothbox'))?>
</div>

<div class="video-statistic-rating">

    <div class="video-statistic">
        <span><?php echo $this->translate(array('%s view','%s views', $this->video->view_count), $this->video->view_count)?></span>
        <?php $commentCount = $this->video->comments()->getCommentCount(); ?>
        <span><?php echo $this->translate(array('%s comment','%s comments', $commentCount), $commentCount)?></span>
    </div>

    <?php 
        echo $this->partial('_video_rating_big.tpl', 'ynvideo', array('video' => $this->video));
    ?>
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
    
    <?php } ?>
    <span class="video_views" style="display: none">
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
