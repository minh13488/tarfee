<?php
  $this->headScript()
    ->appendFile($this->layout()->staticBaseUrl . 'externals/autocompleter/Observer.js')
    ->appendFile($this->layout()->staticBaseUrl . 'application/modules/User/externals/scripts/AutocompleterExtend.js')
    ->appendFile($this->layout()->staticBaseUrl . 'application/modules/User/externals/scripts/Autocompleter.Local.js')
    ->appendFile($this->layout()->staticBaseUrl . 'application/modules/User/externals/scripts/Autocompleter.Request.js');
?>
<div id = "show_result" style="display: none; color: red"><?php echo $this -> translate("Your changes have been saved.")?></div>
<input type="text" name="group" id="group" value="" autocomplete="off">
<div id="group_ids-wrapper" class="form-wrapper">
	<div id="group_ids-element" class="form-element">
		<input type="hidden" name="group_ids" value="" id="group_ids">
	</div>
</div>

<button id="preferred-clubs-save-btn"><?php echo $this -> translate('Save');?></button>
<script type="text/javascript">
	 function removeToValue(id, toValueArray, hideLoc){
        for (var i = 0; i < toValueArray.length; i++){
            if (toValueArray[i]==id) toValueIndex =i;
        }

        toValueArray.splice(toValueIndex, 1);
        document.getElementById(hideLoc).value = toValueArray.join();
     }
	
	 function removeFromToValue(id, hideLoc, elem) {
        // code to change the values in the hidden field to have updated values
        // when recipients are removed.
        var toValues = document.getElementById(hideLoc).value;
        var toValueArray = toValues.split(",");
        var toValueIndex = "";

        var checkMulti = id.search(/,/);

        // check if we are removing multiple recipients
        if (checkMulti!=-1){
            var recipientsArray = id.split(",");
            for (var i = 0; i < recipientsArray.length; i++){
                removeToValue(recipientsArray[i], toValueArray, hideLoc);
            }
        }
        else{
            removeToValue(id, toValueArray, hideLoc);
        }

        // hide the wrapper for usernames if it is empty
        if (document.getElementById(hideLoc).value==""){
            document.getElementById(hideLoc+'-wrapper').style.height = '0';
            document.getElementById(hideLoc+'-wrapper').hide();
        }

        document.getElementById(elem).style.display = 'block';
    }
    
    // Populate data
    var maxRecipients = <?php echo $this->max_club?>;
    var to = {
        id : false,
        type : false,
        guid : false,
        title : false
    };
    
    window.addEvent('domready', function() {
    	//add event for submit button
    	$('preferred-clubs-save-btn').addEvent('click', function (){
    		var ids = $('group_ids').get('value');
    		(new Request.JSON({
                'format': 'json',
                'url' : '<?php echo $this->url(array('action' => 'save-preferred-clubs'), 'user_general', true) ?>',
                'data' : {
                    'format' : 'json',
                    'ids' : ids,
                    'user_id': <?php echo $this -> subject() -> getIdentity();?>,
                },
                'onSuccess' : function(responseJSON, responseText)
                {
                	if(responseJSON[0].status == "true") 
                	{
                		$('show_result').style.display = 'block';
                	}
                }
        	})).send();
    	});
    	
        //for owners autocomplete
        new Autocompleter2.Request.JSON('group', '<?php echo $this->url(array('action' => 'suggest-group'), 'user_general', true) ?>', {
            'toValues': 'group_ids',
            'minLength': 1,
            'delay' : 250,
            'autocompleteType' : 'message',
            'multiple': true,
            'className': 'message-autosuggest',
            'filterSubset' : true,
            'tokenFormat' : 'object',
            'tokenValueKey' : 'label',
            'injectChoice': function(token)
            {
            	$('show_result').style.display = 'none';
                if(token.type == 'user')
                {
                    var choice = new Element('li', {
                        'class': 'autocompleter-choices',
                        'html': token.photo,
                        'id':token.label
                    });
                    new Element('div', {
                        'html': this.markQueryValue(token.label),
                        'class': 'autocompleter-choice'
                    }).inject(choice);
                    this.addChoiceEvents(choice).inject(this.choices);
                    choice.store('autocompleteChoice', token);
                }
            },
            onPush : function(){
                if((maxRecipients != 0) && (document.getElementById('group_ids').value.split(',').length >= maxRecipients) ){
                    document.getElementById('group').style.display = 'none';
                }
            }
        });
        <?php foreach ($this->groups as $group) : ?>
        var value = $('group_ids').get('value');
        if(value.trim() == ""){
        	value += '<?php echo $group->getIdentity()?>';
        } else {
        	value += ','+'<?php echo $group->getIdentity()?>';
        }
        $('group_ids').set('value', value);
        
        var myElement = new Element("span", {
            'id' : 'group_ids_tospan_' + '<?php echo $group->getIdentity()?>',
            'class': 'user_tag',
            'html' :  "<a target='_blank' href='<?php echo $group->getHref()?>'>" + '<?php echo $this->itemPhoto($group, 'thumb.icon')?><?php echo $group->getTitle()?>' + "</a> <a class = 'club_preferred_remove' href='javascript:void(0);' onclick='this.parentNode.destroy();removeFromToValue(\"<?php echo $group->getIdentity()?>\", \"group_ids\",\"group\");'>x</a>"
        });
        document.getElementById('group_ids-element').appendChild(myElement);
        document.getElementById('group_ids-wrapper').show();
        document.getElementById('group_ids-wrapper').style.height = 'auto';
        <?php endforeach; ?>
        
        <?php if ($this->max_club > 0 && count($this->groups) >= $this->max_club) :?>
        document.getElementById('sport').style.display = 'none';
        <?php endif; ?>
    });
 </script>
