<style>
.ynsc_sprite
{
	width: <?php echo $this->iconsize;?>px;
	height: <?php echo $this->iconsize;?>px;
	margin-top: <?php echo $this->margintop;?>px;
	margin-right: <?php echo $this->marginright;?>px;
	padding: 2px;
}
</style>
<?php
$background = rand(1, 3);
?>
<div class="tf_bgbody_landing" style="background-image: url(application/themes/ynresponsive-event/images/Bkgden_<?php echo $background?>.jpg)">
	<div class="tf_bgdot_landing"></div>
</div>
<div id="landing_popup" ></div>
<h1><img src="application/themes/ynresponsive-event/images/example_only.png" alt="tarfee . Spring 2015" class="brand"></h1>

<?php if( !$this->noForm ): ?>
  <?php echo $this->form->setAttrib('class', 'global_form_box')->render($this) ?>
	
  <?php if( !empty($this->fbUrl) ): ?>

    <script type="text/javascript">
      var openFbLogin = function() {
        Smoothbox.open('<?php echo $this->fbUrl ?>');
      }
      var redirectPostFbLogin = function() {
        window.location.href = window.location;
        Smoothbox.close();
      }
    </script>

  <?php endif; ?>

<?php else: ?>
  <h3 style="margin-bottom: 0px;">
    <?php echo $this->htmlLink(array('route' => 'user_login'), $this->translate('Sign In')) ?>
    <?php echo $this->translate('or') ?>
    <?php echo $this->htmlLink(array('route' => 'user_signup'), $this->translate('Join')) ?>
  </h3>
  <?php echo $this->form->setAttrib('class', 'global_form_box no_form')->render($this) ?>
<?php endif; ?>