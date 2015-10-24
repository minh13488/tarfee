<?php

/**
 * YouNet Company
 *
 * @category   Application_Extensions
 * @package    Ynvideo
 * @author     YouNet Company
 */
if($this -> video -> parent_type == 'user_playercard'):
$myAve = $totalAve = $this->video->getRating();
/*if(Engine_Api::_() -> user() -> getViewer() -> getIdentity())
{
	$myAve = $this -> video -> getMyAveRating();
}
*/
?>
<div class="tf_video_rating" title="<?php echo number_format($myAve, 2);?>">
    <?php for ($x = 1; $x <= $myAve; $x++): ?>
        <span class="rating_star_generic"><i class="fa fa-star"></i></span>
    <?php endfor; ?>
    <?php if ((round($myAve) - $myAve) > 0): $x ++; ?>
        <span class="rating_star_generic"><i class="fa fa-star-half-o"></i></span>
    <?php endif; ?>
    <?php if ($x <= 5) :?>
        <?php for (; $x <= 5; $x++ ) : ?>
            <span class="rating_star_generic"><i class="fa fa-star-o"></i></span>   
        <?php endfor; ?>
    <?php endif; ?>
    <!--
    <span style="font-size: 10pt">
    	<?php echo $this -> translate("Ave:")." ".number_format($totalAve, 2)?>
    </span>
    -->
</div>
<?php endif;?>