<?php if($this->subject()->photo_id): ?>
  <?php
    $this->headScript()
      ->appendFile($this->layout()->staticBaseUrl . 'externals/moolasso/Lasso.js')
      ->appendFile($this->layout()->staticBaseUrl . 'externals/moolasso/Lasso.Crop.js')
  ?>
  <div>
    <?php echo $this->itemPhoto($this->subject(), 'thumb.main', "", array('id' => 'lassoImg')) ?>
  </div>
  <div style="text-align: center; font-size: 13px; font-weight: bold;" id = 'coordinates_size'>w: 108  h: 108</div>
  <script type="text/javascript">
    var originalSize;
    var lassoCrop;
    
    var lassoSetCoords = function(coords)
    {
      $('coordinates').value =
        coords.x + ':' + coords.y + ':' + coords.w + ':' + coords.h;
       $('coordinates_size').innerHTML = "w: " + coords.w + "  h: " + coords.h;
    }

    var lassoStart = function()
    {
      originalSize = $("lassoImg").getSize();
      lassoCrop = new Lasso.Crop('lassoImg', {
	  ratio : false,
	  preset : [10,10,118,118],
	  min : [70,70],
	  handleSize : 8,
	  opacity : .6,
	  color : '#7389AE',
	  border : '<?php echo $this->layout()->staticBaseUrl . 'externals/moolasso/crop.gif' ?>',
	  onResize : lassoSetCoords,
        bgimage : ''
      });

      $('coordinates').value = 10 + ':' + 10 + ':' + 118+ ':' + 118;
    }

    var lassoEnd = function() {
      lassoCrop.destroy();
      $('CropPhoto').submit();
    }
    jQuery(window).load(function()
    {
		lassoStart();
    });
  </script>
<?php endif; ?>