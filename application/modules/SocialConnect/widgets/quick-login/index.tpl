<style>
.ynsc_quick_login
{
	width: <?php echo $this->iconsize;?>px;
	height: <?php echo $this->iconsize;?>px;
	margin-top: <?php echo $this->margintop;?>px;
	margin-right: <?php echo $this->marginright;?>px;
	padding: 4px;
	padding-left: 0px;
}
</style>
<?php
$base_path = $this -> layout() -> staticBaseUrl;

$str = '<form method="post" action="return false;" class="global_form" enctype="application/x-www-form-urlencoded">
   <div>
     <div>
       <span style="float:left;padding-top:7px;letter-spacing:-1px;padding-right:1.0em;font-size:1.3em;font-weight:bold;color: #717171;">' . $this -> translate('Login Using') . ': </span>';
foreach ($this->rs as $o)
{
	$str .= '<a title="' . $o -> title . '" href="javascript: void(0);" ';
	$str .= ' onclick="javascript: sopopup(\'' . $o -> getHref() . '\')"><img src="' . $base_path . 'application/modules/SocialConnect/externals/images/'.strtolower($o -> name).'.png" class="ynsc_quick_login"/></a>';
}
$str .= '</div>
    </div>
  </form>
  <br />';

echo $str;
?>
<script type="text/javascript">
window.addEvent('domready', function()
{
	if($$('.layout_social_connect_quick_login').length > 1)
	{
		$$('.layout_social_connect_quick_login')[1].style.display = 'none';
		if($$('.layout_social_connect_quick_login')[1].getParent('.layout_page_core_error_requireuser'))
			$$('.layout_social_connect_quick_login')[1].getParent('.layout_page_core_error_requireuser').style.display='none';
	}
});
</script>