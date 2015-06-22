<style>
	.search-form-item {
		display: none;
	}
	
	.search-form-item.active {
		display: block;
	}
	
</style>
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
			<li>
				<input id="sport-all" type="checkbox" name="sport[]" <?php if (in_array('all', $this->sport)) echo 'checked'?> class="type-checkbox" value="all"/>
				<label for="sport-all"><?php echo $this->translate('All Sport')?></label>
			</li>
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

<?php if ($this->viewer()->getIdentity()):?>
<div id="advanced-search-filter" style="display:none; position: absolute">
	<ul id="advanced-search-tab" class="advanced-search-tab">
		<?php if ($this->isPro) :?>
		<li class="search-tab-item"><?php echo $this->translate('Player')?></li>	
		<li class="search-tab-item"><?php echo $this->translate('Professional')?></li>
		<li class="search-tab-item"><?php echo $this->translate('Organization')?></li>
		<li class="search-tab-item"><?php echo $this->translate('Event/Tryout')?></li>
		<?php endif; ?>
		<li class="search-tab-item"><?php echo $this->translate('Campaign')?></li>
	</ul>
	<div class="search-form" id="advsearch-form">
		<?php $url = $this->url(array(),'ynadvsearch_search',true)?>
		
		<?php if ($this->isPro) :?>
		<div class="search-form-item active" id="player-advanced-search">
			<form class="advsearch-form" method="post" action="<?php echo $url?>">
				<input name="advsearch" value="player" type="hidden"/>
				<div class="form-wrapper search-wrapper">
					<label class="form-label search-label" for="player_keyword"><?php echo $this->translate('Keyword')?></label>
					<input type="text" class="form-element search-element" id="player_keyword" name="keyword" />
				</div>
				<div class="form-wrapper search-wrapper">
					<label class="form-label search-label" for="player_sport"><?php echo $this->translate('Sport Type')?></label>
					<select class="form-element search-element" id="player_sport" name="sport">
						<option value="0"></option>
						<?php foreach ($this->sports as $key => $value):?>
						<option value="<?php echo $key?>"><?php echo $value?></option>
						<?php endforeach;?>
					</select>
				</div>
				<div class="form-wrapper search-wrapper">
					<label class="form-label search-label" for="player_position_id"><?php echo $this->translate('Sport Position')?></label>
					<select class="form-element search-element" id="player_position_id" name="position_id">
						<option value="0"></option>
					</select>
				</div>
				<div class="form-wrapper search-wrapper">
					<label class="form-label search-label" for="player_gender"><?php echo $this->translate('Gender')?></label>
					<select class="form-element search-element" id="player_gender" name="gender">
						<option value="0"></option>
						<option value="1"><?php echo $this->translate('Male')?></option>
						<option value="2"><?php echo $this->translate('Female')?></option>
					</select>
				</div>
				<div class="form-wrapper search-wrapper">
					<label class="form-label search-label"><?php echo $this->translate('Age')?></label>
					<select class="form-element search-element" id="player_age_from" name="age_from">
						<option value="0"></option>
						<?php for ($i = 13; $i <= 100; $i++ ) :?>
						<option value="<?php echo $i?>"><?php echo $i.' ('.(date("Y") - $i).')'?></option>	
						<?php endfor;?>
					</select>
					<select class="form-element search-element" id="player_age_to" name="age_to">
						<option value="0"></option>
						<?php for ($i = 13; $i <= 100; $i++ ) :?>
						<option value="<?php echo $i?>"><?php echo $i.' ('.(date("Y") - $i).')'?></option>	
						<?php endfor;?>
					</select>
				</div>
				<div class="form-wrapper search-wrapper">
					<label class="form-label search-label" for="player_relation_id"><?php echo $this->translate('Posted by')?></label>
					<select class="form-element search-element" id="player_relation_id" name="relation_id">
						<option value="0"></option>
						<?php foreach ($this->relations as $key => $value):?>
						<option value="<?php echo $key?>"><?php echo $this->translate($value)?></option>
						<?php endforeach;?>
					</select>
				</div>
				<div class="form-wrapper search-wrapper">
					<label class="form-label search-label"><?php echo $this->translate('Professional Rating')?></label>
					<select class="form-element search-element" id="player_rating_from" name="rating_from">
						<option value="0"></option>
						<?php for ($i = 0; $i <= 5; $i++ ) :?>
						<option value="<?php echo $i?>"><?php echo $i?></option>	
						<?php endfor;?>
					</select>
					<select class="form-element search-element" id="player_rating_to" name="rating_to">
						<option value="0"></option>
						<?php for ($i = 0; $i <= 5; $i++ ) :?>
						<option value="<?php echo $i?>"><?php echo $i?></option>	
						<?php endfor;?>
					</select>
				</div>
				<div class="form-wrapper search-wrapper">
					<label class="form-label search-label" for="player_continent"><?php echo $this->translate('Continent')?></label>
					<select class="form-element search-element continent" id="player_continent" rel="player" name="continent">
						<option value="0"></option>
						<?php foreach ($this->continents as $key => $value):?>
						<option value="<?php echo $key?>"><?php echo $this->translate($value)?></option>
						<?php endforeach;?>
					</select>
				</div>
				<div class="form-wrapper search-wrapper">
					<label class="form-label search-label" for="player_country"><?php echo $this->translate('Country')?></label>
					<select class="form-element search-element country_id" rel="player" id="player_country" name="country_id">
						<option value="0"></option>
					</select>
				</div>
				<div class="form-wrapper search-wrapper">
					<label class="form-label search-label" for="player_province"><?php echo $this->translate('Province/State')?></label>
					<select class="form-element search-element province_id" rel="player" id="player_province" name="province_id">
						<option value="0"></option>
					</select>
				</div>
				<div class="form-wrapper search-wrapper">
					<label class="form-label search-label" for="player_city"><?php echo $this->translate('City')?></label>
					<select class="form-element search-element" id="player_city" name="city_id">
						<option value="0"></option>
					</select>
				</div>
				
				<button type="submit"><?php echo $this->translate('Search')?></button>
			</form>
		</div>
		
		<div class="search-form-item" id="professional-advanced-search">
			<form class="advsearch-form" method="post" action="<?php echo $url?>">
				<input name="advsearch" value="professional" type="hidden"/>
				<div class="form-wrapper search-wrapper">
					<label class="form-label search-label" for="professional_keyword"><?php echo $this->translate('Keyword')?></label>
					<input type="text" class="form-element search-element" id="professional_keyword" name="keyword" />
				</div>
				<div class="form-wrapper search-wrapper">
					<label class="form-label search-label" for="professional_displayname"><?php echo $this->translate('Name')?></label>
					<input type="text" class="form-element search-element" id="professional_displayname" name="displayname" />
				</div>
				
				<!-- <div class="form-wrapper search-wrapper">
					<label class="form-label search-label" for="professional_role"><?php echo $this->translate('Role')?></label>
					<select class="form-element search-element" id="professional_role" name="role">
						<option value="any"><?php echo $this->translate('Any')?></option>
						<option value="scout"><?php echo $this->translate('Scout')?></option>
						<option value="agent"><?php echo $this->translate('Agent')?></option>
						<option value="coach"><?php echo $this->translate('Coach')?></option>
						<option value="journalist"><?php echo $this->translate('Journalist')?></option>
						<option value="admin"><?php echo $this->translate('Admin')?></option>
						<option value="medical"><?php echo $this->translate('Medical')?></option>
					</select>
				</div> -->
				
				<div class="form-wrapper search-wrapper">
					<label class="form-label search-label" for="professional_service"><?php echo $this->translate('Services Offered')?></label>
					<select class="form-element search-element" id="professional_service" name="service">
						<option value="0"></option>
						<?php foreach ($this->services as $service):?>
						<option value="<?php echo $service->service_id?>"><?php echo $this->translate($service->title)?></option>
						<?php endforeach;?>
					</select>
				</div>
				<div class="form-wrapper search-wrapper">
					<label class="form-label search-label" for="professional_continent"><?php echo $this->translate('Continent')?></label>
					<select class="form-element search-element continent" id="professional_continent" rel="professional" name="continent">
						<option value="0"></option>
						<?php foreach ($this->continents as $key => $value):?>
						<option value="<?php echo $key?>"><?php echo $this->translate($value)?></option>
						<?php endforeach;?>
					</select>
				</div>
				<div class="form-wrapper search-wrapper">
					<label class="form-label search-label" for="professional_country"><?php echo $this->translate('Country')?></label>
					<select class="form-element search-element country_id" rel="professional" id="professional_country" name="country_id">
						<option value="0"></option>
					</select>
				</div>
				<div class="form-wrapper search-wrapper">
					<label class="form-label search-label" for="professional_province"><?php echo $this->translate('Province/State')?></label>
					<select class="form-element search-element province_id" rel="professional" id="professional_province" name="province_id">
						<option value="0"></option>
					</select>
				</div>
				<div class="form-wrapper search-wrapper">
					<label class="form-label search-label" for="professional_city"><?php echo $this->translate('City')?></label>
					<select class="form-element search-element" id="professional_city" name="city_id">
						<option value="0"></option>
					</select>
				</div>
				
				<button type="submit"><?php echo $this->translate('Search')?></button>
			</form>
		</div>
		
		<div class="search-form-item" id="organization-advanced-search">
			<form class="advsearch-form" method="post" action="<?php echo $url?>">
				<input name="advsearch" value="organization" type="hidden"/>
				<div class="form-wrapper search-wrapper">
					<label class="form-label search-label" for="organization_keyword"><?php echo $this->translate('Keyword')?></label>
					<input type="text" class="form-element search-element" id="organization_keyword" name="keyword" />
				</div>
				<div class="form-wrapper search-wrapper">
					<label class="form-label search-label" for="organization_displayname"><?php echo $this->translate('Name')?></label>
					<input type="text" class="form-element search-element" id="organization_displayname" name="displayname" />
				</div>
				<div class="form-wrapper search-wrapper">
					<label class="form-label search-label" for="organization_sport"><?php echo $this->translate('Sport Type')?></label>
					<select class="form-element search-element" id="organization_sport" name="sport">
						<option value="0"></option>
						<?php foreach ($this->sports as $key => $value):?>
						<option value="<?php echo $key?>"><?php echo $value?></option>
						<?php endforeach;?>
					</select>
				</div>
				
				<!-- <div class="form-wrapper search-wrapper">
					<label class="form-label search-label" for="organization_type"><?php echo $this->translate('Type')?></label>
					<select class="form-element search-element" id="organization_type" name="organization_type">
						<option value="0"></option>
						<option value="club"><?php echo $this->translate('Club')?></option>
						<option value="agency"><?php echo $this->translate('Agency')?></option>
						<option value="academy"><?php echo $this->translate('Academy')?></option>
						<option value="none_profit"><?php echo $this->translate('Non-for-Profit')?></option>
					</select>
				</div> -->
				
				<div class="form-wrapper search-wrapper">
					<label class="form-label search-label" for="organization_continent"><?php echo $this->translate('Continent')?></label>
					<select class="form-element search-element continent" id="organization_continent" rel="organization" name="continent">
						<option value="0"></option>
						<?php foreach ($this->continents as $key => $value):?>
						<option value="<?php echo $key?>"><?php echo $this->translate($value)?></option>
						<?php endforeach;?>
					</select>
				</div>
				<div class="form-wrapper search-wrapper">
					<label class="form-label search-label" for="organization_country"><?php echo $this->translate('Country')?></label>
					<select class="form-element search-element country_id" rel="organization" id="organization_country" name="country_id">
						<option value="0"></option>
					</select>
				</div>
				<div class="form-wrapper search-wrapper">
					<label class="form-label search-label" for="organization_province"><?php echo $this->translate('Province/State')?></label>
					<select class="form-element search-element province_id" rel="organization" id="organization_province" name="province_id">
						<option value="0"></option>
					</select>
				</div>
				<div class="form-wrapper search-wrapper">
					<label class="form-label search-label" for="organization_city"><?php echo $this->translate('City')?></label>
					<select class="form-element search-element" id="organization_city" name="city_id">
						<option value="0"></option>
					</select>
				</div>
				
				<button type="submit"><?php echo $this->translate('Search')?></button>
			</form>
		</div>
		
		<div class="search-form-item" id="event-advanced-search">
			<form class="advsearch-form" method="post" action="<?php echo $url?>">
				<input name="advsearch" value="event" type="hidden"/>
				<div class="form-wrapper search-wrapper">
					<label class="form-label search-label" for="event_keyword"><?php echo $this->translate('Keyword')?></label>
					<input type="text" class="form-element search-element" id="event_keyword" name="keyword" />
				</div>
				<div class="form-wrapper search-wrapper">
					<label class="form-label search-label" for="event_type"><?php echo $this->translate('Type')?></label>
					<select class="form-element search-element" id="event_type" name="event_type">
						<option value="0"><?php echo $this->translate('Event')?></option>
						<option value="1"><?php echo $this->translate('Tryout')?></option>
					</select>
				</div>
				<div class="form-wrapper search-wrapper">
					<label class="form-label search-label" for="event_sport"><?php echo $this->translate('Sport Type')?></label>
					<select class="form-element search-element" id="event_sport" name="sport">
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
		<?php endif; ?>
		
		<div class="search-form-item" id="campaign-advanced-search">
			<form class="advsearch-form" method="post" action="<?php echo $url?>">
				<input name="advsearch" value="campaign" type="hidden"/>
				<div class="form-wrapper search-wrapper">
					<label class="form-label search-label" for="campaign_keyword"><?php echo $this->translate('Keyword')?></label>
					<input type="text" class="form-element search-element" id="campaign_keyword" name="keyword" />
				</div>
				<div class="form-wrapper search-wrapper">
					<label class="form-label search-label" for="campaign_sport"><?php echo $this->translate('Sport Type')?></label>
					<select class="form-element search-element" id="campaign_sport" name="sport">
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
<?php endif; ?>

