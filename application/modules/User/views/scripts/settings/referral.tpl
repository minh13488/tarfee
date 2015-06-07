<h3><?php echo $this->translate('Referral Codes');?></h3>
	<?php $max_referral = $this -> max_referral;?>
<?php if($this -> generate_succ):?>
	<div class="referral_code_success">
		<?php echo $this -> translate("Generate code successfully")?>
	</div>
<?php endif;?>
<div class="tip">
    <span><?php echo $this->translate("Maximum number of allowed referral codes:"); echo ' '.$max_referral;?> </span>
</div> 
<div class="tf_referral_codes_used">
	<span class="referral_lable"><?php echo $this -> translate("Used Codes").' ('.$this -> total_used.')'?></span>
	<span class="referral_codes"><?php echo $this -> used_codes;?></span>
</div>
<div class="tf_referral_codes_available">
	<span class="referral_lable"><?php echo $this -> translate("Available Codes").' ('.$this -> total_available.')'?></span>
	<span class="referral_codes"><?php echo $this -> available_codes;?></span>
</div>
<?php if($this -> totalCodes < $max_referral):?>
<div style="padding-top:20px">
	<form action="" method="post">
		<input type="hidden" name="get_code" />
		<button><?php echo $this -> translate("Get New Code")?></button>
	</form>
</div>
<?php endif;?>
<style type="text/css">
	.referral_code_success
	{
		color: #546d50;
  		background-color: #e3f2e1;
  		border: 1px solid #d2e5cf;
  		margin-bottom: 15px;
  		overflow: hidden;
  		border-radius: 5px;
		font-weight: bold;
		padding: .5em .75em .5em .75em;
	}
	.tf_referral_codes_used
	{
		  border-bottom: 1px solid #CCCCCC;
		  padding-top: 10px;
	}
	.referral_lable
	{
		width: 150px;
		border-right: 1px solid #CCCCCC;
		display: inline-block;
	  	padding-bottom: 10px;
	  	padding-top: 10px;
	}
	.referral_codes
	{
		margin-left: 10px;
	}
</style>