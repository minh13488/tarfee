<?php
$this -> headScript() 
        -> appendFile($this->baseUrl() . '/application/modules/User/externals/scripts/jquery.min.js')
        -> appendFile($this->baseUrl() . '/application/modules/User/externals/scripts/jquery-ui-1.10.4.min.js')
        -> appendFile($this->baseUrl() . '/application/modules/User/externals/scripts/jquery.form.min.js');

$coverPhotoUrl = "";
$hasCover = true;
if ($this->user->cover_photo) {
	$coverFile = Engine_Api::_()->getDbtable('files', 'storage')->find($this->user->cover_photo)->current();
	$coverPhotoUrl = $coverFile->map();
    if (!$coverPhotoUrl) {
        $coverPhotoUrl = 'application/modules/User/externals/images/user_default_cover.jpg';
    }
    else {
        $hasCover = true;
    }
    
}
else {
    $coverPhotoUrl = 'application/modules/User/externals/images/user_default_cover.jpg';
}
?>

<script type="text/javascript">
var cover_top = <?php echo ($hasCover) ? $this->user->cover_top : 0?>;

function repositionCover() {
    jQuery('.reposition-cover').show();
    jQuery('.cover-resize-buttons').show();
    jQuery('.edit-position-buttons').hide();
    jQuery('.view-cover').hide();
    jQuery('.reposition-cover')
    .css('cursor', 's-resize')
    .draggable({
        scroll: false,
        axis: "y",
        cursor: "s-resize",
        drag: function (event, ui) {
            y1 = jQuery('.user-profile-cover-picture').height();
            y2 = jQuery('.reposition-cover').height();
            
            if (ui.position.top >= 0) {
                ui.position.top = 0;
            }
            else
            if (ui.position.top <= (y1-y2)) {
                ui.position.top = y1-y2;
            }
        },
        
        stop: function(event, ui) {
            jQuery('input.cover-position').val(ui.position.top);
        }
    });
}

function saveReposition() {
    if (jQuery('input.cover-position').length == 1) {
        posY = jQuery('input.cover-position').val();
        new Request.JSON({
            'url': '<?php echo $this->url(array('action'=>'reposition', 'controller'=>'edit'),'user_extended', true)?>',
            'method': 'post',
            'data' : {
                'position' : posY
            },
            'onSuccess': function(responseJSON, responseText) {
                if (responseJSON.status == true) {
                    cover_top = posY;
                    jQuery('.profile-cover-picture-span').css('top', posY+'px');
                    jQuery('.reposition-cover').hide();
                    jQuery('.cover-resize-buttons').hide();
                    jQuery('.edit-position-buttons').show();
                    jQuery('.view-cover').show();
                }
                else {
                    alert(responseJSON.message);
                }            
            }
        }).send();
    }
}

function cancelReposition() {
    jQuery('.reposition-cover').hide();
    jQuery('.reposition-cover').css('top', cover_top+'px');
    jQuery('.cover-resize-buttons').hide();
    jQuery('.edit-position-buttons').show();
    jQuery('.view-cover').show();
    jQuery('input.cover-position').val(cover_top);
}
</script>
<div class="user-widget-profile-cover">
    <div class="user-profile-cover-picture">
	        <div class="cover-reposition">
	        <span id="edit-cover-btn">
	        <?php echo $this->htmlLink(array('action'=>'cover', 'route'=>'user_extended', 'controller'=>'edit', 'id'=>$this->user->getIdentity()), $this->translate('Upload New Cover'), array('class'=>'smoothbox'))?>
	        </span>
	        <?php if ($hasCover) :?>
		        <span class="edit-position-buttons"><a href="javascript:void(0)" onclick="repositionCover();"><?php echo $this->translate('Reposition Cover Photo')?></a></span>
		        <div class="cover-resize-buttons" style="display: none;">
		            <span><a href="javascript:void(0)" onclick="saveReposition();"><?php echo $this->translate('Save Position')?></a></span>
		            <span><a href="javascript:void(0)" onclick="cancelReposition();"><?php echo $this->translate('Cancel')?></a></span>
		            <input class="cover-position" name="pos" value="<?php echo ($hasCover) ? $this->user->cover_top : 0?>" type="hidden">
		        </div>
		        </div>
		        <img class="reposition-cover profile-cover-picture-span" src="<?php echo $coverPhotoUrl; ?>" style="display: none; <?php if ($hasCover) echo 'top: '.$this->user->cover_top.'px'?>"></img>
	        <?php else: ?>
	        	</div>
	        <?php endif; ?>
        <img class="view-cover profile-cover-picture-span" src="<?php echo $coverPhotoUrl; ?>" style="<?php if ($hasCover) echo 'top: '.$this->user->cover_top.'px'?>"></img>
    </div>