<script type="text/javascript" src="<?php echo $this->baseUrl()?>/application/modules/Ynadvsearch/externals/scripts/jquery.tokeninput.js"></script>
<script>
window.addEvent('domready', function() {
	$$('.type-checkbox').addEvent('click', function() {
		var id = this.get('id');
		if (id == 'sport-all') {
			if (this.checked) {
				$$('.type-checkbox').set('checked', true);
			}
		}
		else {
			if (!this.checked) {
				$('sport-all').set('checked', false);
			}
		}
	});
	
	<?php if ($this->viewer()->getIdentity()):?>
	$$('.search-tab-item:first-child').addClass('active');
	$$('.search-form-item:first-child').addClass('active');
	$$('.search-tab-item').addEvent('click', function() {
		var index = $('advanced-search-tab').getChildren('li.search-tab-item').indexOf(this);
		$$('.search-tab-item').removeClass('active');
		this.addClass('active');
		index = index+1;
		$$('.search-form-item').removeClass('active');

		$$('.search-form-item:nth-child('+index+')').addClass('active');
	});
	
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
	
	$$('#player_sport').addEvent('change', function() {
		var id = this.value;
		var type = this.get('rel');
		var makeRequest = new Request({
  			url: "user/player-card/subcategories/cat_id/"+id,
  			onComplete: function (respone){
				respone  = respone.trim();
				$('player_position_id').empty();
				if (respone != "") {
					$('player_position_id').innerHTML = '<option value="0"></option>' + respone;
				}
				else {
					$('player_position_id').innerHTML = '<option value="0"></option>';
				}
  			}
  		})
  		makeRequest.send();
	});
	<?php endif;?>
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
            , resultsLimit: 20
        };
		$('#global_search_field').tokenInput('<?php echo $this->url(array('action'=>'suggest-keywords'), 'ynadvsearch_suggest', true)?>', options);
	
		var form = $('#global_search_form');
		if (form) {
			var button = $('<button />', {
				type: 'button',
				class: 'btn-search-main',
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
					text: '<?php echo $this->translate('filter')?>',
					click: function() {
						var parent = $(this).closest('#search-filter');
						var div_filter = parent.find('#basic-search-filter');
						div_filter.slideToggle(300);
					}
				}).append(
					$('<i />', {
						'class': 'fa fa-angle-down',
					})
				)
			);
			
			$("#basic-search-filter").detach().appendTo(filter);
			form.append(filter);
			
			<?php if ($this->viewer()->getIdentity()):?>
			var advsearch = $('<div />', {
				id: 'search-advsearch',
				'class': 'box-search_form_advsearch'
			}).append(
				$('<span />', {
					'class': 'global_search_form_filter_advanced',
					text: '<?php echo $this->translate('advanced')?>',
					click: function() {
						var parent = $(this).closest('#search-advsearch');
						var div_filter = parent.find('#advanced-search-filter');
						div_filter.slideToggle(300);
					}
				}).append(
					$('<i />', {
						'class': 'fa fa-angle-down',
					})
				)
			);
			
			$("#advanced-search-filter").detach().appendTo(advsearch);
			form.append(advsearch);
			<?php endif;?>
		}
		
		<?php if ($this->viewer()->getIdentity()):?>
		$('#search-filter .global_search_form_filter_advanced').click(function() {
			$('#advanced-search-filter').css('display','none');
		});

		
		$('#search-advsearch .global_search_form_filter_advanced').click(function() {
			$('#basic-search-filter').css('display','none');
		});
		
		<?php endif;?>

	});
})(jQuery);
</script>
