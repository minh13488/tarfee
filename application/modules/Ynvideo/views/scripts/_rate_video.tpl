<?php
	if($this->edit)
	{
		$tableRating = Engine_Api::_() -> getDbTable('reviewRatings','ynvideo');
		$viewer  = Engine_Api::_() -> user() -> getViewer();
	}
?>
<div class="form-wrapper form-ynvideo-rate">
	
	<?php foreach($this -> ratingTypes as $item) :?>
		<div class="form-label">
			<?php echo $this -> translate($item -> title);?>	
		</div>
		<div class="form-element">
				<div id="video_rating_<?php echo $item -> getIdentity();?>" class="rating" onmouseout="set_rating(<?php echo $item -> getIdentity();?>);">
			        <span id="rate_1_<?php echo $item -> getIdentity();?>" class="rating_star_big_generic ynvideo_rating_star_big_generic" onclick="rate(1, <?php echo $item -> getIdentity();?>);" onmouseover="rating_over(1, <?php echo $item -> getIdentity();?>);"></span>
			        <span id="rate_2_<?php echo $item -> getIdentity();?>" class="rating_star_big_generic ynvideo_rating_star_big_generic" onclick="rate(2, <?php echo $item -> getIdentity();?>);" onmouseover="rating_over(2, <?php echo $item -> getIdentity();?>);"></span>
			        <span id="rate_3_<?php echo $item -> getIdentity();?>" class="rating_star_big_generic ynvideo_rating_star_big_generic" onclick="rate(3, <?php echo $item -> getIdentity();?>);" onmouseover="rating_over(3, <?php echo $item -> getIdentity();?>);"></span>
			        <span id="rate_4_<?php echo $item -> getIdentity();?>" class="rating_star_big_generic ynvideo_rating_star_big_generic" onclick="rate(4, <?php echo $item -> getIdentity();?>);" onmouseover="rating_over(4, <?php echo $item -> getIdentity();?>);"></span>
			        <span id="rate_5_<?php echo $item -> getIdentity();?>" class="rating_star_big_generic ynvideo_rating_star_big_generic" onclick="rate(5, <?php echo $item -> getIdentity();?>);" onmouseover="rating_over(5, <?php echo $item -> getIdentity();?>);"></span>
			    </div>
			    <input type="hidden" id="review_rating_<?php echo $item -> getIdentity();?>" name="review_rating_<?php echo $item -> getIdentity();?>" />
		</div>
	<?php endforeach;?>
</div>
<br />

<script type="application/javascript">
    
    var rated = 0;
    var new_rate = 0;
    var is_click = 0;
    
    var set_rating = window.set_rating = function(id) {
    	if(is_click)
    	{
       	 var rating = new_rate;
        }
        else
        {
          if($('review_rating_'+id).get('value'))
         	var rating = $('review_rating_'+id).get('value');
          else
          	var rating = 0;
        }
        for(var x=1; x<=parseInt(rating); x++) {
            $('rate_'+x+'_'+id).set('class', 'ynvideo_rating_star_big_generic ynvideo_rating_star_big');
        }
        for(var x=parseInt(rating)+1; x<=5; x++) {
            $('rate_'+x+'_'+id).set('class', 'ynvideo_rating_star_big_generic ynvideo_rating_star_big_disabled');
        }
        $('review_rating_'+id).set('value', rating);
        is_click = 0;
    }

    var rate = window.rate = function(rating,id) {
        if (!rated) {
            rated = 1;
        }
        is_click = 1;
        new_rate = rating;
        set_rating(id);
    }
    
    var rating_over = window.rating_over = function(rating,id) {
        for(var x=1; x<=5; x++) {
            if(x <= rating) {
                $('rate_'+x+'_'+id).set('class', 'ynvideo_rating_star_big_generic ynvideo_rating_star_big');
            } else {
                $('rate_'+x+'_'+id).set('class', 'ynvideo_rating_star_big_generic ynvideo_rating_star_big_disabled');
            }
        }
    }
    
    <?php foreach($this -> ratingTypes as $item) :?>
   		<?php if($this->edit):?>
   			 is_click = 1;
   			 <?php $row = $tableRating -> getRowRatingThisType($item -> getIdentity(), $this -> video_id, $viewer -> getIdentity(), $this->review->getIdentity());?>
    		 <?php if($row):?>
	    		 new_rate = <?php echo $row -> rating; ?>;
		   		 set_rating(<?php echo $item -> getIdentity()?>);
	   		 <?php else :?>
	   		 	 new_rate = 0;
		   		 set_rating(<?php echo $item -> getIdentity()?>);
	   		 <?php endif;?>
	   		 new_rate = 0;
	   		 is_click =0;
	   	<?php else:?>	 
	   		 set_rating(<?php echo $item -> getIdentity()?>);
	    <?php endif;?>
    <?php endforeach;?>
    
</script>
