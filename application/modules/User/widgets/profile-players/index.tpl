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
	    $max_player_card = Engine_Api::_()->authorization()->getPermission($this -> viewer(), 'player_card', 'max_player_card', 5); 
		if($this->paginator->getTotalItemCount() < $max_player_card):
	    ?>
	    <div class="tarfee-profile-header-right">
	        <?php echo $this->htmlLink(array(
	            'route' => 'user_extended',
	            'controller' => 'player-card',
	            'action' => 'create',
	        ), $this->translate('Add New Player Card'), array(
	            'class' => ''
	        ))
	        ?>
	    </div>      
		<?php endif;?>
	</div>
	
	<div class="tarfee_list" id="players">
	    <!-- Content -->
	    <?php if( $this->paginator->getTotalItemCount() > 0 ): ?>
	    <ul class="players_browse">  
	        <?php foreach ($this->paginator as $player): ?>
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
						<span><?php echo $player -> first_name.' '.$player -> last_name?></span>
					</div>
					<div class="user_rating">
						<span class="rating_star_generic rating_star_big"></span>
						<span class="rating_star_generic rating_star_big"></span>
						<span class="rating_star_generic rating_star_big"></span>
						<span class="rating_star_generic rating_star_big"></span>
						<span class="rating_star_generic rating_star_big_disabled"></span>
					</div>
					<div class="actions">
						<div>
						<table><tr>
						<td><a href=""><span class="actions_generic messaging"></span></a></td>
						<td><a href=""><span class="actions_generic sharing"></span></a></td>
						<td><a href=""><span class="actions_generic like"></span></a></td>
						</tr></table>
						</div>
					</div>
				</div>
	            <div class="playercaed_options">
	            	<?php echo $this->htmlLink(array(
			            'route' => 'user_extended',
			            'controller' => 'player-card',
			            'action' => 'edit',
			            'id' => $player->playercard_id,
			        ), $this->translate('Edit'), array(
			            'class' => 'buttonlink'
			        ));
	        		?>
	        		<?php echo $this->htmlLink(array(
			            'route' => 'user_extended',
			            'controller' => 'player-card',
			            'action' => 'delete',
			            'id' => $player->playercard_id,
			        ), $this->translate('Delete'), array(
			            'class' => 'buttonlink smoothbox'
			        ));
	        		?>
	            </div>
	        </li>
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