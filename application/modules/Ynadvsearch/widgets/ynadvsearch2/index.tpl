<script type="text/javascript" src="<?php echo $this->baseUrl()?>/application/modules/Ynadvsearch/externals/scripts/jquery.tokeninput.js"></script>
<script>
jQuery.noConflict();
(function($) { 
	$(document).ready(function () {
		var options =  {
            theme: "facebook"
            , method: "POST"
            , noResultsText: '<?php echo $this->translate('No keywords found.')?>'
            , searchingText: '<?php echo $this->translate('Searching...')?>'
            , placeholder: '<?php echo $this->translate('Enter keyword')?>'
            , preventDuplicates: true
            , hintText: ''
            , allowFreeTagging: true
            , animateDropdown: false
            , prePopulate : <?php echo json_encode($this->tokens)?>
        };
		$('#global_search_field').tokenInput('<?php echo $this->url(array('action'=>'suggest-keywords'), 'ynadvsearch_suggest', true)?>', options);
	
		var form = $('');
	});
})(jQuery);
</script>