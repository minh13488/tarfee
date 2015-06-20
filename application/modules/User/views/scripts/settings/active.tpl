<?php echo $this->form->setAttrib('id', 'user_form_settings_deactive')->render($this) ?>

<script type="text/javascript">
	window.addEvent('domready', function() {
		$$('#cancel').addEvent('click', function(e) {
			var url = '<?php $this->url(array(), 'user_logout', true)?>';
			this.set('href', url);
			return true;	
		})
	})	
</script>
