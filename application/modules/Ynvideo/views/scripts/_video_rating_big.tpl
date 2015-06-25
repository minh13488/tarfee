<?php

/**
 * YouNet Company
 *
 * @category   Application_Extensions
 * @package    Ynvideo
 * @author     YouNet Company
 */
?>
<div class="tf_video_rating">
    <?php for ($x = 1; $x <= $this->video->getRating(); $x++): ?>
        <span class="rating_star_generic"><i class="fa fa-star"></i></span>
    <?php endfor; ?>
    <?php if ((round($this->video->getRating()) - $this->video->getRating()) > 0): $x ++; ?>
        <span class="rating_star_generic"><i class="fa fa-star-half-o"></i></span>
    <?php endif; ?>
    <?php if ($x <= 5) :?>
        <?php for (; $x <= 5; $x++ ) : ?>
            <span class="rating_star_generic"><i class="fa fa-star-o"></i></span>   
        <?php endfor; ?>
    <?php endif; ?>
    
</div>