<h3><?php echo $this -> translate("Saved campaigns");?></h3>

<?php if(count($this -> saveRows)) :?>
	<?php foreach($this -> saveRows as $saveRow) :?>
		<?php $campaign = Engine_Api::_() -> getItem('tfcampaign_campaign', $saveRow -> campaign_id);?>
		<?php if($campaign) :?>
			<?php echo $campaign;?>
			<?php 
				$startDateObj = null;
				if (!is_null($campaign->start_date) && !empty($campaign->start_date) && $campaign->start_date) 
				{
					$startDateObj = new Zend_Date(strtotime($campaign->start_date));	
				}
				if( $this->viewer() && $this->viewer()->getIdentity() ) {
					$tz = $this->viewer()->timezone;
					if (!is_null($startDateObj))
					{
						$startDateObj->setTimezone($tz);
					}
			    }
			?>
			<?php if(!empty($startDateObj)) :?>
				<?php echo (!is_null($startDateObj)) ?  date('M d Y ', $startDateObj -> getTimestamp()).$this -> translate('at').date(' g:ia', $startDateObj -> getTimestamp()) : ''; ?>
			<?php endif;?>
			<?php echo $this -> translate(array("%s submission", "%s submissions", $campaign -> getTotalSubmission()), $campaign -> getTotalSubmission());?>
			<?php if($this -> viewer() -> getIdentity()) :?>
				<?php $url = $this -> url(array(
				    'module' => 'activity',
				    'controller' => 'index',
				    'action' => 'share',
				    'type' => $campaign -> getType(),
				    'id' => $campaign -> getIdentity(),
				    ),'default', true)
				;?>
				
				<a class="smoothbox" href='<?php echo $url?>'><button><?php echo $this->translate('share')?></button></a>
				<a class="smoothbox" href='<?php echo $this -> url(array('action' => 'remove-save', 'campaign_id' => $campaign -> getIdentity()), 'tfcampaign_general' , true);?>'><button><?php echo $this->translate('remove')?></button></a>
			<?php endif;?>
		<?php endif;?>
	<?php endforeach;?>
<?php endif;?>