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
	<ul id="advanced-search-tab" class="advanced-search-tab">
		<li class="search-tab-item active"><?php echo $this->translate('Event/Tryout')?></li>
		<li class="search-tab-item"><?php echo $this->translate('Campaign')?></li>
	</ul>
	<div class="search-form">
		<?php $url = $this->url(array(),'ynadvsearch_search',true)?>
		
		<div class="search-form-item active" id="event-advanced-search">
			<form class="advsearch-form" method="post" action="<?php echo $url?>">
				<input name="advsearch" value="event" type="hidden"/>
				<div class="form-wrapper search-wrapper">
					<label class="form-label search-label" for="event_keyword"><?php echo $this->translate('Keyword')?></label>
					<input type="text" class="form-element search-element" id="event_keyword" name="keyword" />
				</div>
				<div class="form-wrapper search-wrapper">
					<label class="form-label search-label" for="event_type"><?php echo $this->translate('Type')?></label>
					<select type="text" class="form-element search-element" id="event_type" name="event_type">
						<option value="0"><?php echo $this->translate('Event')?></option>
						<option value="1"><?php echo $this->translate('Tryout')?></option>
					</select>
				</div>
				<div class="form-wrapper search-wrapper">
					<label class="form-label search-label" for="event_sport"><?php echo $this->translate('Sport Type')?></label>
					<select type="text" class="form-element search-element" id="event_sport" name="sport">
						<option value="0"></option>
						<?php foreach ($this->sports as $key => $value):?>
						<option value="<?php echo $key?>"><?php echo $value?></option>
						<?php endforeach;?>
					</select>
				</div>
				<div class="form-wrapper search-wrapper">
					<label class="form-label search-label" for="event_continent"><?php echo $this->translate('Continent')?></label>
					<select class="form-element search-element continent" id="event_continent" rel="event" name="continent">
						<option value="0"></option>
						<?php foreach ($this->continents as $key => $value):?>
						<option value="<?php echo $key?>"><?php echo $this->translate($value)?></option>
						<?php endforeach;?>
					</select>
				</div>
				<div class="form-wrapper search-wrapper">
					<label class="form-label search-label" for="event_country"><?php echo $this->translate('Country')?></label>
					<select class="form-element search-element country_id" rel="event" id="event_country" name="country_id">
						<option value="0"></option>
					</select>
				</div>
				<div class="form-wrapper search-wrapper">
					<label class="form-label search-label" for="event_province"><?php echo $this->translate('Province/State')?></label>
					<select class="form-element search-element province_id" rel="event" id="event_province" name="province_id">
						<option value="0"></option>
					</select>
				</div>
				<div class="form-wrapper search-wrapper">
					<label class="form-label search-label" for="event_city"><?php echo $this->translate('City')?></label>
					<select class="form-element search-element" id="event_city" name="city_id">
						<option value="0"></option>
					</select>
				</div>
				
				<button type="submit"><?php echo $this->translate('Search')?></button>
			</form>
		</div>
		
		<div class="search-form-item" id="campaign-advanced-search">
			<form class="advsearch-form" method="post" action="<?php echo $url?>">
				<input name="advsearch" value="campaign" type="hidden"/>
				<div class="form-wrapper search-wrapper">
					<label class="form-label search-label" for="campaign_keyword"><?php echo $this->translate('Keyword')?></label>
					<input type="text" class="form-element search-element" id="campaign_keyword" name="keyword" />
				</div>
				<div class="form-wrapper search-wrapper">
					<label class="form-label search-label" for="campaign_sport"><?php echo $this->translate('Sport Type')?></label>
					<select type="text" class="form-element search-element" id="campaign_sport" name="sport">
						<option value="0"></option>
						<?php foreach ($this->sports as $key => $value):?>
						<option value="<?php echo $key?>"><?php echo $value?></option>
						<?php endforeach;?>
					</select>
				</div>
				<div class="form-wrapper search-wrapper">
					<label class="form-label search-label" for="campaign_continent"><?php echo $this->translate('Continent')?></label>
					<select class="form-element search-element continent" id="campaign_continent" rel="campaign" name="continent">
						<option value="0"></option>
						<?php foreach ($this->continents as $key => $value):?>
						<option value="<?php echo $key?>"><?php echo $this->translate($value)?></option>
						<?php endforeach;?>
					</select>
				</div>
				<div class="form-wrapper search-wrapper">
					<label class="form-label search-label" for="campaign_country"><?php echo $this->translate('Country')?></label>
					<select class="form-element search-element country_id" rel="campaign" id="campaign_country" name="country_id">
						<option value="0"></option>
					</select>
				</div>
				<div class="form-wrapper search-wrapper">
					<label class="form-label search-label" for="campaign_province"><?php echo $this->translate('Province/State')?></label>
					<select class="form-element search-element province_id" rel="campaign" id="campaign_province" name="province_id">
						<option value="0"></option>
					</select>
				</div>
				<div class="form-wrapper search-wrapper">
					<label class="form-label search-label" for="campaign_city"><?php echo $this->translate('City')?></label>
					<select class="form-element search-element" id="campaign_city" name="city_id">
						<option value="0"></option>
					</select>
				</div>
				
				<button type="submit"><?php echo $this->translate('Search')?></button>
			</form>
		</div>
	</div>
