<div class = 'tarfee_total_items'><?php echo  $this->paginator -> getTotalItemCount()?></div>
<?php
 $title = $this->translate('View All');
 $createTitle = $this -> translate("add more event");
 if($this -> type == 1)
 {
	$createTitle = $this -> translate("add more tryout");
 }
?>
<ul id="profile_events_<?php echo $this->identity?>" class="ynevents_profile_tab">
    <?php foreach( $this->paginator as $event ): ?>

    <li>
        <div class="ynevents_profile_tab_photo">
            <?php echo $this->htmlLink($event, $this->itemPhoto($event, 'thumb.normal')) ?>
        </div>

        <div class="ynevents_profile_tab_info">
            <div class="ynevents_profile_tab_title">
                <?php echo $this->htmlLink($event->getHref(), $event->getTitle()) ?>
            </div>
            <div class="ynevents_profile_tab_desc">
                <?php echo $event->getDescription() ?>
            </div>
            <div class="ynevents_members">
                <?php echo $this->locale()->toDateTime($event->starttime) ?>
            </div>
            <div class="ynevents_profile_tab_members">
                <?php echo $this->translate(array('%s guest', '%s guests', $event->member_count),$this->locale()->toNumber($event->member_count)) ?>
            </div>

        </div>
    </li>

    <?php endforeach; ?>
</ul>

<?php if($this->paginator->getTotalItemCount() > $this->items_per_page):?>
  <?php echo $this->htmlLink($this->url(array(), 'event_general'), $title, array('class' => 'icon_event_viewall')) ?>
<?php endif;?>