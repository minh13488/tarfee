<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="shortcut icon" href="ico/favicon.png">

    <title>Tarfee Inc.</title>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

	<!-- Custom styles for bootstrap -->
    <link href="css/overwrite.css" rel="stylesheet">

	<!-- Custom styles for fontawesome icon -->
    <link href="css/font-awesome.css" rel="stylesheet">

    <!-- Flexslider -->
    <link href="css/flexslider.css" rel="stylesheet">

    <!-- prettyPhoto -->	
	<link href="css/prettyPhoto.css" rel="stylesheet">	

    <!-- animate -->
    <link href="css/animate.css" rel="stylesheet">
	
    <!-- Custom styles for this template -->
    <link href="css/style.css" rel="stylesheet">
	
	<!-- Font for this template -->
    <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700">
	
	<!-- Custom styles for template skin -->
    <link href="skins/default/skin.css" rel="stylesheet">
	
    <!-- Just for debugging purposes. Don't actually copy this line! -->
    <!--[if lt IE 9]><script src="js/ie8-responsive-file-warning.js"></script><![endif]-->

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="js/html5shiv.js"></script>
      <script src="js/respond.min.js"></script>
    <![endif]-->
    
    <!-- load SE css default -->
	<link href="https://www.tarfee.com/application/modules/Core/externals/styles/main.css" rel="stylesheet">
	
	<!-- load SE js default -->
	<script type="text/javascript" src="https://tarfee.com/externals/mootools/mootools-core-1.4.5-full-compat-nc.js"></script>
	<script type="text/javascript" src="https://tarfee.com/externals/mootools/mootools-more-1.4.0.1-full-compat-nc.js"></script>
	<script type="text/javascript" src="https://tarfee.com/externals/chootools/chootools.js"></script>
	<script type="text/javascript" src="https://tarfee.com/application/modules/Core/externals/scripts/core.js"></script>
	<script type="text/javascript" src="https://tarfee.com/application/modules/User/externals/scripts/core.js"></script>
	<script type="text/javascript" src="https://tarfee.com/externals/smoothbox/smoothbox4.js"></script>
	<script type="text/javascript" src="https://tarfee.com/application/modules/SocialConnect/externals/scripts/core.js"></script>

  </head>

  <body>
	<!-- Start home -->
	<section id="home" class="bgslider-wrapper">
		<div id="animated-bg">
			<div id="animated-bg1" class="bg-slider"></div>
			<div id="animated-bg2" class="bg-slider"></div>
			<div id="animated-bg3" class="bg-slider"></div>
		</div>
		<div class="home-contain">
			<div class="container">
				<div class="row wow fadeInDown" data-wow-delay="0.2s">
					<div class="col-md-12">
						<a href="#home" class="logo margin80"><img src="img/tarfee-logo.png" class="img-responsive" alt="" /></a>
					</div>
					<div class="col-md-8 col-md-offset-2 home-headline">
					<?php echo $this->content()->renderWidget('social-connect.login'); ?>
						<h4>Apps landing page</h4>
						<p>Premium html5 landing page for app business</p>
						<form>
							<fieldset class="subscribe-form">
								<input class="subscribe" type="text" placeholder="Enter your email address and get it now">
								<button class="subscribe-button" type="button">Download now</button>
							</fieldset>	
						</form>							
					</div>
				</div>
				
				<div class="row wow fadeInUp" data-wow-delay="0.2s">
					<div class="col-md-12">
						<div class="start-page">
							<a href="#intro" class="btn-scroll">Learn more<br /><i class="fa fa-chevron-down"></i></a>
						</div>
						<div class="sparator-line"></div>
					</div>
				</div>				
			</div>
		</div>
	</section>
	<!-- End home -->

	<!-- Start navigation -->
	<header>
		<div class="navbar navbar-default" role="navigation">
			<div class="container">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</button>
					<a class="navbar-brand" href="#"><img src="img/tarfee-small.png" alt="" /></a>
				</div>
				<div class="collapse navbar-collapse">
					<ul class="nav navbar-nav">
						<li><a href="#home">Home</a></li>
						<li><a href="#intro">Tarfee</a></li>
						<li><a href="#testimoni">How it Works?</a></li>
						<li><a href="#team">Team</a></li>
						<li><a href="#blog">Press</a></li>		
						<li><a href="#contact">Contact</a></li>				
					</ul>
				</div><!--/.nav-collapse -->
			</div>
		</div>
	</header>
	<!-- End navigation -->
	
	<!-- Start introduce -->
	<section id="intro" class="contain colorbg">
		<div class="container">
			<div class="row">
				<div class="col-md-6 wow bounceInDown" data-wow-delay="0.2s">
					<h3 class="headline"><span></span>tarfee</h3>
					<p>
					Tarfee is a social network that connects football talents with football clubs, universities and scouts worldwide. We believe that every football talent deserves a chance to be noticed and recognized.
					</p>
					<p>
					Therefore, we help football talents, as well as football schools and non-profit organizations to promote their students and their organizations.
					</p>
					<p>
					For many young talents around the world, football is not just a sport, it is an opportunity to improve their lives through scholarships or contracts with football clubs. Our goal is to make this happen, by offering football talents, clubs, universities and scouts a platform that will connect them worldwide.
					</p>
					<a href="#testimoni" class="btn btn-default btn-lg btn-scroll">How it Works?</a>					
				</div>
				<div class="col-md-6 wow bounceInDown" data-wow-delay="0.6s">
					<img src="img/player3.png" class="img-responsive pull-right" alt="" />
				</div>
			</div>
		</div>
	</section>
	<!-- End introduce -->
	


	<!-- Start testimoni -->
	<section id="testimoni" class="contain darkbg">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<div class="divider clearfix"></div>
					<h4 class="heading wow flipInX" data-wow-delay="0.2s"><span>How it Works?</span></h4>
				</div>
			</div>
			<div class="row">
				<div class="col-md-8 col-md-offset-2">
					<div class="testimoni-wrapper">
						<i class="fa fa-quote-left icon-title wow rotateIn" data-wow-delay="0.4s"></i>
						<div class="flexslider wow rotateInDownLeft" data-wow-delay="0.4s">
							<ul class="slides">
								<li>
									<div class="testimoni-box">
										<div class="testimoni-avatar">
											<img src="img/tarfee4.jpg" class="img-responsive" alt="" />
										</div>
										<div class="testimoni-text">
											<h3><span>Football</span> Talents</h3>
											<blockquote>
												<p>
												<li>- Upload your best videos to be noticed easily by football scouts, clubs, and universities all over the world</li>
												<li>- Get the best contract or scholarship</li>
												<li>- Apply for tryouts and events organized by football scouts, clubs, and universities</li>
												<li>- Avoid fraud and false offers by checking the ratings and reviews of scouts</li>
												<li>- Connect with other players and professionals to share your experience, learn, and to get advice</li>
												</p>
											</blockquote>
										
										</div>	
									</div>
								</li>
								<li>
									<div class="testimoni-box">
										<div class="testimoni-avatar">
											<img src="img/tarfee1.jpg" class="img-responsive" alt="" />
										</div>
										<div class="testimoni-text">
											<h3><span>Football</span> Schools, NGOs</h3>
											<blockquote>
												<p>
												<li>- Promote your organization and students, and show the world what you stand for!</li>
												<li>- Create player profile for each student and upload his/her videos and information</li>
												<li>- Be engaged with your community, kids, and their parents</li>
												<li>- Create events and tryouts and invite people to join</li>
												<li>- Directly send message your followers</li>
												<li>- Avoid fraud by checking the ratings and reviews of scouts</li>
												</p>
											</blockquote>
											
										</div>	
									</div>
								</li>
								<li>
									<div class="testimoni-box">
										<div class="testimoni-avatar">
											<img src="img/tarfee3.jpg" class="img-responsive" alt="" />
										</div>
										<div class="testimoni-text">
											<h3><span>Football</span> Scouts, Agents</h3>
											<blockquote>
												<p>
												<li>- Access the best football talents all over the world!</li>
												<li>- Find exactly what you are looking for quickly and easily: You can customize your search by filtering by age, country, position, rating, etc.</li>
												<li>- Keep eye on the players you like to follow their improvements</li>
												<li>- Create events & tryouts and invite players to join and submit their profiles</li>
												<li>- Be connected and engage with other professionals around the world</li>
												</p>
											</blockquote>
					
										</div>	
									</div>
								</li>
								<li>
									<div class="testimoni-box">
										<div class="testimoni-avatar">
											<img src="img/tarfee2.jpg" class="img-responsive" alt="" />
										</div>
										<div class="testimoni-text">
											<h3><span>Football</span> Clubs, Universities</h3>
											<blockquote>
												<p>
												<li>- Promote your club, university, or agency in a football dedicated environment, where all football lovers gather</li>
												<li>- Directly access and message your fans and followers</li>
												<li>- Access the best football talents all over the world</li>
												<li>- Create events & tryouts and invite players to join and submit their profiles</li>
												<li>- Conduct business with football professionals world wide</li>
												</p>
											</blockquote>
											
										</div>	
									</div>
								</li>									
							</ul>
						</div>
					</div>
				</div>
			</div>			
		</div>
	</section>
	<!-- End testimoni -->
	

	<!-- Start team -->
	<section id="team" class="contain colorbg">
		<div class="container">
			<div class="row">
				<div class="col-md-10 col-md-offset-1">
					<div class="divider clearfix"></div>
					<h4 class="heading wow flipInX" data-wow-delay="0.2s"><span>Our team</span></h4>			
					<div class="team-wrapper">
						<div class="team">
							<i class="fa fa-group icon-title centered wow rotateIn" data-wow-delay="0.4s"></i>
							<div class="team-left">
								<div class="team-box wow bounceInDown" data-wow-delay="0.4s">
									<div class="team-profile">
										<h6>Simon</h6>
										<p>CEO</p>
										<a href="https://www.facebook.com/rampageforfreedom"><i class="fa fa-facebook icon-social"></i></a>
										<a href="#"><i class="fa fa-twitter icon-social"></i></a>
										<a href="#"><i class="fa fa-linkedin icon-social"></i></a>						
									</div>
									<img src="img/team1.jpg" class="img-responsive" alt="" />
								</div>
								<div class="team-box  wow bounceInDown" data-wow-delay="0.6s">
									<div class="team-profile">
										<h6>Abdallah</h6>
										<p>COO</p>
										<a href="#"><i class="fa fa-facebook icon-social"></i></a>
										<a href="#"><i class="fa fa-twitter icon-social"></i></a>
										<a href="#"><i class="fa fa-linkedin icon-social"></i></a>						
									</div>							
									<img src="img/team3.jpg" class="img-responsive" alt="" />
								</div>
							</div>
							<div class="team-right">
								<div class="team-box wow bounceInDown" data-wow-delay="0.8s">
									<div class="team-profile">
										<h6>Vanessa</h6>
										<p>Relationship Manager</p>
										<a href="#"><i class="fa fa-facebook icon-social"></i></a>
										<a href="#"><i class="fa fa-twitter icon-social"></i></a>
										<a href="#"><i class="fa fa-linkedin icon-social"></i></a>						
									</div>						
									<img src="img/team2.jpg" class="img-responsive" alt="" />
								</div>
								<div class="team-box wow bounceInDown" data-wow-delay="1s">
									<div class="team-profile">
										<h6>Tommy</h6>
										<p>CTO</p>
										<a href="#"><i class="fa fa-facebook icon-social"></i></a>
										<a href="#"><i class="fa fa-twitter icon-social"></i></a>
										<a href="#"><i class="fa fa-linkedin icon-social"></i></a>						
									</div>							
									<img src="img/team/team4.png" class="img-responsive" alt="" />
								</div>
							</div>
						</div>
					</div>				
				</div>
			</div>			
		</div>
	</section>
	<!-- End team -->
	
	<!-- Start blog -->
	<section id="blog" class="contain colorbg">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<div class="divider clearfix"></div>
					<h4 class="heading wow flipInX" data-wow-delay="0.2s"><span>Press</span></h4>
				</div>
			</div>
			<div class="row">
				<div class="col-md-8 col-md-offset-2">
					<div class="blog-wrapper">
						<i class="fa fa-pencil icon-title wow rotateIn" data-wow-delay="0.4s"></i>
						<div class="flexslider wow rotateInDownLeft" data-wow-delay="0.4s">
							<ul class="slides">
								<li>
									<div class="blog-box">
										<div class="blog-thumbls">
											<img src="img/press-2.jpg" class="img-responsive" alt="" />
										</div>
										<div class="artcle">
											<div class="article-head">
												<div class="date-post">
													<span class="date">18</span>
													<span class="mo-year">03-2015</span>
												</div>
												<h5>Entrepreneurship Carleton-Style: TIM Program Leads the Way</h5>

											</div>
											<div class="article-post">
												<p>
												Carleton grad student Osama Abushaban stood before a panel of four judges, all of them experienced entrepreneurs. Dressed in smart casual, he didn’t realize how nervous he was and that he had been holding his breath for quite a while.
												</p>
												<a href="https://carleton.ca/our-stories/stories/entrepreneurship-carleton-style/" target="_blank">Read more...</a>
											</div>
										</div>	
									</div>
								</li>
								<li>
									<div class="blog-box">
										<div class="blog-thumbls">
											<img src="img/press-3.jpg" class="img-responsive" alt="" />
										</div>
										<div class="artcle">
											<div class="article-head">
												<div class="date-post">
													<span class="date">12</span>
													<span class="mo-year">02-2015</span>
												</div>
												<h5>“Go Global, Hire Local” Matches Technology Venture Teams with Talented Professionals</h5>
								
											</div>
											<div class="article-post">
												<p>
												Go Global, Hire Local matches young technology entrepreneurs who wish to define and exploit global opportunities with international professionals who possess appropriate skills.
												</p>
												<a href="http://newsroom.carleton.ca/2015/02/12/go-global-hire-local-matches-technology-venture-teams-talented-professionals-carleton-university/" target="_blank">Read more...</a>
											</div>
										</div>	
									</div>
								</li>
								<li>
									<div class="blog-box">
										<div class="blog-thumbls">
											<img src="img/press-4.jpg" class="img-responsive" alt="" />
										</div>
										<div class="artcle">
											<div class="article-head">
												<div class="date-post">
													<span class="date">24</span>
													<span class="mo-year">12-2014</span>
												</div>
												<h5>Carleton Students Present their Startups to Mr. Wes Nicol</h5>
												
											</div>
											<div class="article-post">
												<p>
												For student entrepreneurs at Carleton University, there are few people who serve as a greater inspiration than successful businessman and generous philanthropist Wes Nicol.
												</p>
												<a href="http://newsroom.carleton.ca/2014/12/24/carleton-students-present-startups-philanthropist-entrepreneur-wes-nicol/" target="_blank">Read more...</a>
											</div>
										</div>	
									</div>
								</li>
								<li>
									<div class="blog-box">
										<div class="blog-thumbls">
											<img src="img/press-5.jpg" class="img-responsive" alt="" />
										</div>
										<div class="artcle">
											<div class="article-head">
												<div class="date-post">
													<span class="date">10</span>
													<span class="mo-year">12-2014</span>
												</div>
												<h5>Carleton Technology Entrepreneurs Show Off Their Startups for Senior Policy Advisers</h5>

											</div>
											<div class="article-post">
												<p>
												Student entrepreneurs in Carleton’s Technology Innovation Management program had a chance to show off their startups during an event attended by senior policy advisers with the Ministry of Research and Innovation.
												</p>
												<a href="http://newsroom.carleton.ca/2014/12/10/carleton-technology-entrepreneurs-show-off-startups-senior-policy-advisers/" target="_blank">Read more...</a>
											</div>
										</div>	
									</div>
								</li>								
							</ul>
						</div>
					</div>
				</div>
			</div>			
		</div>
	</section>
	<!-- End blog -->



	<!-- Start contact -->
	<section id="contact" class="contain colorbg">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<div class="divider clearfix"></div>
					<h4 class="heading wow flipInX" data-wow-delay="0.2s"><span>Contact us</span></h4>
				</div>
			</div>
			<div class="row">
				<div class="col-md-8 col-md-offset-2">
					<div class="contact-wrapper">
						<i class="fa fa-envelope icon-title wow rotateIn" data-wow-delay="0.4s"></i>
						<div class="contact-body wow rotateInDownLeft" data-wow-delay="0.4s">
							<p>
							<strong>Address :</strong> 102 St. Patricks Building, 1125 Colonel By Dr, Ottawa, ON K1S 5B6<br />
							<strong>Phone :</strong> +1(647)500-0800 - <strong>Email :</strong> hello@tarfee.com
							</p>
						</div>
					</div>
					<div class="divider pull-left"></div>
				</div>
			</div>
		</div>	
	</section>
	<!-- End contact -->
	
	<!-- Start footer -->
	<footer>
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<a href="#home" class="totop wow rotateIn btn-scroll" data-wow-delay="0.4s"><i class="fa fa-chevron-up"></i></a>
					<p>
					Thanks for watching
					</p>
					<a href="https://www.facebook.com/TarfeeInc" target="_blank" class="social-network wow bounceInDown" data-wow-delay="0.2s"><i class="fa fa-facebook"></i></a>
					<a href="https://twitter.com/tarfeeinc" target="_blank" class="social-network wow bounceInDown" data-wow-delay="0.4s"><i class="fa fa-twitter"></i></a>
					<!-- <a href="#" class="social-network wow bounceInDown" data-wow-delay="0.6s"><i class="fa fa-google-plus"></i></a> -->
					<!-- <a href="#" class="social-network wow bounceInDown" data-wow-delay="0.8s"><i class="fa fa-linkedin"></i></a> -->
					<!-- <a href="#" class="social-network wow bounceInDown" data-wow-delay="1s"><i class="fa fa-pinterest"></i></a> -->
					<!-- <a href="#" class="social-network wow bounceInDown" data-wow-delay="1.2s"><i class="fa fa-dribbble"></i></a> -->
				</div>
			</div>
		</div>
		<div class="subfooter">
			<p class="copyrigh">2015 &copy; Copyright <a href="www.tarfee.com">Tarfee Inc.</a>. All rights Reserved.</p>
		</div>
	</footer>
	<!-- End footer -->
	
    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>

	<!-- Fixed navigation -->
	<script src="js/navigation/jquery.smooth-scroll.js"></script>	
	<script src="js/navigation/navbar.js"></script>	
	<script src="js/navigation/waypoints.min.js"></script>
	
	<!-- WOW JavaScript -->
	<script src="js/wow.min.js"></script>
	
	<!-- JavaScript bgSlider slider -->
	<script src="js/bgslider/bgSlider.js"></script>		

	<!-- Flexslider -->
	<script src="js/flexslider/jquery.flexslider.js"></script>
    <script src="js/flexslider/setting.js"></script>

	<!-- prettyPhoto -->
	<script src="js/prettyPhoto/jquery.prettyPhoto.js"></script>
	<script src="js/prettyPhoto/setting.js"></script>

	<!-- Contact validation js -->
    <script src="js/validation.js"></script>
	
	<!-- Custom JavaScript -->
	<script src="js/custom.js"></script>
	
  </body>
</html>
