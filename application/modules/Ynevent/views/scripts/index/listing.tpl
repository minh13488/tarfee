<?php if( count($this->paginator) > 0 ): ?>
<ul id="profile_events_<?php echo $this->identity?>" class="ynevents_profile_tab">
    <?php foreach( $this->paginator as $event ): ?>

    <li>
        <div class="ynevents_info">
            <div class="ynevents_title">
                <?php echo $this->htmlLink($event->getHref(), $event->getTitle()) ?>
            </div>
            <div class="ynevent_location">
            	<?php 
            	$countryName = '';
				$provinceName = '';
				$cityName = '';
				if($player ->country_id && $country = Engine_Api::_() -> getItem('user_location', $player ->country_id))
				{
					$countryName = $country -> getTitle();
				}
				if($player ->province_id && $province = Engine_Api::_() -> getItem('user_location', $player ->province_id))
				{
					$provinceName = $province -> getTitle();
				}
				if($player ->city_id && $city = Engine_Api::_() -> getItem('user_location', $player ->city_id))
				{
					$cityName = $city -> getTitle();
				}
				if($cityName) echo $cityName; else echo $provinceName; if($countryName) echo ', '.$countryName;
            	?>
            </div>
            <div class="ynevents_desc">
                <?php echo $event->getDescription() ?>
            </div>
        </div>
        <?php 
        if($this -> viewer() -> getIdentity()):
            ?>
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
