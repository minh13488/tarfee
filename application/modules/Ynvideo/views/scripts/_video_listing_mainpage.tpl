<div class="ynvideo_thumb_wrapper video_thumb_wrapper">
    <?php if ($this->video->parent_type == 'user_playercard') :?>
        <span class="icon-player">
            <img src="application\themes\ynresponsive-event\images\icon-player.png" />
        </span>
    <?php endif; ?>

    <?php
    if ($this->video->photo_id) {
        echo $this->htmlLink($this->video->getPopupHref(), $this->itemPhoto($this->video, 'thumb.large'), array('class'=>'smoothbox'));
    } else {
        echo '<img alt="" src="' . $this->escape($this->layout()->staticBaseUrl) . 'application/modules/Ynvideo/externals/images/video.png">';
    }
    ?>
</div>

<div class="button-action-video">
    <?php if($this -> viewer() -> getIdentity()):?>
    <div id="favorite_<?php echo $this->video -> getIdentity()?>">
    	<?php if($this->video -> hasFavorite()):?>
    		<a href="javascript:;" title="<?php echo $this->translate('unfavorite')?>" onclick="unfavorite_video(<?php echo $this->video -> getIdentity()?>)">
                <i class="fa fa-heart-o"></i>
            </a>
    	<?php else:?>	
    		<a href="javascript:;" data-toggle="tooltip" title="<?php echo $this->translate('favorite')?>" onclick="favorite_video(<?php echo $this->video -> getIdentity()?>)">
                <i class="fa fa-heart"></i>
            </a>
    	<?php endif;?>	
    </div>

    <div id="like_unsure_dislike_<?php echo $this -> video -> getIdentity()?>">
    	<?php if(!Engine_Api::_()->getDbtable('likes', 'core')->isLike($this->video, $this->viewer())):?>
    		<a onclick="video_like('<?php echo $this->video->getIdentity() ?>')" title="<?php echo $this->translate('Like') ?>">
    			<i class="fa fa-thumbs-up"></i>
    		</a>
    	<?php else:?>
    		<a href="javascript:void(0);" onclick="video_unlike('<?php echo $this->video->getIdentity() ?>')" title="<?php echo $this->translate('Like') ?>">
    			<i class="fa fa-thumbs-up"></i> 
    		</a>
    	<?php endif;?>

    	<?php if(Engine_Api::_()->getDbtable('unsures', 'yncomment')->getUnsure($this->video, $this->viewer())):?>
    		<a href="javascript:void(0);" title="<?php echo $this->translate('Unsure') ?>" onclick="video_undounsure('<?php echo $this->video->getIdentity() ?>')">
    			<i class="fa fa-meh-o "></i> 
    		</a>
		<?php else :?>
    		<a href="javascript:void(0);" title="<?php echo $this->translate('Unsure') ?>" onclick="video_unsure('<?php echo $this->video->getIdentity() ?>')">
    			<i class="fa fa-meh-o"></i> 
    		</a>
		<?php endif;?>

    	<?php if(Engine_Api::_()->getDbtable('dislikes', 'yncomment')->getDislike($this->video, $this->viewer())):?>
        	<a href="javascript:void(0);" title="<?php echo $this->translate('Dislike') ?>" onclick="video_undounlike('<?php echo $this->video->getIdentity() ?>')">
        		<i class="fa fa-thumbs-down"></i>
        	</a>
    	<?php else :?>
        	<a href="javascript:void(0);" title="<?php echo $this->translate('Dislike') ?>" onclick="video_unlike('<?php echo $this->video->getIdentity() ?>')">
        		<i class="fa fa-thumbs-down"></i> 
        	</a>
    	<?php endif;?>

    </div>
    <?php endif;?>
</div><!--end button action vide -->


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
    <?php echo $this->htmlLink($this->video->getPopupHref(), $this->video->getTitle(), array('class'=>'smoothbox'))?>
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
</div>