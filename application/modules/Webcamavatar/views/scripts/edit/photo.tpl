 <?php
    $this->headScript()
      ->appendFile($this->baseUrl().'/application/modules/Webcamavatar/externals/scripts/AC_RunActiveContent.js');
    
    $this->headLink()
    ->appendStylesheet($this->baseUrl() . '/application/modules/Webcamavatar/externals/styles/style.css');      
?>
<script type="text/javascript">
    String.prototype.trim = function() {
        return this.replace(/^\s+|\s+$/g,"");
    }
    cookie_session = document.cookie;
    //cookie_session= cookie_session.replace(";","%26");
    //cookie_session= cookie_session.replace("user_id","%26");
    cookies=cookie_session.split(";");
    for(i=0;i<cookies.length;i++){
        temp = cookies[i].split("=")
        if( temp[0].trim() =="user_id") cookie_id = temp[1];
        if(temp[0].trim()=="user_email")  cookie_email = temp[1];
        if(temp[0].trim()=="user_password") cookie_pass = temp[1];
    }
    AC_FL_RunContent( 'codebase','http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,28,0','width','670','height','458','src','application/modules/Webcamavatar/externals/images/webcam_avatar_se4','quality','high','pluginspage','http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash','movie','./application/modules/Webcamavatar/externals/images/webcam_avatar_se4', "wmode","transparent"); //end AC code
</script>
<noscript><object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,28,0" width="670" height="458">
  <param name="movie" value="application/modules/Webcamavatar/externals/images/webcam_avatar_se4.swf" />
  <param name="quality" value="high" />
  <embed src="application/modules/Webcamavatar/externals/images/webcam_avatar_se4.swf" quality="high" pluginspage="http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash" type="application/x-shockwave-flash" width="670" height="458"></embed>
</object></noscript>
<div class="photo_form">
    <?php echo $this->form->render($this); ?>
</div>
