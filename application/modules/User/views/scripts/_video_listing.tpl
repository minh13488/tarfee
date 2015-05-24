<li>
      <div class="video_thumb_wrapper">
        <?php if ($this -> video->duration):?>
        <span class="video_length">
          <?php
            if( $this -> video->duration>360 ) $duration = gmdate("H:i:s", $this -> video->duration); else $duration = gmdate("i:s", $this -> video->duration);
            if ($duration[0] =='0') $duration = substr($duration,1); echo $duration;
          ?>
        </span>
        <?php endif;?>
        <?php
          if( $this -> video->photo_id ) {
            echo $this->htmlLink($this -> video->getHref(), $this->itemPhoto($this -> video, 'thumb.normal'));
          } else {
            echo '<img alt="" src="' . $this->layout()->staticBaseUrl . 'application/modules/Video/externals/images/video.png">';
          }
        ?>
      </div>
      <a class="video_title" href='<?php echo $this -> video->getHref();?>'><?php echo $this -> video->getTitle();?></a>
      <div class="video_author"><?php echo $this->translate('By');?> <?php echo $this->htmlLink($this -> video->getOwner()->getHref(), $this -> video->getOwner()->getTitle()) ?></div>
      <div class="video_stats">
        <span class="video_views"><?php echo $this -> video->view_count;?> <?php echo $this->translate('views');?></span>
        <?php if($this -> video->rating>0):?>
          <?php for($x=1; $x<=$this -> video->rating; $x++): ?><span class="rating_star_generic rating_star"></span><?php endfor; ?><?php if((round($this -> video->rating)-$this -> video->rating)>0):?><span class="rating_star_generic rating_star_half"></span><?php endif; ?>
        <?php endif; ?>
      </div>
      
      
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
		    ), '<i class="fa fa-pencil-square-o"></i>'.$this->translate('Edit '), array('class' => 'buttonlink'));
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

      
</li>