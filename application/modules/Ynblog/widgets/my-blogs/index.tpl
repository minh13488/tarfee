<ul class="generic_list_widget" style="overflow: hidden;">
  <?php foreach( $this->blogs as $item ):?>
  	  	<?php if ($item->checkPermission($item->getIdentity())) :?>
    <li class="ynblog_new">
          <div class="photo">
            <?php echo $this->htmlLink($item->getHref(), $this->itemPhoto($item, 'thumb.icon'), array('class' => 'thumb')) ?>
          </div>
          <div class="info">
              <div class="title">
                    <?php echo $this->htmlLink($item->getHref(), $item->getTitle()) ?>
              </div>
              <div class="stats">
                    <?php
                      $owner = $item->getOwner();
                      echo $this->translate('Posted by %1$s', $this->htmlLink($owner->getHref(), $owner->getTitle()));
                    ?>
                    -
                    <?php echo $this->timestamp($item->creation_date); ?>
              </div>
              <div class="description">
                    <?php echo $this -> viewMore($item -> body); ?>
              </div>
          </div>
          <div class='ynblogs_browse_options'>
            <?php
            echo $this->htmlLink(array(
              'route' => 'blog_specific',
              'action' => 'edit',
              'blog_id' => $item->getIdentity(),
              'reset' => true,
              'browse' => true,
            ), $this->translate('Edit'), array(
              'class' => 'buttonlink icon_ynblog_edit',
            ));?>
            |
            <?php
            echo $this->htmlLink(array(
                'route' => 'blog_specific',
                'action' => 'delete',
                'blog_id' => $item->getIdentity(),
                'format' => 'smoothbox'
                ), $this->translate('Delete'), array(
              'class' => 'buttonlink smoothbox icon_ynblog_delete'
            ));?>
          </div>
          <div class="ynblog_statistics">
          	<span><?php echo $this->translate(array('%s view','%s views', $item -> view_count), $item -> view_count)?></span>
          	<span><?php echo $this->translate(array('%s comment','%s comments', $item -> comment_count), $item -> comment_count)?></span>
        	<?php $likeCount = $item ->likes()->getLikeCount(); ?>
        	<span><?php echo $this->translate(array('%s like','%s likes', $likeCount), $likeCount)?></span>
        	<?php $disLikeCount = Engine_Api::_()->getDbtable('dislikes', 'yncomment') -> getDislikeCount($item); ?>
        	<span><?php echo $this->translate(array('%s dislike','%s dislikes', $disLikeCount), $disLikeCount)?></span>
          </div>
    </li>
        <?php endif; ?>
   <?php endforeach; ?>
   <?php if(count($this->blogs) == $this->limit): ?>
       <li>
          <div class="more" style="float:right;margin-left:15px;margin-bottom: 10px;">
              <a href="<?php echo $this->url(array(),'default'); ?>talks/manage" >
                <?php echo $this->translate('View all');?>
              </a>
          </div>
        </li>
  <?php endif; ?>
</ul>