<div class="tf_right_menu">
   <ul class="list-items">
      <li class="item-action">
         <a href="javascript:void;"><img src="application/themes/ynresponsive-event/images/add.png" /></a>

         <ul class="list-items-dropdown">
            <li><a href=""><i class="fa fa-video-camera"></i>Add Video</a></li>
            <li><a href=""><i class="fa fa-user-plus"></i>Add Player Card</a></li>
            <li><a href=""><i class="fa fa-calendar"></i>Add Event/Tryout</a></li>
            <li><a href=""><i class="fa fa-rocket"></i>Add Campaign</a></li>
            <li><a href=""><i class="fa fa-comments-o"></i>Add Talk</a></li>
            <li><a href=""><i class="fa fa-search"></i>Find/Invite Friend</a></li>
         </ul>
      </li>

      <li><a href=""><img src="application/themes/ynresponsive-event/images/campaign.png" /></a></li>
      <li><a href=""><img src="application/themes/ynresponsive-event/images/club.png" /></a></li>
      <li><a href=""><img src="application/themes/ynresponsive-event/images/event.png" /></a></li>
      <li><a href=""><img src="application/themes/ynresponsive-event/images/market.png" /></a></li>
      <li><a href=""><img src="application/themes/ynresponsive-event/images/professional.png" /></a></li>

      <li class="item-action">
         <a href="javascript:void;"><img src="application/themes/ynresponsive-event/images/help.png" /></a>

         <ul class="list-items-dropdown">
            <li><a href=""><i class="fa fa-question-circle"></i>Help Centre</a></li>
            <li><a href=""><i class="fa fa-info"></i>Suggest Idea or Feature</a></li>
            <li><a href=""><i class="fa fa-phone"></i>Contact Us</a></li>
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
   // jQuery.noConflict();

   // $$('.item-action').addEvent('click',function(){
   //    var item_display = $$('.list-items-dropdown').getStyle('display');
   //    if( item_display == "block" ){
   //       $$('.list-items-dropdown').setStyle('display','none');
   //    }else{
   //       $$('.list-items-dropdown').setStyle({display: 'block' , opacity: 0})fade();
   //    }
   // });

   jQuery.noConflict();
      jQuery('.item-action').click(function() {
         jQuery(this).find('.list-items-dropdown').fadeToggle(400);
      });

</script>