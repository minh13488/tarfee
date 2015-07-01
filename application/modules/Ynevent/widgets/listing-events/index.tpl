<?php if($this -> paginator->getTotalItemCount() > 0 ):?>
<ul id="profile_events_<?php echo $this->identity?>" class="ynevents_profile_tab">
    <?php foreach( $this->paginator as $event ): ?>
    <li>
    	<div class="tf_talk_owner">
            <?php echo $this->htmlLink($event -> getOwner()->getHref(), $this->itemPhoto($event -> getOwner(), 'thumb.icon', $event -> getOwner()->getTitle(), array('style' => 'width: auto')), array('class' => 'members_thumb')) ?>   

            <div class='members_info'>
                <div class='members_name'>
                      <?php echo $this->htmlLink($event -> getOwner()->getHref(), $event -> getOwner() ->getTitle()) ?>
                </div>
                <div class='members_date'>
                  <?php echo $this->timestamp($event->creation_date); ?>
                </div>
            </div>
            <!-- 0 -> Event or 1 => Tryout??-->
            <?php echo $event -> type_id;?>
      </div>
        <div class="ynevents_info">
            <div class="ynevents_title">
                <?php echo $this->htmlLink($event->getHref(), $event->getTitle()) ?>
            </div>
            <div class="ynevent_location">
            	<?php 
            	$countryName = '';
				$provinceName = '';
				$cityName = '';
				if($event ->country_id && $country = Engine_Api::_() -> getItem('user_location', $event ->country_id))
				{
					$countryName = $country -> getTitle();
				}
				if($event ->province_id && $province = Engine_Api::_() -> getItem('user_location', $event ->province_id))
				{
					$provinceName = $province -> getTitle();
				}
				if($event ->city_id && $city = Engine_Api::_() -> getItem('user_location', $event ->city_id))
				{
					$cityName = $city -> getTitle();
				}
				if($cityName) echo $cityName; else echo $provinceName; if($countryName) echo ', '.$countryName;
            	?>
            </div>
            <div class="ynevents_desc">
                <?php echo $this -> viewMore($event -> description)?>
            </div>
        </div>
        <?php 
        if($this -> viewer() -> getIdentity()):?>
            <div class="ynevents_button" id = "ynevent_rsvp_<?php echo $event -> getIdentity()?>">
               <?php echo $this -> action('list-rsvp', 'widget', 'ynevent', array( 'id' => $event -> getIdentity()));?>
            </div>
            <?php $url = $this->url(array('module'=> 'core', 'controller' => 'report', 'action' => 'create', 'subject' => $event ->getGuid()),'default', true);?>
			<div class="yn_video_popup_btn"><a class="smoothbox" href="<?php echo $url?>"><?php echo $this -> translate("Report"); ?></a></div>
        <?php endif;?>
    </li>
    <?php endforeach; ?>
</ul>
  <?php echo $this->paginationControl($this->paginator,null, array("pagination/pagination.tpl","ynblog"));?>
<?php endif; ?>
<?php if($this -> viewer() -> getIdentity()):?>
<script type="text/javascript">
 var tempChange = 0;
   var changeRsvp = function(id, option)
   {
        if (tempChange == 0) 
        {
            tempChange = 1;
            if ($('rsvp_option_' + id + '_' + option)) {
                $('rsvp_option_' + id + '_' + option).innerHTML = '<img width="16" src="application/modules/Yncomment/externals/images/loading.gif" alt="Loading" />';
            }
            var url = en4.core.baseUrl + 'ynevent/widget/rsvp';
            en4.core.request.send(new Request.JSON({
                url : url,
                data : {
                    format : 'json',
                    id : id,
                    option_id: option
                },
                onComplete : function(e) {
                    tempChange = 0;
                }
            }), {
                'element' : $('ynevent_rsvp_' + id)
            });
        }
   }
</script>
<?php endif;?>