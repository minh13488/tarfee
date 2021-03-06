<div class="settings">
<div class='advgroup_reinvite_form'>
  <?php if ($this->ids):?>
  <form method="post">
    <div>
      <h3><?php echo $this->translate("Resend Invitation(s)?") ?></h3>
      <p>
        <?php echo $this->translate("Are you sure you want to resend %d invitation(s) to  these members?", $this->count) ?>
      </p>
      <br />
      <p>
        <input type="hidden" name="confirm" value='true'/>
        <input type="hidden" name="ids" value="<?php echo $this->ids?>"/>
        <button type='submit'><?php echo $this->translate("Resend") ?></button>
        <?php echo Zend_Registry::get('Zend_Translate')->_(' or ') ?>
        <a href='<?php echo $this->url(array('controller' => 'invite-manage', 'action' => 'manage'));?>'>
        <?php echo $this->translate("cancel") ?></a>
      </p>
    </div>
  </form>
  <?php else: ?>
  <form>
    <div>
      <h3><?php echo $this->translate("Resend Invitation(s)?") ?></h3>
      <p>
        <?php echo $this->translate("Please select an user to resend invitation.") ?>
      </p>
      <br/>
      <a href="<?php echo $this->url(array('controller' => 'invite-manage', 'action' => 'manage')) ?>" class="buttonlink icon_back">
        <?php echo $this->translate("Go Back") ?>
      </a>
    </div>
   </form>
  <?php endif;?>
</div>
</div>
<?php if( @$this->closeSmoothbox ): ?>
<script type="text/javascript">
  TB_close();
</script>
<?php endif; ?>
