<div class="video_thumb_wrapper video_thumb_wrapper">
    <?php if ($this->video->duration): ?>
        <?php echo $this->partial('_video_duration.tpl', 'user', array('video' => $this->video)) ?>
    <?php endif ?>
    <?php
    if ($this->video->photo_id) 
    {
        echo $this->htmlLink($this->video->getHref(), $this->itemPhoto($this->video, 'thumb.normal'));
    } 
    else 
    {
        echo '<img alt="" src="' . $this->escape($this->layout()->staticBaseUrl) . 'application/modules/Video/externals/images/video.png">';
    }
    ?>
</div>
<?php 
    echo $this->htmlLink($this->video->getHref(), 
            $this->string()->truncate($this->video->getTitle(), 30), 
            array('class' => 'video_title', 'title' => $this->video->getTitle())) 
?>

<?php if($this -> viewer() -> isSelf($this -> subject())) :?>

<?php
	echo $this->htmlLink(array(
		'route' => 'default',
		'module' => 'video',
		'controller' => 'index',
		'action' => 'edit',
		'video_id' => $this -> video->video_id,
		'parent_type' =>'user_library',
		'subject_id' =>  $this->library->getIdentity(),
    ), '<i class="fa fa-pencil-square-o"></i>'.$this->translate('Edit Video'), array('class' => 'buttonlink'));
?>

<?php
	echo $this->htmlLink(array(
 	        'route' => 'default', 
         	'module' => 'video', 
         	'controller' => 'index', 
         	'action' => 'delete', 
         	'video_id' => $this -> video->video_id, 
         	'subject_id' =>  $this->library->getIdentity(),
        	'parent_type' => 'user_library',
        	'case' => 'video',
         	'format' => 'smoothbox'), 
         	'<i class="fa fa-trash-o"></i>'.$this->translate('Delete Video'), array('class' => 'buttonlink smoothbox'
     ));
?>

<?php endif;?>

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
    echo $this->partial('_video_rating_big.tpl', 'user', array('video' => $this->video));
?>