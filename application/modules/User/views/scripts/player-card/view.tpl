<?php $player = $this -> playerCard;
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
<div style="margin-bottom: 15px; overflow: hidden">
	<div style="width: 285px; float: left">
		<div>
			<?php echo $this -> itemPhoto($player, 'thumb.profile');?>
		</div>
		<div>
			<a href="<?php echo $player -> getHref()?>"><?php echo $this -> string() -> truncate($player -> first_name.' '.$player -> last_name, 15)?>
		</div>
		<div class="playercard_statistics">
			<ul>
				 <li>
			        <span><?php echo $this->translate(array('%s video', '%s videos', $totalVideo), $totalComment) ?></span>
			      </li>
			       <li>
			        <span><?php echo $this->translate(array('%s comment', '%s comments', $totalComment), $totalComment) ?></span>
			      </li>
			       <li>
			        <span><?php echo $this->translate(array('%s like', '%s likes', $totalLike), $totalLike) ?></span>
			      </li>
			       <li>
			        <span><?php echo $this->translate(array('%s dislike', '%s dislikes', $totalDislike), $totalDislike) ?></span>
			      </li>
			       <li>
			        <span><?php echo $this->translate(array('%s unsure', '%s unsures', $totalUnsure), $totalUnsure) ?></span>
			      </li>
			</ul>
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
		<div>
			<?php if($this -> viewer() -> getIdentity()):?>
			<?php echo $this->htmlLink(array(
	            'route' => 'messages_general',
	            'action' => 'compose',
	            'to' => $player -> getOwner() ->getIdentity()
	        ), $this -> translate('Message'), array(
	            'class' => 'smoothbox'
	        ));
			?>
			<?php endif;?>
			<?php echo $this->htmlLink(array(
	            'route' => 'default',
	            'module' => 'activity',
	            'controller' => 'index',
				'action' => 'share',
				'type' => 'user_playercard',
				'id' => $player -> getIdentity(),
	        ), $this -> translate('Share'), array(
	            'class' => 'smoothbox'
	        ));
			?>
		</div>
		 <div class="playercard_options">
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
		        ), '<i class="fa fa-trash-o"></i>'.$this->translate('Delete'), array(
		            'class' => 'buttonlink smoothbox'
		        ));
		    }
			?>
	    </div>
	</div>
	<div style="float: left">
		<?php $videoTable = Engine_Api::_()->getItemTable('video');
		$playercardVideos = $videoTable -> fetchAll($mappingTable -> getVideosSelect($params));?>
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
	</div>
</div>