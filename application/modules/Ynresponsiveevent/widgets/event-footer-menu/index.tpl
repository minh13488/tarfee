<?php 
$viewer = $this -> viewer();
?>
<div class="tf_right_menu">
   
   <span id="show-hide-list-items">
   </span>
   
   <ul class="list-items">
   	<?php if($viewer -> getIdentity()):
	$library =  $viewer -> getMainLibrary();
   	?>
      <li class="item-action">
         <a title="<?php echo $this -> translate("add")?>" href="javascript:void;"><img src="application/themes/ynresponsive-event/images/add.png" /></a>
         <ul class="list-items-dropdown">
         	<?php $videoUrl = $this->url(array(
					'action' => 'create',
					'parent_type' =>'user_library',
					'subject_id' =>  $library->getIdentity(),
					'tab' => 1490,
				), 'video_general', true) ;
			?>
           		<li><a href="<?php echo $videoUrl?>"><i class="fa fa-video-camera"></i><?php echo $this -> translate("Add Video")?></a></li>
            <?php 
            $max_player_card = Engine_Api::_()->authorization()->getPermission($viewer, 'user_playercard', 'max_player_card', 5);
	        if($max_player_card == "")
	         {
	             $mtable  = Engine_Api::_()->getDbtable('permissions', 'authorization');
	             $maselect = $mtable->select()
	                ->where("type = 'user_playercard'")
	                ->where("level_id = ?", $viewer -> level_id)
	                ->where("name = 'max_player_card'");
	              $mallow_a = $mtable->fetchRow($maselect);          
	              if (!empty($mallow_a))
	                $max_player_card = $mallow_a['value'];
	              else
	                 $max_player_card = 5;
	         }
			if(Engine_Api::_() -> getDbTable('playercards', 'user') -> getPlayersPaginator($viewer -> getIdentity()) ->getTotalItemCount() < $max_player_card):
	            $Url = $this->url(array(
						'controller' => 'player-card',
	            		'action' => 'create',
						'tab' => 724,
					), 'user_extended', true) ;
				?>
            	<li><a href="<?php echo $Url?>"><i class="fa fa-user-plus"></i><?php echo $this -> translate("Add Player Card")?></a></li>
            <?php endif;?>
            <?php if(Engine_Api::_() -> authorization() -> isAllowed('event', null, 'create')):?>
            	<li><a href="<?php echo $this->url(array('action' => 'create'), 'event_general')?>"><i class="fa fa-calendar"></i><?php echo $this -> translate("Add Event/Tryout")?></a></li>
            <?php endif;?>
            <li><a href="<?php echo $this -> url(array('action' => 'create'), 'tfcampaign_general', true);?>"><i class="fa fa-rocket"></i><?php echo $this -> translate("Add Campaign")?></a></li>
            <li><a href="<?php echo $this->url(array('action' => 'create'), 'blog_general')?>"><i class="fa fa-comments-o"></i><?php echo $this -> translate("Add Talk")?></a></li>
            <li><a href="contactimporter/import"><i class="fa fa-search"></i><?php echo $this -> translate("Find/Invite Friend")?></a></li>
         </ul>
      </li>
    <?php endif;?>
      <li><a title="<?php echo $this -> translate("campaigns")?>" href="<?php echo $this -> url(array(), 'tfcampaign_general', true);?>"><img src="application/themes/ynresponsive-event/images/campaign.png" /></a></li>
      <li><a title="<?php echo $this -> translate("clubs & organizations")?>" href="<?php echo $this -> url(array(), 'group_general', true);?>"><img src="application/themes/ynresponsive-event/images/club.png" /></a></li>
      <li><a title="<?php echo $this -> translate("events & tryouts")?>" href="<?php echo $this -> url(array(), 'event_general', true);?>"><img src="application/themes/ynresponsive-event/images/event.png" /></a></li>
      <li><a title="<?php echo $this -> translate("talks")?>" href="<?php echo $this -> url(array(), 'blog_general', true);?>"><img src="application/themes/ynresponsive-event/images/talk.png" /></a></li>
      <li><a title="<?php echo $this -> translate("professionals")?>" href="#"><img src="application/themes/ynresponsive-event/images/professional.png" /></a></li>

      <li class="item-action">
         <a title="<?php echo $this -> translate("help")?>" href="javascript:void;"><img src="application/themes/ynresponsive-event/images/help.png" /></a>
         <ul class="list-items-dropdown">
            <li><a href="#"><i class="fa fa-question-circle"></i><?php echo $this -> translate("Help Centre")?></a></li>
            <li><a href="#"><i class="fa fa-info"></i><?php echo $this -> translate("Suggest Idea or Feature")?></a></li>
            <li><a href="help/contact"><i class="fa fa-phone"></i><?php echo $this -> translate("Contact Us")?></a></li>
         </ul>
      </li>

   </ul>
</div>

<div class="container">
   <span class="ynresponsive_menus"> 
      <?php foreach( $this->navigation as $item ):
         $attribs = array_diff_key(array_filter($item->toArray()), array_flip(array(
         'reset_params', 'route', 'module', 'controller', 'action', 'type',
         'visible', 'label', 'href'
         )));
      ?>

         &nbsp;&nbsp; <?php echo $this->htmlLink($item->getHref(), $this->translate($item->getLabel()), $attribs) ?>
      <?php endforeach; ?>


      <span class="ynresponsive_languges">
         <?php if( 1 !== count($this->languageNameList) ): ?>
            <form method="post" action="<?php echo $this->url(array('controller' => 'utility', 'action' => 'locale'), 'default', true) ?>" style="display:inline-block">
            <?php $selectedLanguage = $this->translate()->getLocale() ?>
            <?php echo $this->formSelect('language', $selectedLanguage, array('onchange' => '$(this).getParent(\'form\').submit();'), $this->languageNameList) ?>
            <?php echo $this->formHidden('return', $this->url()) ?>
            </form>
         <?php endif; ?>
      </span>
    </span>


    <span class="ynresponsive_copyright">
      &copy; <?php echo $this->translate('%s tarfee', date('Y')) ?>
    </span>
    <?php if( !empty($this->affiliateCode) ): ?>
      <div class="affiliate_banner">
        <?php 
          echo $this->translate('Powered by %1$s', 
            $this->htmlLink('http://www.socialengine.com/?source=v4&aff=' . urlencode($this->affiliateCode), 
            $this->translate('SocialEngine Community Software'),
            array('target' => '_blank')))
        ?>
      </div>
    <?php endif; ?>
</div>

<script type="text/javascript">
   jQuery.noConflict();

      jQuery('#show-hide-list-items').click(function() {
         jQuery('.list-items').fadeToggle(400);
      });

      jQuery('.item-action').click(function() {
         jQuery(this).find('.list-items-dropdown').fadeToggle(400);
      });
</script>