<div class="sideicon">
	<ul>
		<li class="sideicon_generic plus">
			<a href="#"><span class="fa fa-plus"></span></a>
		</li>
		<li class="sideicon_generic calendar">
			<a href="#"><span class="fa fa-calendar"></span></a>
		</li>
		<li class="sideicon_generic addfriend">
			<a href="#"><span class="fa fa-user-plus"></span></a>
		</li>
		<li class="sideicon_generic friends">
			<a href="#"><span class="fa fa-users"></span></a>
		</li>
		<li class="sideicon_generic noname">
			<a href="#"><span class="fa fa-credit-card"></span></a>
		</li>
		<li class="sideicon_generic office">
			<a href="#"><span class="fa fa-building"></span></a>
		</li>
		<li class="sideicon_generic news">
			<a href="#"><span class="fa fa-newspaper-o"></span></a>
		</li>
		<li class="sideicon_generic help">
			<a href="#"><span class="fa fa-question"></span></a>
		</li>
	</ul>
</div>
<div class="container">
    <span class="ynresponsive_copyright">
    	&copy; <?php echo $this->translate('%s EVENTSITE', date('Y')) ?>
    </span>
    <span class="ynresponsive_menus"> 
    <?php foreach( $this->navigation as $item ):
      $attribs = array_diff_key(array_filter($item->toArray()), array_flip(array(
        'reset_params', 'route', 'module', 'controller', 'action', 'type',
        'visible', 'label', 'href'
      )));
      ?>
      &nbsp;&nbsp; <?php echo $this->htmlLink($item->getHref(), $this->translate($item->getLabel()), $attribs) ?>
    <?php endforeach; ?>
    </span>
    <span class="ynresponsive_languges">
    <?php if( 1 !== count($this->languageNameList) ): ?>
        <form method="post" action="<?php echo $this->url(array('controller' => 'utility', 'action' => 'locale'), 'default', true) ?>" style="display:inline-block">
          <?php $selectedLanguage = $this->translate()->getLocale() ?>
          <?php echo $this->formSelect('language', $selectedLanguage, array('onchange' => '$(this).getParent(\'form\').submit();'), $this->languageNameList) ?>
          <?php echo $this->formHidden('return', $this->url()) ?>
        </form>
    <?php endif; ?>
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