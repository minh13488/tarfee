<ul class = "video-items" id="players-of-week">
<?php foreach( $this->results as $row): ?>
	<li class="video-item">
		<?php
        		echo $this->partial('_players_of_week.tpl', 'ynvideo', array(
        			'video' => $row
        		));
            ?>
	</li>
	<?php $count++;?>
<?php endforeach;?>
</ul>
