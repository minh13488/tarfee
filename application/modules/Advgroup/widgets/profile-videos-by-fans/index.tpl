<ul class="tfvideo-by-fans" id="group-videos-by-fans">
    <?php foreach ($this->paginator as $item): ?>
    <li>
        <?php
        echo $this->partial('_video_listing.tpl', 'advgroup', array(
            'video' => $item,
        ));
        ?>
    </li>
    <?php endforeach; ?>
</ul>