</div>

<script type="text/javascript" src="<?php echo $this->baseUrl()?>/application/modules/Ynadvsearch/externals/scripts/jquery.tokeninput.js"></script>
<script>
window.addEvent('domready', function() {
	$$('.continent').addEvent('change', function() {
		var continent = this.value;
		var type = this.get('rel');
		var makeRequest = new Request({
  			url: "<?php echo $this->url(array('action'=>'get-countries'),'user_general', true)?>/continent/"+continent,
  			onComplete: function (respone){
				respone  = respone.trim();
				var options = Elements.from(respone);
				var option = new Element('option', {
					'value': '0',
					'text': ''
				});
              	if(options.length > 0) {
                	$(type+'_country').empty();
                	$(type+'_country').grab(option);
                	$(type+'_country').adopt(options);
  				}
  				else {
  					$(type+'_country').empty();
  					$(type+'_country').grab(option);
  				}
  			}
  		})
  		makeRequest.send();
	});
	
	$$('.country_id').addEvent('change', function() {
		var id = this.value;
		var type = this.get('rel');
		var makeRequest = new Request({
  			url: "<?php echo $this->url(array('action'=>'sublocations'),'user_general', true)?>/location_id/"+id,
  			onComplete: function (respone){
				respone  = respone.trim();
				var options = Elements.from(respone);
				var option = new Element('option', {
						'value': '0',
						'text': ''
				});
              	if(options.length > 0) {
                	$(type+'_province').empty();
                	$(type+'_province').grab(option);
                	$(type+'_province').adopt(options);
  				}
  				else {
  					$(type+'_province').empty();
  					$(type+'_province').grab(option);
  				}
  			}
  		})
  		makeRequest.send();
	});
	
	$$('.province_id').addEvent('change', function() {
		var id = this.value;
		var type = this.get('rel');
		var makeRequest = new Request({
  			url: "<?php echo $this->url(array('action'=>'sublocations'),'user_general', true)?>/location_id/"+id,
  			onComplete: function (respone){
				respone  = respone.trim();
				var options = Elements.from(respone);
				var option = new Element('option', {
						'value': '0',
						'text': ''
				});
              	if(options.length > 0) {
                	$(type+'_city').empty();
                	$(type+'_city').grab(option);
                	$(type+'_city').adopt(options);
  				}
  				else {
  					$(type+'_city').empty();
  					$(type+'_city').grab(option);
  				}
  			}
  		})
  		makeRequest.send();
	});
});

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
							div_filter.slideToggle(300);
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
