<li class="business-operatingHour">
    <?php foreach($this->operatingHours as $hour) :?>
    <div>
        <span class="day"><?php echo ucfirst(substr($hour->day, 0, 3))?></span>
        <span class="time-from"><?php echo $hour->from?></span>
        <span>-</span>
        <span class="time-to"><?php echo $hour->to?></span>
    </div>
    <?php endforeach;?>
</li>