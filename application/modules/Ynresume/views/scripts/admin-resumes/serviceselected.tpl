<style>
    #to {
        width: 85%;
    }
</style>
<?php
  $this->headScript()
    ->appendFile($this->layout()->staticBaseUrl . 'externals/autocompleter/Observer.js')
    ->appendFile($this->layout()->staticBaseUrl . 'application/modules/Ynresume/externals/scripts/Autocompleter.js')
    ->appendFile($this->layout()->staticBaseUrl . 'application/modules/Ynresume/externals/scripts/Autocompleter.Local.js')
    ->appendFile($this->layout()->staticBaseUrl . 'application/modules/Ynresume/externals/scripts/Autocompleter.Request.js');
?>

<script type="text/javascript">

  window.addEvent('domready', function() {
  	
	  
	  function addResume(name, id , href)
		{
			  //set value to hidden field
			  var hiddenInputField = document.getElementById('toValues');
			  var previousToValues = hiddenInputField.value;
			  
			 if (checkSpanExists(name, id)){
				if (previousToValues==''){
				  document.getElementById('toValues').value = id;
				}
				else {
				  document.getElementById('toValues').value = previousToValues+","+id;
				}
			  }
			  if (checkSpanExists(name, id)){
				 //create block
				 var myElement = new Element("span");
				 myElement.id = "tospan_"+name+"_"+id;;
				 myElement.innerHTML = "<a target='_blank' href="+href+">"+name+"</a>";
			     myElement.innerHTML += " <a href='javascript:void(0);' onclick='this.parentNode.destroy();removeFromToValue(\""+id+"\");'>x</a>"; 
				 
				 document.getElementById('toValues-wrapper').style.height= 'auto';
				 myElement.addClass("tag");
		
				 document.getElementById('toValues-element').appendChild(myElement);
				 
				 this.fireEvent('push');
				 $('to').set('value', "");
				 
				 if( (maxRecipients != 0) && document.getElementById('toValues').value.split(',').length >= maxRecipients ){
					document.getElementById('to').style.display = 'none';
				  }
			}
		}
  	
	  	function checkSpanExists(name, toID){
		      var span_id = "tospan_"+name+"_"+toID;
		      if ($(span_id)){
		        return false;
		      }
		      else return true;
	    } 
  		<?php if(count($this -> ids) > 0 ) :?>
  			$('toValues').set('value', "");
		  	<?php foreach($this -> ids as $resumeID) :?>
		  		<?php $idea = Engine_Api::_() -> getItem('ynresume_resume', $resumeID);?>
		  		<?php if(!empty($idea)):?>
			  		var id = null;
			  		var href = null;
			  		var owner_name = null;
			  		var owner_url = null;
		  			var name = '<?php echo $idea -> getTitle();?>';
		  			id = '<?php echo $idea -> getIdentity()?>';
		  			href = '<?php echo $idea -> getHref() ?>';
		  			addResume(name, id , href);
		  		<?php endif;?>
		  	<?php endforeach;?>
	  	<?php endif;?>
	  
  });
  
  
  // Populate data
  var maxRecipients = 0;
  var to = {
    id : false,
    type : false,
    guid : false,
    title : false
  };
  var isPopulated = false;

  <?php if( !empty($this->isPopulated) && !empty($this->toObject) ): ?>
    isPopulated = true;
    to = {
      id : <?php echo sprintf("%d", $this->toObject->getIdentity()) ?>,
      type : '<?php echo $this->toObject->getType() ?>',
      guid : '<?php echo $this->toObject->getGuid() ?>',
      title : '<?php echo $this->string()->escapeJavascript($this->toObject->getTitle()) ?>'
    };
  <?php endif; ?>
  
  function removeFromToValue(id) 
  {
    // code to change the values in the hidden field to have updated values
    // when recipients are removed.
    var toValues = document.getElementById('toValues').value;
    var toValueArray = toValues.split(",");
    var toValueIndex = "";

    var checkMulti = id.search(/,/);

    // check if we are removing multiple recipients
    if (checkMulti!=-1){
      var recipientsArray = id.split(",");
      for (var i = 0; i < recipientsArray.length; i++){
        removeToValue(recipientsArray[i], toValueArray);
      }
    }
    else{
      removeToValue(id, toValueArray);
    }
	
    // hide the wrapper for usernames if it is empty
    if (document.getElementById('toValues').value==""){
      document.getElementById('toValues-wrapper').style.height = '0';
    }
    
    document.getElementById('to').style.display = 'block';
  }
  
  function removeToValue(id, toValueArray){
    for (var i = 0; i < toValueArray.length; i++){
      if (toValueArray[i]==id) toValueIndex =i;
    }

    toValueArray.splice(toValueIndex, 1);
    document.getElementById('toValues').value = toValueArray.join();
  }

  en4.core.runonce.add(function() {
    if( !isPopulated ) { // NOT POPULATED
      new Autocompleter2.Request.JSON('to', '<?php echo $this->url(array('module' => 'ynresume', 'controller' => 'resumes', 'action' => 'suggest'), 'admin_default', true) ?>', {
        'minLength': 1,
        'delay' : 250,
        'selectMode': 'pick',
        'autocompleteType'  : 'message',
        'multiple': true,
        'className': 'message-autosuggest',
        'filterSubset' : true,
        'tokenFormat' : 'object',
        'tokenValueKey' : 'label',
        'injectChoice': function(token){
          if(token.type == 'user'){
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
          else {
            var choice = new Element('li', {
              'class': 'autocompleter-choices friendlist',
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
          if( (maxRecipients != 0) && (document.getElementById('toValues').value.split(',').length >= maxRecipients) ){
            document.getElementById('to').style.display = 'none';
          }
        }
      });
      
      new Composer.OverText($document.getElementById('to'), {
        'textOverride' : '<?php echo $this->translate('Start typing...') ?>',
        'element' : 'label',
        'isPlainText' : true,
        'positionOptions' : {
          position: ( en4.orientation == 'rtl' ? 'upperRight' : 'upperLeft' ),
          edge: ( en4.orientation == 'rtl' ? 'upperRight' : 'upperLeft' ),
          offset: {
            x: ( en4.orientation == 'rtl' ? -4 : 4 ),
            y: 2
          }
        }
      });

    } else { // POPULATED
      var myElement = new Element("span", {
        'id' : 'tospan' + to.id,
        'class' : 'tag tag_' + to.type,
        'html' :  to.title /* + ' <a href="javascript:void(0);" ' +
                  'onclick="this.parentNode.destroy();removeFromToValue("' + toID + '");">x</a>"' */
      });
      document.getElementById('to-element').appendChild(myElement);
      document.getElementById('to-wrapper').style.height = 'auto';

      // Hide to input?
      document.getElementById('to').style.display = 'none';
      document.getElementById('toValues-wrapper').style.display = 'none';
    }
  });
  
  function removeSubmit()
  {
   	   $('buttons-wrapper').hide();
  }
  
</script>

<?php
    $this->headScript()
      ->appendFile($this->layout()->staticBaseUrl . 'externals/mdetect/mdetect' . ( APPLICATION_ENV != 'development' ? '.min' : '' ) . '.js')
      ->appendFile($this->layout()->staticBaseUrl . 'application/modules/Core/externals/scripts/composer.js');
?>

<h2><?php echo $this->translate("YouNet Resume Plugin") ?></h2>
<?php if( count($this->navigation) ): ?>
    <div class='tabs'>
    <?php
    // Render the menu
    //->setUlClass()
    echo $this->navigation()->menu()->setContainer($this->navigation)->render()
    ?>
    </div>
<?php endif; ?>

<div class="settings">
<?php echo $this->form->render($this) ?>
</div>
