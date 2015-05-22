<?php $this -> headScript() -> appendFile($this -> layout() -> staticBaseUrl . 'externals/tinymce/tinymce.min.js'); ?>
<?php $this->headScript()->appendFile("//maps.googleapis.com/maps/api/js?v=3.exp&sensor=false&libraries=places"); ?>

<?php 
    $viewer = $this->viewer;
	$subject = $this->subject;
?>

<div id="ynresume-manage-sections-content">
    <ul id="sections-content-items">
    <?php 
    $allSections = Engine_Api::_()->user()->getAllSections();
    foreach ($allSections as $key => $section): ?>
		<?php 
			$content = Engine_Api::_()->user()->renderSection($key, $subject, array());
			if (trim($content)) : ?>
		        <li class="sections-content-item" id="sections-content-item_<?php echo $key?>">
			        <div class="profile-section">
			        	<?php echo $content; ?>
			        </div>
		        </li>
	        <?php endif;?>   
    <?php endforeach;?>
    </ul>
</div>

<script>
var confirm = false;
var type = '';
var item_id = 0;

window.addEvent('domready', function() {
    addEventToForm();
});

function addEventToForm() {
	$$('.create-button').each(function(el) {
        el.removeEvents('click');
        el.addEvent('click', function(e){
            var type = this.get('rel');
            var params = {};
            params.create = true;
            renderSection(type, params);
        });
    });
    
    $$('.section-form').each(function(el) {
        el.removeEvents('submit');
        el.addEvent('submit', function(e){
            e.preventDefault();
            var type = this.get('rel');
            var params = this.toQueryString().parseQueryString();
            params.save = true;
            renderSection(type, params);
        });
    });
    
    $$('.reload-cancel-btn').each(function(el) {
        el.removeEvents('click');
        el.addEvent('click', function(e){
            var type = this.get('rel');
            var params = {};
            renderSection(type, params);
        });
    });
    
    $$('.remove-btn').each(function(el) {
        el.removeEvents('click');
        el.addEvent('click', function(e){
            var item = this.getParent('.section-form').getElement('.item_id');
            if (item) {
            	var id = item.get('id');
            	var arr = id.split('-');
            	if (arr.length >= 2) {
            		type = arr[0];
            		item_id = arr[1];
            	}
            }
            else {
            	type = this.get('rel');
            }
            
            
            var div = new Element('div', {
               'class': 'profile-section-confirm-popup' 
            });
            var text = '<?php echo $this->translate('Do you want to remove this?')?>';
            var p = new Element('p', {
                'class': 'profile-section-confirm-message',
                text: text,
            });
            var button = new Element('button', {
                'class': 'profile-section-confirm-button',
                text: '<?php echo $this->translate('Remove')?>',
                onclick: 'parent.Smoothbox.close();confirm=true;removeItemConfirm();'
                
            });
            var span = new Element('span', {
               text: '<?php echo $this->translate(' or ')?>' 
            });
            
            var cancel = new Element('a', {
                text: '<?php echo $this->translate('Cancel')?>',
                onclick: 'parent.Smoothbox.close();',
                href: 'javascript:void(0)'
            });
            
            div.grab(p);
            div.grab(button);
            div.grab(span);
            div.grab(cancel);
            Smoothbox.open(div);
        });
    });
}

function renderSection(type, params) {
        if ($('sections-content-item_'+type)) {
            var content = $('sections-content-item_'+type).getElement('.profile-section-content');
            var loading = $('sections-content-item_'+type).getElement('.profile-section-loading');
            if (loading) {
                loading.show();
            }
            if (content) {
                content.hide();
            }
        }
        var url = '<?php echo $this->url(array('action' => 'render-section', 'user_id' => $subject->getIdentity()), 'user_general', true)?>';
        var data = {};
        data.type = type;
        data.params = params;
        var request = new Request.HTML({
            url : url,
            data : data,
            onSuccess: function(responseTree, responseElements, responseHTML, responseJavaScript) {
                elements = Elements.from(responseHTML);
                if (elements.length > 0) {
                    if ($('sections-content-item_'+type)) {
                        var content = $('sections-content-item_'+type).getElement('.profile-section');
                        if (content) {
                        	content.empty();
	                        content.adopt(elements);
	                        eval(responseJavaScript);
	                    	addEventToForm();
                        }
                    } 
                }
            }
        });
        request.send();
    }
    
    function removeItemConfirm() {
        if (confirm == true && type != '') {
            var params = {};
            params.remove = true;
            if (item_id > 0) {
            	params.item_id = item_id;
            }
            renderSection(type, params);
            confirm = false;
            type = '';
            item_id = 0;
        }
    }
</script>
