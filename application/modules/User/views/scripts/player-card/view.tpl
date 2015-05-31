<?php $player = $this -> playerCard;?>
<div class="player_contents">
	<div class="tarfee_list" id="players">
	    <!-- Content -->
	    <ul class="players_browse">  
	        <li id="player-item-<?php echo $player->playercard_id ?>">
	           <div id='profile_photo'>
					<?php $photoUrl = $player -> getPhotoUrl('thumb.profile');?>
					<div class="avatar">
						<span>
							<a href="">
								<span alt="" class="thumb_profile_stroke" style="">
									<span alt="" class="thumb_profile_innershadow" style="">
										<span alt="" class="thumb_profile" style="background-image:url(<?php echo $photoUrl?>)"></span>
									</span>
								</span>
							</a>
						</span>
					</div>
					<div class="nickname">
						<span><a href="<?php echo $player -> getHref()?>"><?php echo $this -> string() -> truncate($player -> first_name.' '.$player -> last_name, 15)?></span></a>
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
						<div>
						<table>
							<tr>
								<td>
									<?php if($this -> viewer() -> getIdentity()):?>
									<?php echo $this->htmlLink(array(
							            'route' => 'messages_general',
							            'action' => 'compose',
							            'to' => $player -> getOwner() ->getIdentity()
							        ), '<span class="actions_generic messaging"></span>', array(
							            'class' => 'smoothbox'
							        ));
						    		?>
						    		<?php endif;?>
								</td>
								<td>
									<?php echo $this->htmlLink(array(
							            'route' => 'default',
							            'module' => 'activity',
							            'controller' => 'index',
										'action' => 'share',
										'type' => 'user_playercard',
										'id' => $player -> getIdentity(),
							        ), '<span class="actions_generic sharing"></span>', array(
							            'class' => 'smoothbox'
							        ));
						    		?>
								</td>
								<td>
									<?php if($this -> viewer() -> getIdentity()):?>
										<a href=""><span class="actions_generic like"></span></a>
									<?php endif;?>
								</td>
						</tr></table>
						</div>
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
			            'class' => 'buttonlink'
			        ));
	        		?>
	            	<?php 
	            	if($this -> viewer() -> getIdentity() && $player -> getOwner() -> getIdentity() == $this -> viewer() -> getIdentity())
					{
		            	echo $this->htmlLink(array(
				            'route' => 'user_extended',
				            'controller' => 'player-card',
				            'action' => 'edit',
				            'id' => $player->playercard_id,
				        ), '<i class="fa fa-pencil"></i>'.$this->translate('Edit'), array(
				            'class' => 'buttonlink'
				        ));
		        		echo $this->htmlLink(array(
				            'route' => 'user_extended',
				            'controller' => 'player-card',
				            'action' => 'crop-photo',
				            'id' => $player->playercard_id,
				        ), '<i class="fa fa-pencil"></i>'.$this->translate('Crop Photo'), array(
				            'class' => 'buttonlink smoothbox'
				        ));
						
	        			echo $this->htmlLink(array(
						'route' => 'video_general',
							'action' => 'create',
							'parent_type' =>'user_playercard',
							'subject_id' =>  $player->playercard_id,
						), '<i class="fa fa-plus-square"></i>'.$this->translate('Add Video'), array(
						'class' => 'buttonlink'
						)) ;
						echo $this->htmlLink(array(
				            'route' => 'user_extended',
				            'controller' => 'player-card',
				            'action' => 'delete',
				            'id' => $player->playercard_id,
				        ), '<i class="fa fa-delete"></i>'.$this->translate('Delete'), array(
				            'class' => 'buttonlink smoothbox'
				        ));
				    }
	        		?>
	            </div>
	            	<!-- get videos of sub libraries -->
	        </li>
	        <?php
			    $mappingTable = Engine_Api::_()->getDbTable('mappings', 'user');
			    $videoTable = Engine_Api::_()->getItemTable('video');
			    $params = array();
			    $params['owner_type'] = $player -> getType();
				$params['owner_id'] = $player -> getIdentity();
			    $playercardVideos = $videoTable -> fetchAll($mappingTable -> getVideosSelect($params));
			?>
			<br/>
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
	    </ul>  
	</div>
</div>