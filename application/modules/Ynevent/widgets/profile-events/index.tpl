<div class = 'tarfee_total_items'><?php echo  $this->paginator -> getTotalItemCount()?></div>
<?php
 $title = $this->translate('View All');
 $createTitle = $this -> translate("add more event");
 if($this -> type == 1)
 {
	$createTitle = $this -> translate("add more tryout");
 }
?>
<?php if($this -> viewer() -> isSelf($this -> subject()) && Engine_Api::_() -> authorization() -> isAllowed('event', null, 'create')):?>
	<div class="tarfee_create_item">
		<a href="<?php echo $this->url(array('action' => 'create'), 'event_general')?>"><?php echo $createTitle;?></a>
	</div>
<?php endif;?>

<ul id="profile_events_<?php echo $this->identity?>" class="ynevents_profile_tab">
    <?php foreach( $this->paginator as $event ): ?>

    <li>
        <div class="ynevents_photo">
            <?php echo $this->htmlLink($event, $this->itemPhoto($event, 'thumb.normal')) ?>
        </div>

        <div class="ynevents_info">
            <div class="ynevents_title">
                <?php echo $this->htmlLink($event->getHref(), $event->getTitle()) ?>
            </div>
            <div class="ynevents_desc">
                <?php echo $event->getDescription() ?>
            </div>

        </div>
        <div class="ynevents_members">
            <?php echo '<i class="fa fa-user"></i> &nbsp;&nbsp;'.$this->translate(array('%s guest', '%s guests', $event->member_count),$this->locale()->toNumber($event->member_count)) ?>
        </div>
        <div class="ynevents_time_place_rating">
            <div class="ynevents_time_place">
                <span>
                    <?php echo $this->locale()->toDate($event->starttime, array('size' => 'long')) ?>
                </span>
                <span>
                    <?php echo $event->address;?>
                </span>
            </div>

            <div class="ynevents_rating">
                
            </div>
        </div>
		<?php 
		if($this -> viewer() -> getIdentity()):
			$row = $event->membership()->getRow($this -> viewer());
			if($row):
				$rsvp = $row -> rsvp;
			?>
	        <div class="ynevents_button" id = "ynevent_rsvp_<?php echo $event -> getIdentity()?>">
	           <?php echo $this -> action('list-rsvp', 'widget', 'ynevent', array( 'id' => $event -> getIdentity()));?>
	        </div>
	        <?php endif;?>
        <?php endif;?>
    </li>
    <?php endforeach; ?>
</ul>
<?php if($this->paginator->getTotalItemCount() > $this->items_per_page):?>
  <?php echo $this->htmlLink($this->url(array(), 'event_general'), $title, array('class' => 'icon_event_viewall')) ?>
<?php endif;?>
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
