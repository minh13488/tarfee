<h3><?php echo $this -> translate("My campaigns");?></h3>

<?php if(count($this -> ownCampaigns)) :?>
	<?php foreach($this -> ownCampaigns as $campaign) :?>
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
			<?php if($campaign -> isDeletable()) :?>
				<a class="smoothbox" href="<?php echo $this -> url(array('action' => 'delete', 'campaign_id' => $campaign -> getIdentity()), 'tfcampaign_specific' , true);?>"><button><?php echo $this -> translate("remove");?></button></a>
			<?php endif;?>
			<?php if($campaign -> isEditable()) :?>
				<a class="smoothbox" href="<?php echo $this -> url(array('action' => 'edit', 'campaign_id' => $campaign -> getIdentity()), 'tfcampaign_specific' , true);?>"><button><?php echo $this -> translate("edit");?></button></a>
			<?php endif;?>
		<?php endif;?>
		<br/><br/>
	<?php endforeach;?>
<?php endif;?>