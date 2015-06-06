<div id="basic-search-filter">
	<div id="contentype-filter">
		<h3><?php echo $this->translate('Content Type')?></h3>
		<ul>
			<?php $allowType = Engine_Api::_()->ynadvsearch()->getAllowSearchTypes();?>
			<?php foreach($allowType as $key => $value):?>
			<li>
				<input id="type-<?php echo $key?>" type="checkbox" name="type[]" <?php if (in_array($key, $this->type)) echo 'checked'?> class="type-checkbox" value="<?php echo $key?>"/>
				<label for="type-<?php echo $key?>"><?php echo $this->translate($value)?></label>
			</li>
			<?php endforeach; ?>
		</ul>
	</div>
</div>
<script type="text/javascript" src="<?php echo $this->baseUrl()?>/application/modules/Ynadvsearch/externals/scripts/jquery.tokeninput.js"></script>
<script>
jQuery.noConflict();
(function($) { 
	$(document).ready(function () {
		var options =  {
            theme: "facebook"
            , method: "POST"
            , noResultsText: '<?php echo $this->translate('No keywords found.')?>'
            , searchingText: '<?php echo $this->translate('Searching...')?>'
            , placeholder: '<?php echo $this->translate('Enter keyword')?>'
            , preventDuplicates: true
            , hintText: ''
            , allowFreeTagging: true
            , animateDropdown: false
            , prePopulate : <?php echo json_encode($this->tokens)?>
        };
		$('#global_search_field').tokenInput('<?php echo $this->url(array('action'=>'suggest-keywords'), 'ynadvsearch_suggest', true)?>', options);
	
		var form = $('#global_search_form');
		if (form) {
			form.attr('method', 'POST');
			var filter = $('<div />', {
				id: 'search-filter',
				'class': 'box-search_form_filter'
			}).append(
				$('<span />', {
					'class': 'global_search_form_filter_advanced',
					text: '<?php echo $this->translate('filter')?>'
				}).append(
					$('<i />', {
						'class': 'fa fa-angle-down'
					})
				)
			);
			
			$("#basic-search-filter").detach().appendTo(filter);
			form.append(filter);
		}
	});
})(jQuery);
</script>
