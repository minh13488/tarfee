<div class="uiContextualDialogContent">
	<div class="uiYnfbppHovercardStage">
		<div class="uiYnfbppHovercardContent">
			<div><span style="font-weight: bold"><?php echo $this -> translate('Phone')?>: </span><span><?php if($this -> subject -> phone) echo $this -> subject -> phone; else echo $this -> translate('N/A');?></span></div>
			<div><span style="font-weight: bold"><?php echo $this -> translate('Email')?>: </span><span><?php if($this -> subject -> email) echo $this -> subject -> email; else echo $this -> translate('N/A');?></span></div>
		</div>
	</div>
</div>
