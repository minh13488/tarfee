<?php 
    $label = Engine_Api::_()->user()->getSectionLabel($this->section);
    $viewer = Engine_Api::_()->user()->getViewer();
    $user = $this->user;
    $params = $this->params;
    $manage = ($viewer->getIdentity() == $user->getIdentity()) ;
    $create = (isset($params['create'])) ? $params['create'] : false;
	$contact_num = $user->contact_num;
	$email1 = $user->email1;
	$email2 = $user->email2;
	$skype = $user->skype;
?>
<?php if ($manage || !empty($contact_num)) : ?>
<h3 class="section-label"><?php echo $this->translate($label);?></h3>
 
<div class="profile-section-button">
<?php if ($manage) :?>
	<span class="manage-section-button">
		<a href="javascript:void(0)" rel="contact" class="create-button"><?php echo (!empty($contact_num)) ? $this->translate('Edit') : $this->translate('Add')?></a>
	</span>	
<?php endif;?>	
</div>

<div class="profile-section-loading" style="display: none; text-align: center">
    <img src='application/modules/User/externals/images/loading.gif'/>
</div>
    
<div class="profile-section-content">
<?php if ($create) : ?>
    <div id="profile-section-form-contact" class="profile-section-form">
        <form rel="contact" class="section-form">
            <p class="error"></p>
            <div id="contact-contact_num-wrapper" class="profile-section-form-wrapper">
            	<label for="contact-contact_num"><?php echo $this->translate('*Contact #')?></label>
                <div class="profile-section-form-input">
                    <input type="text" id="contact-contact_num" name="contact_num" value="<?php if ($contact_num) echo htmlentities($contact_num);?>"/>
                    <p class="error"></p>
                </div>
            </div>
            
            <div id="contact-email1-wrapper" class="profile-section-form-wrapper">
            	<label for="contact-email1"><?php echo $this->translate('*Email 1')?></label>
                <div class="profile-section-form-input">
                    <input type="text" id="contact-email1" name="email1" value="<?php if ($email1) echo htmlentities($email1);?>"/>
                    <p class="error"></p>
                </div>
            </div>
            
            <div id="contact-email2-wrapper" class="profile-section-form-wrapper">
            	<label for="contact-email2"><?php echo $this->translate('Email 2')?></label>
                <div class="profile-section-form-input">
                    <input type="text" id="contact-email2" name="email2" value="<?php if ($email2) echo htmlentities($email2);?>"/>
                    <p class="error"></p>
                </div>
            </div>
            
            <div id="contact-skype-wrapper" class="profile-section-form-wrapper">
            	<label for="contact-skype"><?php echo $this->translate('Skype')?></label>
                <div class="profile-section-form-input">
                    <input type="text" id="contact-skype" name="skype" value="<?php if ($skype) echo htmlentities($skype);?>"/>
                    <p class="error"></p>
                </div>
            </div>
            
            <div class="profile-section-form-buttons">
                <button type="submit" id="submit-btn"><?php echo $this->translate('Save')?></button>
                <button rel="contact" type="button" class="reload-cancel-btn"><?php echo $this->translate('Cancel')?></button>
                <?php if (!empty($contact_num)) : ?>
                <?php echo $this->translate(' or ')?>
                <a rel="contact" href="javascript:void(0);" class="remove-btn"><?php echo $this->translate('remove Contact')?></a>
                <?php endif; ?>                
            </div>            
        </form>
    </div>
<?php else: ?>
	<div class="profile-section-list">
	<?php if (!empty($contact_num)) : ?>
		<div id="contact-content">
			<div id="contact-contact_num"><?php echo $this->translate('Contact #: %s', $contact_num)?></div>
			<div id="contact-email1"><?php echo $this->translate('Email 1: %s', $email1)?></div>
			<?php if (!empty($email2)):?>
			<div id="contact-email2"><?php echo $this->translate('Email 2: %s', $email2)?></div>
			<?php endif;?>
			<?php if (!empty($skype)):?>
			<div id="contact-skype"><?php echo $this->translate('Skype: %s', $skype)?></div>
			<?php endif;?>
		</div>
	<?php else: ?>
		<div class="tip">
			<span><?php echo $this->translate('Contact Information is empty!')?></span>
		</div>
	<?php endif; ?>
	</div>
</div>
<?php endif;?>
<?php endif;?>