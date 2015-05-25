<?php 
    $label = Engine_Api::_()->user()->getSectionLabel($this->section);
    $viewer = Engine_Api::_()->user()->getViewer();
    $user = $this->user;
    $params = $this->params;
    $manage = ($viewer->getIdentity() == $user->getIdentity()) ;
    $create = (isset($params['create'])) ? $params['create'] : false;
	$bio = $user->bio;
	
	$permissionsTable = Engine_Api::_()->getDbtable('permissions', 'authorization');
    $max_character = $permissionsTable->getAllowed('user', $user->level_id, 'bio_max');
    if ($max_character == null) {
        $row = $permissionsTable->fetchRow($permissionsTable->select()
        ->where('level_id = ?', $user->level_id)
        ->where('type = ?', 'user')
        ->where('name = ?', 'bio_max'));
        if ($row) {
            $max_character = $row->value;
        }
    }
?>
<?php if ($manage || !empty($bio)) : ?>
<div class="profile-section-button">
<?php if ($manage) :?>
	<span class="manage-section-button">
		<a href="javascript:void(0)" rel="bio" class="create-button"><?php echo (!empty($bio)) ? '<i class="fa fa-pencil"></i>' : '<i class="fa fa-plus-square"></i>'?></a>
	</span>	
<?php endif;?>	
</div>
<h3 class="section-label"><?php echo $this->translate($label);?></h3>
 
<div class="profile-section-loading" style="display: none; text-align: center">
    <img src='application/modules/User/externals/images/loading.gif'/>
</div>
    
<div class="profile-section-content">
<?php if ($create) : ?>
    <div id="profile-section-form-bio" class="profile-section-form">
        <form rel="bio" class="section-form">
            <p class="error"></p>
            <div id="bio-bio-wrapper" class="profile-section-form-wrapper">
            	<p class="error"></p>
                <textarea maxlength="50" id="bio-bio" name="bio"/><?php if (!empty($bio)) echo $bio?></textarea>
                <?php if ($max_character) :?>
                <p class="form-description"><?php echo $this->translate('The maximum characters is %s', $max_character)?></p>
                <?php endif; ?>
            </div>
            <script type="text/javascript">
            	window.addEvent('domready', function() {
            		tinymce.init({mode: "exact", elements: "bio-bio", plugins: "table,fullscreen,media,preview,paste,code,image,textcolor", theme: "modern", menubar: false, statusbar: false, toolbar1: "undo,|,redo,|,removeformat,|,pastetext,|,code,|,media,|,image,|,link,|,fullscreen,|,preview", toolbar2: "fontselect,fontsizeselect,bold,italic,underline,strikethrough,forecolor,backcolor,|,alignleft,aligncenter,alignright,alignjustify,|,bullist,numlist,|,outdent,indent,blockquote", toolbar3: "", element_format: "html", height: "225px", convert_urls: false, language: "en", directionality: "ltr",
            		setup: function(ed) {           
			            var maxlength = <?php echo $max_character?>;
			            if (maxlength > 0) {
				            ed.on('keypress', function(e) {
								var div = document.createElement("div");
								div.innerHTML = ed.getContent();
				            	tinylen = div.innerText.length;
				                if (tinylen >= maxlength) {
				                	e.preventDefault();
        							e.stopPropagation();
				                }
				            });
			           }
			        }});
            	});
            </script>
            <div class="profile-section-form-buttons">
                <button type="submit" id="submit-btn"><?php echo $this->translate('Save')?></button>
                <button rel="bio" type="button" class="reload-cancel-btn"><?php echo $this->translate('Cancel')?></button>
                <?php if (!empty($bio)) : ?>
                <?php echo $this->translate(' or ')?>
                <a rel="bio" href="javascript:void(0);" class="remove-btn"><?php echo $this->translate('remove Biography')?></a>
                <?php endif; ?>                
            </div>            
        </form>
    </div>
<?php else: ?>
	<div class="profile-section-list">
	<?php if (!empty($bio)) : ?>
		<div id="bio-content"><?php echo $bio;?></div>
	<?php else: ?>
		<div class="tip">
			<span><?php echo $this->translate('Biography is empty!')?></span>
		</div>
	<?php endif; ?>
	</div>
<?php endif;?>
</div>
<?php endif;?>