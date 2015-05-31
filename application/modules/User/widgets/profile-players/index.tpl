<script type="text/javascript">
    en4.core.runonce.add(function(){
        var anchor = $('players').getParent();
        $('players_previous').style.display = '<?php echo ( $this->paginator->getCurrentPageNumber() == 1 ? 'none' : '' ) ?>';
        $('players_next').style.display = '<?php echo ( $this->paginator->count() == $this->paginator->getCurrentPageNumber() ? 'none' : '' ) ?>';

        $('players_previous').removeEvents('click').addEvent('click', function(){
            en4.core.request.send(new Request.HTML({
                url : en4.core.baseUrl + 'widget/index/content_id/' + <?php echo sprintf('%d', $this->identity) ?>,
                data : {
                    format : 'html',
                    subject : en4.core.subject.guid,
                    page : <?php echo sprintf('%d', $this->paginator->getCurrentPageNumber() - 1) ?>
                }
            }), {
                'element' : anchor
            })
        });

        $('players_next').removeEvents('click').addEvent('click', function(){
            en4.core.request.send(new Request.HTML({
                url : en4.core.baseUrl + 'widget/index/content_id/' + <?php echo sprintf('%d', $this->identity) ?>,
                data : {
                    format : 'html',
                    subject : en4.core.subject.guid,
                    page : <?php echo sprintf('%d', $this->paginator->getCurrentPageNumber() + 1) ?>
                }
            }), {
                'element' : anchor
            })
        });
    });
