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
	        	<li id="player-item-<?php echo $player->playercard_id ?>">
	           	<div id='profile_photo'>
					<?php $photoUrl = $player -> getPhotoUrl('thumb.profile');?>
					<div class="avatar">
						<a href="<?php echo $player -> getHref()?>">
							<span alt="" class="thumb_profile" style="background-image:url(<?php echo $photoUrl?>)"></span>
						</a>
						<?php 
		            	if($this -> viewer() -> getIdentity() && $player -> getOwner() -> isSelf($this -> viewer())):
						?>
						<span class="setting" onclick="showOptions(<?php echo $player->playercard_id?>, this)"><i class="fa fa-cog"></i>
							<ul class="setting-list" style="display: none" id="setting-list_<?php echo $player->playercard_id?>">
								<li class="first">
									<?php
						            	echo $this->htmlLink(array(
								            'route' => 'user_extended',
								            'controller' => 'player-card',
								            'action' => 'edit',
								            'id' => $player->playercard_id,
								        ), '<i class="fa fa-pencil"></i>&nbsp;'.$this->translate('Edit'), array(
								            'class' => ''
								        ));
									?>
								</li>
								<li class="second">
								<?php
					        		echo $this->htmlLink(array(
							            'route' => 'user_extended',
							            'controller' => 'player-card',
							            'action' => 'crop-photo',
							            'id' => $player->playercard_id,
							        ), '<i class="fa fa-crop"></i>&nbsp;'.$this->translate('Crop Photo'), array(
							            'class' => 'smoothbox'
							        ));
								?>
								</li>
								<li class="third">	
								<?php
				        			echo $this->htmlLink(array(
									'route' => 'video_general',
										'action' => 'create',
										'parent_type' =>'user_playercard',
										'subject_id' =>  $player->playercard_id,
									), '<i class="fa fa-plus-square"></i>&nbsp;'.$this->translate('Add Video'), array(
									'class' => ''
									)) ;
								?>
								</li>
								<li class="fourth">
								<?php
									echo $this->htmlLink(array(
							            'route' => 'user_photo',
							            'controller' => 'upload',
							            'id' => $player->playercard_id,
							            'type' => $player->getType(),
							        ), '<i class="fa fa-plus-square"></i>&nbsp;'.$this->translate('Add Photos'), array(
							            'class' => 'smoothbox'
							        ));
								?>
								</li>
								<li class="fifth">
								<?php
									echo $this->htmlLink(array(
							            'route' => 'user_extended',
							            'controller' => 'player-card',
							            'action' => 'delete',
							            'id' => $player->playercard_id,
							        ), '<i class="fa fa-times"></i>&nbsp;'.$this->translate('Delete'), array(
							            'class' => 'smoothbox'
							        ));
								?>
								</li>
							</ul>
						</span>
						
						    <?php endif;?>
					</div>
					<?php $overRallRating = $player -> getOverallRating();?>
					<div class="user_rating" title="<?php echo $overRallRating;?>">
						<?php for ($x = 1; $x <= $overRallRating; $x++): ?>
					        <span class="rating_star_generic"><i class="fa fa-star"></i></span>&nbsp;
					    <?php endfor; ?>
					    <?php if ((round($overRallRating) - $overRallRating) > 0): $x ++; ?>
					        <span class="rating_star_generic"><i class="fa fa-star-half-o"></i></span>&nbsp;
					    <?php endif; ?>
					    <?php if ($x <= 5) :?>
					        <?php for (; $x <= 5; $x++ ) : ?>
					            <span class="rating_star_generic"><i class="fa fa-star-o"></i></span>&nbsp;
					        <?php endfor; ?>
					    <?php endif; ?>
					</div>
					<hr>
					<div class="nickname">
						<div><span><a href="<?php echo $player -> getHref()?>"><?php echo $this -> string() -> truncate($player -> first_name.' '.$player -> last_name, 15)?></span></a></div>
						<?php
						$countryName = '';
						$provinceName = '';
						$cityName = '';
						if($player ->country_id && $country = Engine_Api::_() -> getItem('user_location', $player ->country_id))
						{
							$countryName = $country -> getTitle();
						}
						if($player ->province_id && $province = Engine_Api::_() -> getItem('user_location', $player ->province_id))
						{
							$provinceName = $province -> getTitle();
						}
						if($player ->city_id && $city = Engine_Api::_() -> getItem('user_location', $player ->city_id))
						{
							$cityName = $city -> getTitle();
						}
						?>
						<span><?php if($cityName) echo $cityName; else echo $provinceName; if($countryName) echo ', '.$countryName;?></span>
						<div>
							<?php echo $this->htmlLink($player -> getOwner()->getHref(), $this->itemPhoto($player -> getOwner(), 'thumb.icon', $player -> getOwner()->getTitle(), array('style' => 'width: auto')), array('class' => 'members_thumb')) ?>
							<div class='members_info'>
						        <div class='members_name'>
							          <?php echo $this->htmlLink($player -> getOwner()->getHref(), $player -> getOwner() ->getTitle()) ?>
						        </div>
						        <div class='members_date'>
						          <?php echo $this->timestamp($player -> getOwner() -> creation_date) ?>
						        </div>
					      	</div>
					     </div>
					</div>
					<div class="actions">
					<ul>
						<?php if ($this -> viewer() -> getIdentity()):?>
							<li title="<?php echo $this -> translate("eye on")?>" id="user_eyeon_<?php echo $player -> getIdentity()?>">
	                    		<?php if($player->isEyeOn()): ?>              
	                        	<a class="actions_generic" href="javascript:void(0);" onclick="removeEyeOn('<?php echo $player->getIdentity() ?>')">
	                        		<span><i class="fa fa-eye-slash"></i></span>
                        		</a>
	                    		<?php else: ?>
	                        	<a class="actions_generic" href="javascript:void(0);" onclick="addEyeOn('<?php echo $player->getIdentity() ?>')">
	                        		<span><i class="fa fa-eye"></i></span>
	                        	</a>
	                    		<?php endif; ?>
	                		</li>
                			<span></span>
                		<?php endif;?>
						<li><a class="actions_generic" href=""><span><i class="fa fa-plus"></i></span></a></li>
						<span></span>
						<li title="<?php echo $this -> translate('comment')?>"><a class="actions_generic" href="<?php echo $player -> getHref()?>"><span><i class="fa fa-comment"></i></span></a></li>
						<span></span>
						<?php $url = $this->url(array('module'=> 'core', 'controller' => 'report', 'action' => 'create', 'subject' => $player->getGuid(), 'format' => 'smoothbox'),'default', true);?>
						<li><a class="actions_generic smoothbox" href="<?php echo $url?>"><span><i class="fa fa-flag"></i></span></a></li>
					</div>
				</div>
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
function addEyeOn(itemId) 
{
    $('user_eyeon_'+itemId).set('html', '<a class="actions_generic" href="javascript:void(0);"><span><i class="fa fa fa-spinner fa-pulse"></i></span></a>');
    new Request.JSON({
        'url': '<?php echo $this->url(array('action'=>'add-eye-on'),'user_playercard', true)?>',
        'method': 'post',
        'data' : {
            'id' : itemId
        },
        'onSuccess': function(responseJSON, responseText) {
            if (responseJSON.status == true) {
                html = '<a class="actions_generic eye-on" href="javascript:void(0);" onclick="removeEyeOn('+itemId+')"><span><i class="fa fa-eye-slash"></i></span></a>';
                $('user_eyeon_'+itemId).set('html', html);
            }
            else {
                alert(responseJSON.message);
            }            
        }
    }).send();
}

