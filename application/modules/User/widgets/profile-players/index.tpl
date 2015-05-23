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
            'class' => 'buttonlink'
        ))
        ?>
    </div>      
	<?php endif;?>
    <div class="tarfee-profile-header-content">
        <?php if( $this->paginator->getTotalItemCount() > 0 ): ?>
            <span class="tarfee-numeric"><?php echo $this->paginator->getTotalItemCount(); ?></span>
            <?php echo $this-> translate(array("Player Card", "Player Cards", $this->paginator->getTotalItemCount()), $this->paginator->getTotalItemCount());?>
        <?php endif; ?>
    </div>
</div>

<div class="tarfee_list" id="players">
    <!-- Content -->
    <?php if( $this->paginator->getTotalItemCount() > 0 ): ?>
    <ul class="players_browse">  
        <?php foreach ($this->paginator as $player): ?>
        <li id="player-item-<?php echo $player->playercard_id ?>">
            <?php echo $this->htmlLink(
                $player->getHref(),
                $this->itemPhoto($player -> getOwner(), 'thumb.icon', $player -> getOwner()->getTitle()),
                array('class' => 'players_browse_photo')
            ) ?>
            <div class="players_browse_info">
                <h3 class="players_browse_info_title">
                    <?php echo $this->htmlLink($player->getHref(), $player->getTitle()) ?>
                </h3>
                <div class="players_browse_info_date">
                    <?php echo $this->translate('Posted by %s', $this->htmlLink($player -> getOwner(), $player -> getOwner()->getTitle())) ?>
                    <?php echo $this->timestamp($player->creation_date) ?>
                </div>
                <?php if (!empty($player->description)): ?>
	                <div class="players_browse_info_desc">
	                <?php echo $player->description ?>
	                </div>
                <?php endif; ?>
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