</script>
<div class="player_contents">
	<div class="tarfee-profile-module-header">
	    <!-- Menu Bar -->
	    <?php
	    if($this -> viewer() -> getIdentity()):
			  $max_player_card = Engine_Api::_()->authorization()->getPermission($this -> viewer(), 'user_playercard', 'max_player_card', 5);
	         if($max_player_card == "")
	         {
	            $mtable  = Engine_Api::_()->getDbtable('permissions', 'authorization');
	             $maselect = $mtable->select()
	                ->where("type = 'user_playercard'")
	                ->where("level_id = ?",$this -> viewer() -> level_id)
	                ->where("name = 'max_player_card'");
	              $mallow_a = $mtable->fetchRow($maselect);          
	              if (!empty($mallow_a))
	                $max_player_card = $mallow_a['value'];
	              else
	                 $max_player_card = 5;
	         }
		    
			if($this->paginator->getTotalItemCount() < $max_player_card && $this -> viewer() -> isSelf($this -> subject())):
		    ?>
		    <div class="tarfee-profile-header-right">
		        <?php echo $this->htmlLink(array(
		            'route' => 'user_extended',
		            'controller' => 'player-card',
		            'action' => 'create',
		        ), '<i class="fa fa-plus-square"></i> '.$this->translate('Add New Player Card'), array(
		            'class' => ''
		        ))
		        ?>
		    </div>    
		    <?php endif;?>  
		<?php endif;?>
	</div>
	
	<div class="tarfee_list" id="players">
	    <!-- Content -->
	    <?php if( $this->paginator->getTotalItemCount() > 0 ): ?>
	    <ul class="players_browse">  
	        <?php foreach ($this->paginator as $player): 
		    $videoTable = Engine_Api::_()->getItemTable('video');
		    $params = array();
		    $params['owner_type'] = $player -> getType();
			$params['owner_id'] = $player -> getIdentity();
			
			$mappingTable = Engine_Api::_()->getDbTable('mappings', 'user');
	        $totalVideo = $mappingTable -> getTotalVideo($params);
	        $totalComment = Engine_Api::_() -> getDbtable('comments', 'yncomment') -> comments($player) -> getCommentCount();
	        $totalLike = Engine_Api::_() -> getDbtable('likes', 'yncomment') -> likes($player) -> getLikeCount(); 
	        $totalDislike = Engine_Api::_() -> getDbtable('dislikes', 'yncomment') -> getDislikeCount($player);
			$totalUnsure = Engine_Api::_() -> getDbtable('unsures', 'yncomment') -> getUnsureCount($player);
	        ?>
	        <?php if($player -> isViewable()) :?>
	        	<li id="player-item-<?php echo $player->playercard_id ?>" style ="clear: both">
	           	<div id='profile_photo'>
					<?php $photoUrl = $player -> getPhotoUrl('thumb.profile');?>
					<div class="avatar">
						<a href="">
							<span alt="" class="thumb_profile" style="background-image:url(<?php echo $photoUrl?>)"></span>
						</a>
						<span><i class="fa fa-cog"></i></span>
					</div>
					<div class="user_rating">
						<span class="rating_star_generic"><i class="fa fa-star"></i></span>&nbsp;
						<span class="rating_star_generic"><i class="fa fa-star"></i></span>&nbsp;
						<span class="rating_star_generic"><i class="fa fa-star"></i></span>&nbsp;
						<span class="rating_star_generic"><i class="fa fa-star-half-o"></i></span>&nbsp;
						<span class="rating_star_generic"><i class="fa fa-star-o"></i></span>
					</div>
					<hr>
					<div class="nickname">
						<div><span><a href="<?php echo $player -> getHref()?>"><?php echo $this -> string() -> truncate($player -> first_name.' '.$player -> last_name, 15)?></span></a></div>
						<span>Man United, England</span>				
					</div>
					<div class="user_rating">
						<?php $overRallRating = $player -> getOverallRating();?>
						<span title="<?php echo $overRallRating;?>">
						<?php if($overRallRating > 0):?>
			            	<?php for($x=1; $x<=$overRallRating; $x++): ?><span class="rating_star_generic rating_star"></span><?php endfor; ?><?php if((round($overRallRating)-$overRallRating)>0):?><span class="rating_star_generic rating_star_half"></span><?php endif; ?>
			     		<?php else :?>
			 				<?php for($x=1; $x<=5; $x++): ?><span class="rating_star_generic rating_star_disabled"></span><?php endfor; ?>
			     		<?php endif;?>
			     		</span>
					</div>
					<div class="actions">
					<ul>
						<li><a class="actions_generic" href=""><span><i class="fa fa-eye"></i></span></a></li>
						<span></span>
						<li><a class="actions_generic" href=""><span><i class="fa fa-plus"></i></span></a></li>
						<span></span>
						<li><a class="actions_generic" href=""><span><i class="fa fa-comment"></i></span></a></li>
						<span></span>
						<li><a class="actions_generic" href=""><span><i class="fa fa-flag"></i></span></a></li>
					</div>
				</div>
	            <div class="playercard_options">
	            	<?php echo $this->htmlLink(array(
			            'route' => 'user_extended',
			            'controller' => 'player-card',
			            'action' => 'view',
			            'id' => $player->playercard_id,
			            'slug' => $player->getSlug(),
			        ), $this->translate('View'), array(
			            'class' => ''
			        ));
	        		?>
	            	<?php 
	            	if($this -> viewer() -> getIdentity() && $player -> getOwner() -> isSelf($this -> viewer()))
					{
		            	echo $this->htmlLink(array(
				            'route' => 'user_extended',
				            'controller' => 'player-card',
				            'action' => 'edit',
				            'id' => $player->playercard_id,
				        ), '<i class="fa fa-pencil"></i>'.$this->translate('Edit'), array(
				            'class' => ''
				        ));
		        		echo $this->htmlLink(array(
				            'route' => 'user_extended',
				            'controller' => 'player-card',
				            'action' => 'crop-photo',
				            'id' => $player->playercard_id,
				        ), '<i class="fa fa-pencil"></i>'.$this->translate('Crop Photo'), array(
				            'class' => ''
				        ));
						
	        			echo $this->htmlLink(array(
						'route' => 'video_general',
							'action' => 'create',
							'parent_type' =>'user_playercard',
							'subject_id' =>  $player->playercard_id,
						), '<i class="fa fa-plus-square"></i>'.$this->translate('Add Video'), array(
						'class' => ''
						)) ;
						echo $this->htmlLink(array(
				            'route' => 'user_extended',
				            'controller' => 'player-card',
				            'action' => 'delete',
				            'id' => $player->playercard_id,
				        ), '<i class="fa fa-delete"></i>'.$this->translate('Delete'), array(
				            'class' => ''
				        ));
				    }
	        		?>
	            </div>
	            	 <?php
				    $playercardVideos = $videoTable -> fetchAll($mappingTable -> getVideosSelect($params));
					?>
					<?php if(count($playercardVideos)):?>
						<ul style="border: 5px solid #eaeaea;" class="videos_browse">
							 <?php foreach ($playercardVideos as $item): ?>
						            <?php
						            echo $this->partial('_player_video_listing.tpl', 'user', array(
						                'video' => $item,
						                'player' => $player,
						            ));
						            ?>
							<?php endforeach; ?>
						</ul>
					<?php endif;?>
	        </li>
			<?php endif;?>
        	<?php endforeach; ?>             
	    </ul>  
	    
	    <div class="players-paginator">
	        <div id="players_previous" class="paginator_previous">
	            <?php echo $this->htmlLink('javascript:void(0);', $this->translate('Previous'), array(
	              'onclick' => '',
	              'class' => 'buttonlink icon_previous'
	            )); ?>
	        </div>
	        <div id="players_next" class="paginator_next">
	            <?php echo $this->htmlLink('javascript:void(0);', $this->translate('Next'), array(
	              'onclick' => '',
	              'class' => 'buttonlink_right icon_next'
	            )); ?>
	        </div>
	    </div>
	   
	    <?php else: ?>
	    <div class="tip">
	        <span>
	             <?php echo $this->translate('No players have been created.');?>
	        </span>
	    </div>
	    <?php endif; ?>
	</div>
</div>

<script type="text/javascript">
	$$('.user-video-item-action').addEvent('outerClick', function(){
	    	if ( this.hasClass('open-submenu') ) {
	    		this.removeClass('open-submenu');	
	    	}
	    });
	
		$$('.user-video-item-action').addEvent('click', function(){
			if ( this.hasClass('open-submenu') ) {
	    		this.removeClass('open-submenu');	
	    	} else {
	    		$$('.open-submenu').removeClass('open-submenu');
	    		this.addClass('open-submenu');
	    	}  
		});
		 
		 $$('.user-video-close-box').addEvent('click', function(){
		 	var parent = this.getParent().getParent().getParent();
    		parent.removeClass('open-submenu');	
		});
</script>