<li style="height:auto" class="user-library-video-content">
      <div class="video_thumb_wrapper">
        <?php if ($this -> video->duration):?>
        <span class="video_length">
          <?php
            if( $this -> video->duration>360 ) $duration = gmdate("H:i:s", $this -> video->duration); else $duration = gmdate("i:s", $this -> video->duration);
            if ($duration[0] =='0') $duration = substr($duration,1); echo $duration;
          ?>
        </span>
        <?php endif;?>
        <div class="avatar">
	        <?php
	          if( $this -> video->photo_id ) {
	            echo $this->htmlLink($this -> video->getHref(), $this->itemPhoto($this -> video, 'thumb.normal'));
	          } else {
	            echo '<img alt="" src="' . $this->layout()->staticBaseUrl . 'application/modules/Video/externals/images/video.png">';
	          }
	        ?>
        </div>
      </div>
      <br/>
      <?php 
      	$isMobile = false;
        if(Engine_Api::_() -> hasModuleBootstrap('ynresponsive1')) {
      		$isMobile = Engine_Api::_()->getApi('mobile','ynresponsive1')->isMobile();
      	} 
      ?>
      <div style="text-align: center;"><a class="<?php if(!$isMobile) echo 'smoothbox' ?> video_title" href="<?php echo $this -> video->getHref(array('smoothbox'=>'1'));?>">
      	<?php $title =  $this -> video->getTitle()."..."; 
      		if(strlen($title) > 16) {
      			echo substr($title, 0, 16);
      		} else {
      			echo $title;
      		}
      	?>
      	
      </a> </div>
      <div style="text-align: center;"><?php echo $this->translate('By');?> <?php echo $this->htmlLink($this -> video->getOwner()->getHref(), $this -> video->getOwner()->getTitle()) ?></div>
     
      <div style="text-align: center;" class="video_stats">
        <span class="video_views"><?php echo $this -> video->view_count;?> <?php echo $this->translate('views');?></span>
      </div>
      
       <div style="text-align: center;" class="video_stats">
       		<?php if($this -> video->getRating() > 0):?>
            	<?php for($x=1; $x<=$this -> video->getRating(); $x++): ?><span class="rating_star_generic rating_star"></span><?php endfor; ?><?php if((round($this -> video->rating)-$this -> video->getRating())>0):?><span class="rating_star_generic rating_star_half"></span><?php endif; ?>
     		<?php else :?>
 				<?php for($x=1; $x<=5; $x++): ?><span class="rating_star_generic rating_star_disabled"></span><?php endfor; ?>
     		<?php endif;?>
		</div>
      
     
		<?php if($this -> viewer() -> isSelf($this -> subject())) :?>
		 <div style="text-align: center;" class="user-library-video-actions user-library-item-action">
	    	<span><i class="fa fa-ellipsis-h"></i> <span> <?php echo $this -> translate('Options');?></span></span>
	   		<ul>
	   			<li class="user-library-close-box">X</li>
	   			<li>
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
			    </li>
			    <li>
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
				</li>
				<li>
						<?php echo $this->htmlLink(array(
								'route' => 'user_library',
								'action' => 'give-ownership',
								'id' =>  $this -> video -> video_id,
								'libid' =>  $this->library->getIdentity(),
							), '<i class="fa fa-plus-square"></i>'.$this->translate('Give OwnerShip'), array(
							'class' => 'smoothbox buttonlink'
							)) ;
						?>
				</li>
				<?php $subLibraries = $this -> viewer() -> getMainLibrary() -> getSubLibrary();?>
				<?php if(count($subLibraries) > 1) :?>
				<li>
						<?php echo $this->htmlLink(array(
								'route' => 'user_library',
								'action' => 'move-to-sub',
								'id' =>  $this -> video -> video_id,
								'libid' =>  $this->library->getIdentity(),
							), '<i class="fa fa-plus-square"></i>'.$this->translate('Move to Sub Library '), array(
							'class' => 'smoothbox buttonlink'
							)) ;
						?>
				</li>
				<?php endif;?>
				
				<?php if(isset($this -> main) && $this -> main) :?>
					<?php $playerTable = Engine_Api::_() -> getItemTable('user_playercard'); ?>
					<?php if($playerTable -> getTotal($this -> viewer() -> getIdentity())) :?>
					<li>
						<?php echo $this->htmlLink(array(
								'route' => 'user_library',
								'action' => 'move-to-player',
								'id' =>  $this -> video -> video_id,
								'libid' =>  $this->library->getIdentity(),
							), '<i class="fa fa-plus-square"></i>'.$this->translate('Move to Player '), array(
							'class' => 'smoothbox buttonlink'
							)) ;
						?>
					</li>
					<?php endif;?>
				<?php endif;?>
			</ul>
		</div>
		<?php endif;?>
</li>