function removeEyeOn(itemId){
	$('user_eyeon_'+itemId).set('html', '<a class="actions_generic" href="javascript:void(0);"><span><i class="fa fa fa-spinner fa-pulse"></i></span></a>');
    new Request.JSON({
        'url': '<?php echo $this->url(array('action'=>'remove-eye-on'),'user_playercard', true)?>',
        'method': 'post',
        'data' : {
            'id' : itemId
        },
        'onSuccess': function(responseJSON, responseText) {
            if (responseJSON.status == true) {
                html = '<a class="actions_generic" href="javascript:void(0);" onclick="addEyeOn('+itemId+')"><span><i class="fa fa-eye"></i></span></a>';
                $('user_eyeon_'+itemId).set('html', html);
            }
            else {
                alert(responseJSON.message);
            }            
        }
    }).send();
}
function showOptions(itemId, obj)
{
	$$('.setting-list').each(function(e)
	{
		if(e != $('setting-list_' + itemId))
			e.style.display = 'none';
	});
	$$('.setting').each(function(e)
	{
		e.removeClass('active');
	});
	if($('setting-list_' + itemId).style.display == '')
	{
		$('setting-list_' + itemId).style.display = 'none';
		obj.removeClass('active');
	}
	else
	{
		$('setting-list_' + itemId).style.display = ''
		obj.addClass('active');
	}
}
</script>
