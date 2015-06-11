<div id="basic-search-filter" style="display:none; position: absolute">
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
	<div id="sport-filter">
		<h3><?php echo $this->translate('Sport')?></h3>
		<ul>
			<?php $sports = Engine_Api::_()->getDbTable('sportcategories', 'user')->getCategoriesLevel1();?>
			<?php foreach($sports as $sport):?>
			<li>
				<input id="sport-<?php echo $sport->getIdentity()?>" type="checkbox" name="sport[]" <?php if (in_array($sport->getIdentity(), $this->sport)) echo 'checked'?> class="type-checkbox" value="<?php echo $sport->getIdentity()?>"/>
				<label for="sport-<?php echo $sport->getIdentity()?>"><?php echo $this->translate($sport->getTitle())?></label>
			</li>
			<?php endforeach; ?>
		</ul>
	</div>
</div>

<div id="advanced-search-filter">
	<input id="radio-none-advanced" type="radio" name="advanced" value="none" checked />
	<label for="radio-none-advanced"><?php echo $this->translate('None')?></label>
	<div id="campaign-advanced-search">
		<input id="radio-campaign-advanced" type="radio" name="campaign" value="none" />
		<label for="radio-campaign-advanced"><?php echo $this->translate('Campaign')?></label>
		<div class="form-wrapper search-wrapper">
			<label class="form-label search-label" for="campaign_keyword"><?php echo $this->translate('Keyword')?></label>
			<input type="text" class="form-element search-element" id="campaign_keyword" name="campaign_keyword" />
		</div>
		
		<div class="form-wrapper search-wrapper">
			<label class="form-label search-label" for="campaign_sport"><?php echo $this->translate('Sport Type')?></label>
			<select type="text" class="form-element search-element" id="campaign_sport" name="campaign_sport">
				<option value="0"></option>
				<?php foreach ($this->sports as $key => $value):?>
				<option value="<?php echo $key?>"><?php echo $value?></option>
				<?php endforeach;?>
			</select>
		</div>
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
            <?php if ($this->max_keywords) :?>
            , tokenLimit: <?php echo $this->max_keywords?>
            <?php endif; ?>
        };
		$('#global_search_field').tokenInput('<?php echo $this->url(array('action'=>'suggest-keywords'), 'ynadvsearch_suggest', true)?>', options);
	
		var form = $('#global_search_form');
		if (form) {
			var button = $('<button />', {
				type: 'button',
				text: '<?php echo $this->translate('Search')?>',
				click: function() {
					var searchForm = $(this).closest('#global_search_form');
					var query = searchForm.find('#global_search_field');
					var input = searchForm.find('#token-input-global_search_field');
					query.val(input.val());
					var values = query.tokenInput('get');
					var arr = [];
					for (var i = 0; i < values.length; i++) {
						arr.push(values[i].id);
					}
					var token = $('<input />', {
						'type' : 'hidden',
						'name' : 'token',
						'value' : arr.join() 
					});
					searchForm.append(token);
					searchForm.submit();
				}	
			});
			form.append(button);
			
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
						'class': 'fa fa-angle-down',
						click: function() {
							var parent = $(this).closest('#search-filter');
							var div_filter = parent.find('#basic-search-filter');
							div_filter.toggle();
						}
					})
				)
			);
			
			$("#basic-search-filter").detach().appendTo(filter);
			form.append(filter);
		}
	});
})(jQuery);
</script>
