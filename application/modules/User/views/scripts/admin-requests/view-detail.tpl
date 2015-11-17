<h3><?php echo $this->translate('Request Detail')?></h3>
<div class="profile_fields">
<ul>
	<li>
		<span><?php echo $this->translate('Name')?></span>
		<span><?php echo $this->req->name?></span>
	</li>
	<li>
		<span><?php echo $this->translate('Role')?></span>
		<span><?php echo $this->req->role?></span>
	</li>
	<li>
		<span><?php echo $this->translate('Organization Name')?></span>
		<span><?php echo $this->req->organization?></span>
	</li>
	<li>
		<span><?php echo $this->translate('Email')?></span>
		<span><?php echo $this->req->email?></span>
	</li>
	<li>
		<span><?php echo $this->translate('Country')?></span>
		<span>
			<?php if($this->req ->country_id && $country = Engine_Api::_() -> getItem('user_location', $this->req ->country_id))
			{
				echo $country -> getTitle();
			}
			?>
		</span>
	</li>
	<li>
		<span><?php echo $this->translate('Province/State')?></span>
		<span>
			<?php if($this->req ->province_id && $province = Engine_Api::_() -> getItem('user_location', $this->req ->province_id))
			{
				echo $province -> getTitle();
			}
			?>
		</span>
	</li>
	<li>
		<span><?php echo $this->translate('City')?></span>
		<span>
			<?php if($this->req ->city_id && $city = Engine_Api::_() -> getItem('user_location', $this->req ->city_id))
			{
				echo $city -> getTitle();
			}
			?>
		</span>
	</li>
	<li>
		<span><?php echo $this->translate('Tel')?></span>
		<span><?php echo $this->req->phone?></span>
	</li>
	<li>
		<span><?php echo $this->translate('Message')?></span>
		<span><?php echo $this->req->message?></span>
	</li>
</ul>
</div>
<ul class="action">
	<li>
		<a href="<?php echo $this->url(array('module' => 'user', 'controller' => 'requests', 'action' => 'approve', 'id' => $this->req->getIdentity()), 'admin_default', true)?>"><button><?php echo $this->translate('Approve')?></button></a>
	</li>
	
	<li>
		<a href="<?php echo $this->url(array('module' => 'user', 'controller' => 'requests', 'action' => 'reject', 'id' => $this->req->getIdentity()), 'admin_default', true)?>"><button><?php echo $this->translate('Reject')?></button></a>
	</li>
	
	<li>
		<a href="javascript:void(0)" onclick="parent.Smoothbox.close()"><button><?php echo $this->translate('Close')?></button></a>
	</li>
</ul>

<style type="text/css">
	.action
	{
		margin-top: 15px;
	}
	#global_page_user-admin-requests-view-detail span#global_content_simple .action li
	{
		width: auto;
		padding-right: 10px;
	}
	.profile_fields>ul>li:nth-child(odd) 
	{
	    background: #EFEFEF;
	}
	.profile_fields>ul>li {
	    overflow: hidden;
	    padding: 10px;
	}
	.profile_fields>ul>li>span {
	    display: block;
	    float: left;
	    margin-right: 15px;
	    overflow: hidden;
	    width: 130px;
	}
	.profile_fields>ul>li>span+span {
	    display: block;
	    float: left;
	    min-width: 0;
	    overflow: hidden;
	    width: 300px;
	}
</style>
