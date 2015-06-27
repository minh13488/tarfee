<ul class="generic_list_widget ynvideo_widget videos_browse ynvideo_frame ynvideo_list" id="group-videos-by-fans">
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