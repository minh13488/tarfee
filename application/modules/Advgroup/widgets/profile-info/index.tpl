<div class="club_profile_info_header">
	<div class="club-title">
		<?php echo $this->group->getTitle()?>
	</div>
	<?php if(strtotime($this->group->establish_date)):?>
		<?php 
			$establishDate = $this->group->establish_date;
			if(!empty($establishDate)) :
				$arrEst = explode('-', $establishDate);
				if(count($arrEst) > 2 && $arrEst[0] > 0)
				{
					$arrEstShow[] = $arrEst[0];
					/*if($arrEst[1] > 0)
					{
						$arrEstShow[] = $arrEst[1];
					}
					if($arrEst[1] > 0 && $arrEst[2] > 0)
					{
						$arrEstShow[] = $arrEst[2];
					}*/
				}	
			?>
			<div class="club-establish">
				<?php echo $this -> translate('Est'). '. '. implode(', ', $arrEstShow); ?>
			</div>
		<?php endif;?>
	<?php endif;?>
</div>
<?php if($this -> viewer() -> getIdentity()):?>
	<div class="club_profile_info_left">
		<div id = "club_link_description" class="active"><a href="javascript:;" onclick="switch_info('club_description')"><?php echo $this -> translate("Description") ?></a></div>
		<div id = "club_link_contact_us"><a href="javascript:;" onclick="switch_info('club_contact_us')"><?php echo $this -> translate("Contact info") ?></a></div>
	</div>
	<div class="club_profile_info_right">
		<div class="club_profile_line"></div>
		<div class="club_description" id="club_description">
			<?php echo $this->group->description?>
		</div>
		<div class="club_contact_us" id="club_contact_us">
			<ul>
				<?php if($this ->group -> website):?>
					<li class="club-website">
						<span><?php echo $this -> translate("Official Website")?>:</span>
						<?php $websiteURl = $this ->group -> website;
						if((strpos($websiteURl,'http://') === false) && (strpos($websiteURl,'https://') === false)) $websiteURl = 'http://'.$websiteURl; ?>
						<span>
							<a target="_blank" href="<?php echo $websiteURl?>">
								<?php echo $this ->group -> website?>
							</a>
						</span>
					</li>
				<?php endif;?>
				<li>
					<span><?php echo $this -> translate("Contact")?>:</span>
					<span><?php echo $this -> group -> getOwner();?></span>
				</li>
				<?php if($this ->group -> phone):?>
				<li>
					<span><?php echo $this -> translate("Tel")?>:</span>
					<span><?php echo $this -> group -> phone;?></span>
				</li>
				<?php endif;?>
				<?php if($this ->group -> email):?>
				<li>
					<span><?php echo $this -> translate("Email")?>:</span>
					<span><?php echo $this -> group -> email;?></span>
				</li>
				<?php endif;?>
				<?php if($this ->group -> twitter):?>
					<li>
						<span><?php echo $this -> translate("Twitter")?>:</span>
						<?php $username = $this ->group -> twitter;
						if((strpos($username,'http://') === false) && (strpos($username,'https://') === false)) $URl = 'https://twitter.com/'.$username; ?>
						<span><a target="_blank" href="<?php echo $URl?>"><?php echo "@".$username;?></a></span>
					</li>
				<?php endif;?>
				<?php if($this ->group -> facebook):?>
					<li>
						<span><?php echo $this -> translate("Facebook")?>:</span>
						<?php $username = $this ->group -> facebook;
						if((strpos($username,'http://') === false) && (strpos($username,'https://') === false)) $URl = 'https://www.facebook.com/'.$username; ?>
						<span><a target="_blank"  href="<?php echo $URl?>"><?php echo "@".$username;?></a></span>
					</li>
				<?php endif;?>
				<?php if($this ->group -> google):?>
					<li>
						<span><?php echo $this -> translate("Google")?>:</span>
						<?php $URl = $this ->group -> google;
						if((strpos($URl,'http://') === false) && (strpos($URl,'https://') === false)) $URl = 'https://'.$URl; ?>
						<span><a target="_blank"  href="<?php echo $URl?>"><?php echo $URl;?></a></span>
					</li>
				<?php endif;?>
				<li class="advgroup_widget_cover_custom_fields">
				    <?php if($this->fieldStructure):?>
				     <?php echo $this->fieldValueLoop($this->group, $this->fieldStructure); ?>
				<?php endif;?>
				</li>
				<?php 
				$locationName = array();
				if($this->group ->city_id && $city = Engine_Api::_() -> getItem('user_location', $this->group ->city_id))
				{
					$locationName[] = $city -> getTitle();
				}
				if($this->group ->province_id && $province = Engine_Api::_() -> getItem('user_location', $this->group ->province_id))
				{
					$locationName[] = $province -> getTitle();
				}
				if($this->group ->country_id && $country = Engine_Api::_() -> getItem('user_location', $this->group ->country_id))
				{
					$locationName[] = $country -> getTitle();
				}
				?>
				<li>
					<?php if($locationName) echo join($locationName, ', ')?>
					<?php
						$location = json_decode($this->group->location);
						if($location->{'location'} != "")
						{
							echo " (".$location->{'location'}.")";
						}
					?>
				</li>
				<?php if($this->group -> longitude && $this->group -> latitude):?>
					<li>
						<div id="club_google_map_component" style="height: 500px;"></div>
						<iframe id='club_google_map_component_iframe'style="max-height: 500px; display: none;" > </iframe>
						<script type="text/javascript">
						   var club_view_map_time = function()
					       {
					       		var html =  '<?php echo $this->url(array('action'=>'display-map-view', 'id' => $this->group->getIdentity()), 'group_general') ?>';
					       		document.getElementById('club_google_map_component_iframe').dispose();
					       		var iframe = new IFrame({
					       			id : 'club_google_map_component_iframe',
					       			src: html,
								    styles: {			       
								        'height': '500px',
								        'width' : '100%'
								    },
								});
					       		iframe.inject($('club_google_map_component'));
					       		document.getElementById('club_google_map_component_iframe').style.display = 'block';
					        }
							 en4.core.runonce.add(function()
							 {
								$$('li.tab_layout_advgroup_profile_info a').addEvent('click', function(){
									club_view_map_time();
								});
							});
				    	   club_view_map_time();
						</script>
					</li>
				<?php endif;?>
			</ul>
		</div>
	</div>
	<script type="text/javascript">
		function switch_info(selector) 
		{
		    if (selector === 'club_description') 
		    {
				$('club_contact_us').hide();
				$(selector).show();
				$('club_link_description').addClass('active'); 
				$('club_link_contact_us').removeClass('active'); 
		    } 
		    else 
		    {
		    	$('club_description').hide();
				$(selector).show();
				$('club_link_description').removeClass('active'); 
				$('club_link_contact_us').addClass('active');
				<?php if($this->group -> longitude && $this->group -> latitude):?>
					club_view_map_time();
				<?php endif;?>
		    }
		}
	</script>
<?php else:?>
	<div class="club_profile_info_right" style="border: 0">
		<div class="club_profile_line"></div>
		<div class="club_description" id="club_description">
			<?php echo $this -> translate("message_to_register_request_invite")?>
		</div>
	</div>
<?php endif;?>