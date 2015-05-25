<div id="business-profile-options">
    <div class="ynbusinesspages-profile-option">
        <div id="like-count-div">
            <span><?php echo $this->business->like_count; ?></span>
            <?php echo $this->translate(array('ynbusiness_like', 'likes', $this->business->like_count), $this->business->like_count); ?>
        </div>
        <?php if($this->business->theme != 'theme3'):?>
        <div id="options-div">
            <span id="print-business">
                <?php $url = $this -> url(array(
                    'module' => 'ynbusinesspages',
                    'controller' => 'index',
                    'action' => 'print',
                    'id' => $this->business->getIdentity()),'ynbusinesspages_general', true)
                ;?>
                <a href="<?php echo $url?>"><i class="fa fa-print"></i> <?php echo $this->translate('Print')?></a>
            </span>
        </div>
        <?php endif;?>
    </div>

    <?php if ($this->business->facebook_link || $this->business->twitter_link) : ?>
    <div id="social-div">
        <?php if ($this->business->facebook_link) : ?>
        <?php $facebookUrl = $this->business->facebook_link;?>
        <?php if((strpos($facebookUrl,'http://') === false) && (strpos($facebookUrl,'https://') === false)) $facebookUrl = 'http://'.$facebookUrl; ?>
            <span id="facebook-link"><a target="_blank" href="<?php echo $facebookUrl?>"><i class="fa fa-facebook"></i><?php echo $this->translate('Our Facebook')?></a></span>
        <?php endif; ?>

        <?php if ($this->business->twitter_link) : ?>
        <?php $twitterUrl = $this->business->twitter_link;?>
        <?php if((strpos($twitterUrl,'http://') === false) && (strpos($twitterUrl,'https://') === false)) $twitterUrl = 'http://'.$twitterUrl; ?>
            <span id="twitter-link"><a target="_blank" href="<?php echo $twitterUrl?>"><i class="fa fa-twitter"></i><?php echo $this->translate('Our Twitter')?></a></span>
        <?php endif; ?>
    </div>
    <?php endif; ?>
</div>
