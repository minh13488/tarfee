INSERT IGNORE INTO `engine4_core_modules` (`name`, `title`, `description`, `version`, `enabled`, `type`) VALUES  ('ynresponsive1', 'YouNet Responsive Simple Module', 'YouNet Responsive Simple Module', '4.04p1', 1, 'extra') ;

INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `order`) VALUES
('core_admin_main_plugins_ynresponsive1', 'ynresponsive1', 'YN - Responsive', '', '{"route":"admin_default","module":"ynresponsive1","controller":"settings"}', 'core_admin_main_plugins', '', 999);

INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES
('ynresponsive1_admin_main_settings', 'ynresponsive1', 'Global Settings', '', '{"route":"admin_default","module":"ynresponsive1","controller":"settings"}', 'ynresponsive1_admin_main', '', 1, 0, 1);
INSERT IGNORE INTO `engine4_core_modules` (`name`, `title`, `description`, `version`, `enabled`, `type`) VALUES  ('ynresponsiveevent', 'YN - Responsive Event Theme', 'YN - Responsive Event Theme', '4.01p4', 1, 'extra') ;

UPDATE `engine4_core_content` SET `name` = 'ynresponsiveevent.event-hot-events' where `name` = 'ynresponsive1.event-hot-events';
UPDATE `engine4_core_content` SET `name` = 'ynresponsiveevent.event-popular-events' where `name` = 'ynresponsive1.event-popular-events';
UPDATE `engine4_core_content` SET `name` = 'ynresponsiveevent.event-top-sponsors' where `name` = 'ynresponsive1.event-top-sponsors';
UPDATE `engine4_core_content` SET `name` = 'ynresponsiveevent.event-mini-menu' where `name` = 'ynresponsive1.event-mini-menu';
UPDATE `engine4_core_content` SET `name` = 'ynresponsiveevent.event-main-menu' where `name` = 'ynresponsive1.event-main-menu';
UPDATE `engine4_core_content` SET `name` = 'ynresponsiveevent.event-footer-about' where `name` = 'ynresponsive1.event-footer-about';
UPDATE `engine4_core_content` SET `name` = 'ynresponsiveevent.event-footer-menu' where `name` = 'ynresponsive1.event-footer-menu';
UPDATE `engine4_core_content` SET `name` = 'ynresponsiveevent.event-slide-events' where `name` = 'ynresponsive1.event-slide-events';
UPDATE `engine4_core_content` SET `name` = 'ynresponsiveevent.event-search-events' where `name` = 'ynresponsive1.event-search-events';
UPDATE `engine4_core_content` SET `name` = 'ynresponsiveevent.event-personalize' where `name` = 'ynresponsive1.event-personalize';
UPDATE `engine4_core_content` SET `name` = 'ynresponsiveevent.event-search-listing' where `name` = 'ynresponsive1.event-search-listing';
UPDATE `engine4_core_content` SET `name` = 'ynresponsiveevent.event-categories' where `name` = 'ynresponsive1.event-categories';

UPDATE `engine4_core_pages` SET `name` = 'ynresponsiveevent_index_event' where `name` = 'ynresponsive1_index_event';

INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `order`) VALUES
('core_admin_main_plugins_ynresponsiveevent', 'ynresponsiveevent', 'YN - Responsive Event', '', '{"route":"admin_default","module":"ynresponsiveevent","controller":"manage-events"}', 'core_admin_main_plugins', '', 999);

DELETE FROM `engine4_core_menuitems` WHERE `name` = 'ynresponsive1_admin_main_manage_events';
DELETE FROM `engine4_core_menuitems` WHERE `name` = 'ynresponsive1_admin_main_manage_sponsors';

INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES
('ynresponsiveevent_admin_main_manage_events', 'ynresponsiveevent', 'Manage Events', '', '{"route":"admin_default","module":"ynresponsiveevent","controller":"manage-events"}', 'ynresponsiveevent_admin_main', '', 1, 0, 1),
('ynresponsiveevent_admin_main_manage_sponsors', 'ynresponsiveevent', 'Manage Sponsors', '', '{"route":"admin_default","module":"ynresponsiveevent","controller":"manage-sponsors"}', 'ynresponsiveevent_admin_main', '', 1, 0, 2);

CREATE TABLE IF NOT EXISTS `engine4_ynresponsive1_events` (
  `event_id` int(11) NOT NULL COMMENT 'reference from event_id',
  `title` varchar(256) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(512) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `photo_id` int(11) NOT NULL DEFAULT '0',
  `starttime` datetime NOT NULL,
  `endtime` datetime NOT NULL,
  `location` varchar(256) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `engine4_ynresponsive1_sponsors` (
  `sponsor_id` int(11) NOT NULL AUTO_INCREMENT,
  `photo_id` int(11) NOT NULL DEFAULT '0',
  `event_id` int(11) NOT NULL COMMENT 'reference from event_id',
  PRIMARY KEY (`sponsor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
INSERT IGNORE INTO `engine4_core_modules` (`name`, `title`, `description`, `version`, `enabled`, `type`) VALUES
('social-connect', 'YN - Social Connect', 'Social Connect allows users quick sign-in, sign-up from Facebook, Twitter, MySpace, Google, Yahoo,...\r\n', '4.0.7', 1, 'extra');

INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `custom`, `order`) VALUES
('core_admin_main_plugins_socialconnect', 'social-connect', 'Social Connect', NULL, '{"route":"admin_default","module":"social-connect","controller":"settings","action":"index"}', 'core_admin_main_plugins', NULL, 0, 1);

-- phpMyAdmin SQL Dump
-- version 3.2.0.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Sep 08, 2010 at 10:30 AM
-- Server version: 5.1.36
-- PHP Version: 5.2.11

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

--
-- Database: `youblue_simple`
--


-- phpMyAdmin SQL Dump
-- version 3.2.0.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Oct 11, 2010 at 03:22 PM
-- Server version: 5.1.36
-- PHP Version: 5.2.11

SET FOREIGN_KEY_CHECKS=0;

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

--
-- Database: `youblue_simple`
--

-- --------------------------------------------------------

--
-- Table structure for table `engine4_socialconnect_agents`
--

CREATE TABLE IF NOT EXISTS `engine4_socialconnect_agents` (
  `agent_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `identity` varchar(128) NOT NULL,
  `service_id` int(11) unsigned NOT NULL,
  `ordering` int(11) unsigned NOT NULL,
  `status` text NOT NULL,
  `login` int(10) NOT NULL DEFAULT '0',
  `data` text NOT NULL,
  `token_data` text NOT NULL,
  `token` varchar(256) NOT NULL,
  `created_time` int(11) NOT NULL,
  `login_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `logout_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`agent_id`),
  KEY `FK_engine4_socialconnect_agents_engine4_users` (`user_id`),
  KEY `FK_engine4_socialconnect_agents_engine4_socialconnect_services` (`service_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;


CREATE TABLE IF NOT EXISTS `engine4_socialconnect_maps` (
  `map_id` int(11) NOT NULL AUTO_INCREMENT,
  `opt_id` int(11) unsigned DEFAULT NULL,
  `service` varchar(128) NOT NULL,
  `field_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`map_id`),
  UNIQUE KEY `service_field_id` (`service`,`field_id`),
  KEY `opt_id` (`opt_id`),
  KEY `field_id` (`field_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=167 ;

--
-- Dumping data for table `engine4_socialconnect_maps`
--

INSERT IGNORE  INTO `engine4_socialconnect_maps` (`map_id`, `opt_id`, `service`, `field_id`) VALUES
(104, NULL, 'twitter', 3),
(105, NULL, 'twitter', 4),
(106, NULL, 'twitter', 8),
(107, NULL, 'twitter', 9),
(108, NULL, 'twitter', 10),
(109, NULL, 'twitter', 11),
(110, NULL, 'twitter', 13),
(111, 31, 'facebook', 3),
(112, 33, 'facebook', 4),
(113, NULL, 'facebook', 8),
(114, NULL, 'facebook', 9),
(115, NULL, 'facebook', 10),
(116, NULL, 'facebook', 11),
(117, NULL, 'facebook', 13),
(118, NULL, 'myspace', 3),
(119, NULL, 'myspace', 4),
(120, NULL, 'myspace', 8),
(121, NULL, 'myspace', 9),
(122, NULL, 'myspace', 10),
(123, NULL, 'myspace', 11),
(124, NULL, 'myspace', 13),
(125, NULL, 'linkedin', 3),
(126, NULL, 'linkedin', 4),
(127, NULL, 'linkedin', 8),
(128, NULL, 'linkedin', 9),
(129, NULL, 'linkedin', 10),
(130, NULL, 'linkedin', 11),
(131, NULL, 'linkedin', 13),
(132, NULL, 'liveid', 3),
(133, NULL, 'liveid', 4),
(139, NULL, 'hyves', 3),
(140, NULL, 'hyves', 4),
(141, NULL, 'hyves', 8),
(142, NULL, 'hyves', 9),
(143, NULL, 'hyves', 10),
(144, NULL, 'hyves', 11),
(145, NULL, 'hyves', 13),
(160, 183, 'openid', 3),
(161, NULL, 'openid', 4),
(162, NULL, 'openid', 8),
(163, NULL, 'openid', 9),
(164, NULL, 'openid', 10),
(165, NULL, 'openid', 11),
(166, NULL, 'openid', 13);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_socialconnect_options`
--

CREATE TABLE IF NOT EXISTS `engine4_socialconnect_options` (
  `opt_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `service` varchar(128) NOT NULL,
  `name` varchar(128) NOT NULL,
  `label` varchar(128) NOT NULL,
  PRIMARY KEY (`opt_id`),
  UNIQUE KEY `service_name` (`service`,`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=420 ;

--
-- Dumping data for table `engine4_socialconnect_options`
--

INSERT IGNORE  INTO `engine4_socialconnect_options` (`opt_id`, `service`, `name`, `label`) VALUES
(1, 'yahoo', 'email', 'Email'),
(2, 'yahoo', 'fullname', 'Full Name'),
(3, 'yahoo', 'nickname', 'Username'),
(4, 'yahoo', 'language', 'Prefered Language'),
(5, 'yahoo', 'country', 'Country'),
(6, 'google', 'country', 'Country'),
(7, 'google', 'email', 'Email'),
(8, 'google', 'firstname', 'First Name'),
(9, 'google', 'lastname', 'Last Name'),
(10, 'google', 'language', 'Language'),
(11, 'myspace', 'aboutme', 'About Me'),
(12, 'myspace', 'age', 'Age'),
(13, 'myspace', 'city', 'City'),
(14, 'myspace', 'country', 'Country'),
(15, 'myspace', 'culture', 'Culture'),
(16, 'myspace', 'gender', 'Gender'),
(17, 'myspace', 'hometown', 'Hometown'),
(18, 'myspace', 'maritalstatus', 'Marital Status'),
(19, 'myspace', 'postalcode', 'Postal Code'),
(20, 'myspace', 'region', 'Region'),
(21, 'myspace', 'type', 'Type'),
(22, 'myspace', 'basicprofile_image', 'Profile Image'),
(23, 'myspace', 'basicprofile_largeImage', 'Large Image'),
(25, 'myspace', 'basicprofile_name', 'Name'),
(26, 'myspace', 'basicprofile_uri', 'Profile Uri'),
(27, 'myspace', 'basicprofile_userId', 'User Id'),
(29, 'facebook', 'id', 'ID'),
(30, 'facebook', 'name', 'Name'),
(31, 'facebook', 'first_name', 'First Name'),
(32, 'facebook', 'middle_name', 'Middle Name'),
(33, 'facebook', 'last_name', 'Last Name'),
(34, 'facebook', 'link', 'Link'),
(35, 'facebook', 'gender', 'Gender'),
(36, 'facebook', 'timezone', 'Timezone'),
(37, 'facebook', 'locale', 'Locale'),
(41, 'twitter', 'notifications', 'Notifications'),
(43, 'twitter', 'description', 'Description'),
(44, 'twitter', 'lang', 'Language'),
(46, 'twitter', 'location', 'Location'),
(49, 'twitter', 'time_zone', 'Timezone'),
(51, 'twitter', 'listed_count', 'Listed Count'),
(52, 'twitter', 'statuses_count', 'Statuses Count'),
(53, 'twitter', 'following', 'Following'),
(56, 'twitter', 'followers_count', 'Followers Count'),
(57, 'twitter', 'profile_image_url', 'Profile Image Url'),
(58, 'twitter', 'contributors_enabled', 'Contributors'),
(62, 'twitter', 'favourites_count', 'Favourites Count'),
(64, 'twitter', 'screen_name', 'Screent Name'),
(66, 'twitter', 'name', 'Name'),
(67, 'twitter', 'friends_count', 'Friends Count'),
(68, 'twitter', 'id', 'User ID'),
(69, 'twitter', 'follow_request_sent', 'Follow Request Sent'),
(70, 'twitter', 'utc_offset', 'UTC Offset'),
(71, 'twitter', 'url', 'URL'),
(75, 'twitter', 'status_retweeted', 'Status Retweeted'),
(77, 'twitter', 'status_favorited', 'Status Favorited'),
(78, 'twitter', 'status_source', 'Status Source'),
(79, 'twitter', 'status_place', 'Status Place'),
(84, 'twitter', 'status_id', 'Status ID'),
(85, 'twitter', 'status_geo', 'Status Geo'),
(86, 'twitter', 'status_text', 'Status Text'),
(128, 'facebook', 'email', 'Email'),
(129, 'linkedin', 'id', 'User Id'),
(130, 'linkedin', 'first_name', 'First Name'),
(131, 'linkedin', 'last_name', 'Last Name'),
(132, 'linkedin', 'headline', 'Headline'),
(133, 'linkedin', 'summary', 'Summary'),
(134, 'linkedin', 'specialties', 'Specialties'),
(135, 'linkedin', 'associations', 'Associations'),
(136, 'linkedin', 'honors', 'honors'),
(138, 'linkedin', 'dob', 'Date of Birth'),
(139, 'linkedin', 'location', 'Location'),
(165, 'flickr', 'username', 'Username'),
(166, 'flickr', 'realname', 'Real Name'),
(167, 'flickr', 'location', 'Location'),
(168, 'flickr', 'photosurls', 'Photo Url'),
(170, 'flickr', 'profileurls', 'Profile Url'),
(181, 'openid', 'nickname', 'nickname'),
(182, 'openid', 'email', 'email'),
(183, 'openid', 'fullname', 'fullname'),
(184, 'openid', 'dob', 'date of birth'),
(185, 'openid', 'gender', 'gender'),
(186, 'openid', 'postcode', 'postcode'),
(187, 'openid', 'country', 'country'),
(188, 'openid', 'language', 'language'),
(189, 'openid', 'timezone', 'timezone'),
(251, 'clavid', 'nickname', 'nickname'),
(252, 'clavid', 'email', 'email'),
(253, 'clavid', 'fullname', 'fullname'),
(254, 'clavid', 'dob', 'date of birth'),
(255, 'clavid', 'gender', 'gender'),
(256, 'clavid', 'postcode', 'postcode'),
(257, 'clavid', 'country', 'country'),
(258, 'clavid', 'language', 'language'),
(259, 'clavid', 'timezone', 'timezone'),
(301, 'launchpad', 'nickname', 'nickname'),
(302, 'launchpad', 'email', 'email'),
(303, 'launchpad', 'fullname', 'fullname'),
(304, 'launchpad', 'dob', 'date of birth'),
(305, 'launchpad', 'gender', 'gender'),
(306, 'launchpad', 'postcode', 'postcode'),
(307, 'launchpad', 'country', 'country'),
(308, 'launchpad', 'language', 'language'),
(309, 'launchpad', 'timezone', 'timezone'),
(311, 'liquidid', 'nickname', 'nickname'),
(312, 'liquidid', 'email', 'email'),
(313, 'liquidid', 'fullname', 'fullname'),
(314, 'liquidid', 'dob', 'date of birth'),
(315, 'liquidid', 'gender', 'gender'),
(316, 'liquidid', 'postcode', 'postcode'),
(317, 'liquidid', 'country', 'country'),
(318, 'liquidid', 'language', 'language'),
(319, 'liquidid', 'timezone', 'timezone'),
(371, 'verisign', 'nickname', 'nickname'),
(372, 'verisign', 'email', 'email'),
(373, 'verisign', 'fullname', 'fullname'),
(374, 'verisign', 'dob', 'date of birth'),
(375, 'verisign', 'gender', 'gender'),
(376, 'verisign', 'postcode', 'postcode'),
(377, 'verisign', 'country', 'country'),
(378, 'verisign', 'language', 'language'),
(379, 'verisign', 'timezone', 'timezone'),
(381, 'wordpress', 'nickname', 'nickname'),
(382, 'wordpress', 'email', 'email'),
(383, 'wordpress', 'fullname', 'fullname'),
(384, 'wordpress', 'dob', 'date of birth'),
(385, 'wordpress', 'gender', 'gender'),
(386, 'wordpress', 'postcode', 'postcode'),
(387, 'wordpress', 'country', 'country'),
(388, 'wordpress', 'language', 'language'),
(389, 'wordpress', 'timezone', 'timezone');

-- --------------------------------------------------------

--
-- Table structure for table `engine4_socialconnect_services`
--

CREATE TABLE IF NOT EXISTS `engine4_socialconnect_services` (
  `service_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8 NOT NULL,
  `title` varchar(128) NOT NULL,
  `privacy` tinyint(1) NOT NULL DEFAULT '0',
  `connect` int(11) NOT NULL DEFAULT '0',
  `protocol` varchar(32) NOT NULL DEFAULT 'openid',
  `mode` varchar(32) NOT NULL DEFAULT 'popup',
  `w` int(11) NOT NULL DEFAULT '800',
  `h` int(11) NOT NULL DEFAULT '450',
  `ordering` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`service_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=ucs2 AUTO_INCREMENT=43 ;

--
-- Dumping data for table `engine4_socialconnect_services`
--

INSERT IGNORE INTO `engine4_socialconnect_services` (`service_id`, `name`, `title`, `privacy`, `connect`, `protocol`, `mode`, `w`, `h`, `ordering`) VALUES
(1, 'facebook', 'Facebook', 1, 1, 'oauth', 'popup', 800, 450, 0),
(2, 'twitter', 'Twitter', 1, 1, 'oauth', 'popup', 800, 450, 0),
(3, 'google', 'Google', 1, 1, 'oauth', 'popup', 800, 450, 0),
(4, 'yahoo', 'Yahoo', 1, 1, 'oauth', 'popup', 800, 450, 0),
(5, 'linkedin', 'Linkedin', 1, 1, 'oauth', 'popup', 800, 450, 0),
(6, 'myspace', 'MySpace', 1, 1, 'oauth', 'popup', 800, 450, 0),
(7, 'live', 'Live', 1, 1, 'oauth', 'popup', 800, 450, 0),
(8, 'launchpad', 'launchpad.net', 1, 0, 'openid', 'popup', 800, 450, 0),
(9, 'flickr', 'Flickr', 1, 1, 'oauth', 'popup', 800, 450, 0),
(10, 'liquidid', 'LiquidID', 1, 0, 'openid', 'popup', 800, 450, 0),
(11, 'wordpress', 'WordPress', 1, 0, 'openid', 'popup', 800, 450, 0),
(12, 'verisign', 'VeriSign', 1, 0, 'openid', 'popup', 800, 450, 0),
(13, 'clavid', 'Clavid', 1, 0, 'openid', 'popup', 800, 450, 0);

-- --------------------------------------------------------

--
-- Constraints for table `engine4_socialconnect_agents`
--
ALTER TABLE `engine4_socialconnect_agents`
  ADD CONSTRAINT `engine4_socialconnect_agents_ibfk_1` FOREIGN KEY (`service_id`) REFERENCES `engine4_socialconnect_services` (`service_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `engine4_socialconnect_agents_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `engine4_users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `engine4_socialconnect_maps`
--
ALTER TABLE `engine4_socialconnect_maps`
  ADD CONSTRAINT `engine4_socialconnect_maps_ibfk_1` FOREIGN KEY (`field_id`) REFERENCES `engine4_user_fields_meta` (`field_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `engine4_socialconnect_maps_ibfk_2` FOREIGN KEY (`opt_id`) REFERENCES `engine4_socialconnect_options` (`opt_id`) ON DELETE SET NULL;

SET FOREIGN_KEY_CHECKS=1;

INSERT IGNORE INTO `engine4_core_mailtemplates` (`type`, `module`, `vars`) VALUES
('socialconnect_autopassword', 'social-connect', '[host],[email],[recipient_title],[recipient_link],[sender_name],[object_link]');


# CREATE TABLE TO STORE AGENTS.
DROP TABLE IF EXISTS engine4_socialconnect_accounts;

CREATE TABLE `engine4_socialconnect_accounts` (
  `account_id` int(11) NOT NULL auto_increment,
  `user_id` int(11) unsigned NOT NULL,
  `identity` varchar(128) NOT NULL,
  `service` varchar(64) NOT NULL,
  `profile` text,
  `returning` TINYINT( 1 ) NOT NULL DEFAULT '0',
  PRIMARY KEY  (`account_id`),
  KEY `identity` (`identity`,`service`)
) ENGINE=InnoDB;

# MIGRAGTE OLD DATA TO NEW TABLE.
INSERT INTO engine4_socialconnect_accounts(account_id,user_id, identity, service)
SELECT a.agent_id AS account_id, a.user_id as user_id,  a.identity as identity, s.name AS service
FROM engine4_socialconnect_agents AS a
LEFT JOIN engine4_socialconnect_services AS s ON ( s.service_id = a.service_id );


# DELETE UNSUPPORTED ANYMORE
DELETE FROM `engine4_socialconnect_services` WHERE `name` IN ('hyves','openidfrance','yiid','chimp','livejournal','clickpass','getopenid','meinguter','blogger','typepad','blogses','myvidoop','claimid','fupei','identity','daum');

# RE UPDATE ORDER
UPDATE `engine4_socialconnect_services` SET `ordering` = `service_id`;


# UPDATE MENU SETTINGS
INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES
( 'core_admin_main_plugins_socialconnect', 'social-connect', 'Social Connect', NULL, '{"route":"admin_default","module":"social-connect","controller":"settings","action":"index"}', 'core_admin_main_plugins', NULL, 1, 0, 1),
('socialconnect_admin_settings', 'social-connect', 'Global Settings', NULL, '{"route":"admin_default","module":"social-connect","controller":"settings","action":"index"}', 'socialconnect_admin', NULL, 1, 0, 1),
('socialconnect_admin_providers', 'social-connect', 'Providers', NULL, '{"route":"admin_default","module":"social-connect","controller":"settings","action":"listing"}', 'socialconnect_admin', NULL, 1, 0, 2);

INSERT IGNORE INTO `engine4_core_mailtemplates` (`type` ,`module` ,`vars`)
VALUES (
'socialconnect_verify_code', 'social-connect', '');
 

DROP TABLE IF EXISTS  engine4_socialconnect_fields;
CREATE TABLE `engine4_socialconnect_fields` (
  `field_id` int(11) NOT NULL auto_increment,
  `opt_id` varchar(32) collate utf8_unicode_ci default NULL,
  `field` varchar(32) collate utf8_unicode_ci default NULL,
  `service` varchar(32) collate utf8_unicode_ci default NULL,
  PRIMARY KEY  (`field_id`)
) ENGINE=InnoDB;

INSERT INTO `engine4_socialconnect_fields` (`opt_id`, `field`, `service`) VALUES
('1_1_3', 'first_name', 'facebook'),
('1_1_4', 'last_name', 'facebook'),
('1_1_5', 'gender', 'facebook'),
('1_1_6', 'birthdate', 'facebook'),
('1_1_8', 'website', 'facebook'),
('1_1_9', 'twitter', 'facebook'),
('1_1_10', 'facebook', 'facebook'),
('1_1_11', 'aim', 'facebook'),
('1_1_13', 'about', 'facebook'),
('1_1_3', 'first_name', 'twitter'),
('1_1_4', 'last_name', 'twitter'),
('1_1_5', 'gender', 'twitter'),
('1_1_6', 'birthdate', 'twitter'),
('1_1_8', 'website', 'twitter'),
('1_1_9', 'twitter', 'twitter'),
('1_1_10', 'facebook', 'twitter'),
('1_1_11', 'aim', 'twitter'),
('1_1_13', 'about', 'twitter'),
('1_1_3', 'first_name', 'linkedin'),
('1_1_4', 'last_name', 'linkedin'),
('1_1_5', 'gender', 'linkedin'),
('1_1_6', 'birthdate', 'linkedin'),
('1_1_8', 'website', 'linkedin'),
('1_1_9', 'twitter', 'linkedin'),
('1_1_10', 'facebook', 'linkedin'),
('1_1_11', 'aim', 'linkedin'),
('1_1_13', 'about', 'linkedin'),
('1_1_3', 'first_name', 'myspace'),
('1_1_4', 'last_name', 'myspace'),
('1_1_5', 'gender', 'myspace'),
('1_1_6', 'birthdate', 'myspace'),
('1_1_8', 'website', 'myspace'),
('1_1_9', 'twitter', 'myspace'),
('1_1_10', 'facebook', 'myspace'),
('1_1_11', 'aim', 'myspace'),
('1_1_13', 'about_me', 'myspace'),
('1_1_3', 'first_name', 'yahoo'),
('1_1_4', 'last_name', 'yahoo'),
('1_1_5', 'gender', 'yahoo'),
('1_1_6', 'birthdate', 'yahoo'),
('1_1_8', 'website', 'yahoo'),
('1_1_9', 'twitter', 'yahoo'),
('1_1_10', 'facebook', 'yahoo'),
('1_1_11', 'aim', 'yahoo'),
('1_1_13', 'about_me', 'yahoo'),
('1_1_3', 'first_name', 'google'),
('1_1_4', 'last_name', 'google'),
('1_1_5', 'gender', 'google'),
('1_1_6', 'birthdate', 'google'),
('1_1_8', 'website', 'google'),
('1_1_9', 'twitter', 'google'),
('1_1_10', 'facebook', 'google'),
('1_1_11', 'aim', 'google'),
('1_1_13', 'about_me', 'google'),
('1_1_3', 'first_name', 'live'),
('1_1_4', 'last_name', 'live'),
('1_1_5', 'gender', 'live'),
('1_1_6', 'birthdate', 'live'),
('1_1_8', 'website', 'live'),
('1_1_9', 'twitter', 'live'),
('1_1_10', 'facebook', 'live'),
('1_1_11', 'aim', 'live'),
('1_1_13', 'about_me', 'live'),
('1_1_3', 'first_name', 'hyves'),
('1_1_4', 'last_name', 'hyves'),
('1_1_5', 'gender', 'hyves'),
('1_1_6', 'birthdate', 'hyves'),
('1_1_8', 'website', 'hyves'),
('1_1_9', 'twitter', 'hyves'),
('1_1_10', 'facebook', 'hyves'),
('1_1_11', 'aim', 'hyves'),
('1_1_13', 'about_me', 'hyves'),
('1_1_3', 'first_name', 'flickr'),
('1_1_4', 'last_name', 'flickr'),
('1_1_5', 'gender', 'flickr'),
('1_1_6', 'birthdate', 'flickr'),
('1_1_8', 'website', 'flickr'),
('1_1_9', 'twitter', 'flickr'),
('1_1_10', 'facebook', 'flickr'),
('1_1_11', 'aim', 'flickr'),
('1_1_13', 'about_me', 'flickr'),
('1_1_3', 'first_name', 'openid'),
('1_1_4', 'last_name', 'openid'),
('1_1_5', 'gender', 'openid'),
('1_1_6', 'birthdate', 'openid'),
('1_1_8', 'website', 'openid'),
('1_1_9', 'twitter', 'openid'),
('1_1_10', 'facebook', 'openid'),
('1_1_11', 'aim', 'openid'),
('1_1_13', 'about_me', 'openid');

--
-- Add the menu item on the menu inside the user setting page 
--
INSERT INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) 
VALUES ('user_settings_linkedAccount', 'social-connect', 'Account Linking', '', '{"route":"default", "module":"social-connect", "controller":"index", "action":"account-linking"}', 'user_settings', '', 1, 0, 999);
INSERT IGNORE INTO `engine4_core_modules` (`name`, `title`, `description`, `version`, `enabled`, `type`) VALUES  ('socialbridge', 'Social Bridge', 'This is Social Bridge plugin.', '4.04p5', 1, 'extra') ;

CREATE TABLE IF NOT EXISTS `engine4_socialbridge_apisettings` (
  `apisetting_id` int(11) NOT NULL AUTO_INCREMENT,
  `api_name` varchar(50) NOT NULL,
  `api_params` text NOT NULL,
  PRIMARY KEY (`apisetting_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `engine4_socialbridge_tokens` (
  `token_id` int(11) NOT NULL auto_increment,
  `access_token` varchar(256) collate utf8_unicode_ci default NULL,
  `secret_token` varchar(256) collate utf8_unicode_ci NOT NULL,
  `user_id` int(11) unsigned NOT NULL default '0',
  `session_id` varchar(32) collate utf8_unicode_ci NOT NULL,
  `service` varchar(32) collate utf8_unicode_ci NOT NULL,
  `uid` varchar(64) collate utf8_unicode_ci NOT NULL,
  `profile` text collate utf8_unicode_ci NOT NULL,
  `creation_date` datetime NOT NULL,
  PRIMARY KEY  (`token_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ;

CREATE TABLE IF NOT EXISTS `engine4_socialbridge_queues` (
  `queue_id` int(11) unsigned NOT NULL auto_increment,
  `token_id`  int(11) NOT NULL,
  `user_id` int(11) unsigned NOT NULL default '0',
  `service` varchar(32) NOT NULL,
  `type` varchar(32) NOT NULL,
  `extra_params` text collate utf8_unicode_ci NOT NULL,
  `link` text collate utf8_unicode_ci NOT NULL,
  `message` text collate utf8_unicode_ci NOT NULL,
  `last_run` datetime NOT NULL,
  `next_run` datetime NOT NULL,
  `priority` tinyint(1) NOT NULL DEFAULT '1',
  `error_id` int(11) NOT NULL default '0',
  `error_message` text collate utf8_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY  (`queue_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE IF NOT EXISTS `engine4_socialbridge_statistics` (
  `statistic_id` int(11) NOT NULL auto_increment,
  `service` varchar(32) NOT NULL,
  `user_id` int(11) unsigned NOT NULL default '0',
  `uid` varchar(64) collate utf8_unicode_ci NOT NULL,
  `invite_of_day` int(20) unsigned NOT NULL default '0',
  `date` date NOT NULL,
  PRIMARY KEY  (`statistic_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ;

INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `order`) VALUES
('core_admin_main_plugins_socialbridge', 'socialbridge', 'Social Brigde', '', '{"route":"admin_default","module":"socialbridge","controller":"settings","action":"fbsetting"}', 'core_admin_main_plugins', '', 999);

INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `order`) VALUES
('socialbridge_admin_main_fbsetting', 'socialbridge', 'Facebook Settings', '', '{"route":"admin_default","module":"socialbridge","controller":"settings","action":"fbsetting"}', 'socialbridge_admin_main', '', 1);

INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `order`) VALUES
('socialbridge_admin_main_twsetting', 'socialbridge', 'Twitter Settings', '', '{"route":"admin_default","module":"socialbridge","controller":"settings","action":"twsetting"}', 'socialbridge_admin_main', '', 2);

INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `order`) VALUES
('socialbridge_admin_main_lisetting', 'socialbridge', 'Linkedin Settings', '', '{"route":"admin_default","module":"socialbridge","controller":"settings","action":"lisetting"}', 'socialbridge_admin_main', '', 3);


INSERT IGNORE INTO `engine4_core_menus` (`name`, `type`, `title`) VALUES
('socialbridge_main', 'standard', 'Social Main Navigation Menu');

INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `order`) VALUES
('user_settings_socialBridge', 'socialbridge', 'Manage Social Settings', '', '{"route":"default", "module":"socialbridge", "controller":"index", "action":"index"}', 'user_settings', '', 999),
('socialbridge_main_connection', 'socialbridge', 'Connections', '', '{"route":"default","module":"socialbridge","controller":"index","action":"index"}', 'socialbridge_main', '', 1);


DROP TABLE IF EXISTS `engine4_profilecompleteness_weights`;
CREATE TABLE `engine4_profilecompleteness_weights` (
  `profileweight_id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `type_id` INT(11) UNSIGNED NOT NULL,
  `field_id` INT(11) UNSIGNED NOT NULL,
  `weight` INT(11) UNSIGNED NOT NULL,
  PRIMARY KEY (`profileweight_id`)
) ENGINE=INNODB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DROP TABLE IF EXISTS `engine4_profilecompleteness_settings`;
CREATE TABLE `engine4_profilecompleteness_settings` (
  `setting_id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `view` TINYINT(1) NOT NULL DEFAULT '1',
  `color` CHAR(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '#FF0000',
  PRIMARY KEY (`setting_id`)
) ENGINE=INNODB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT IGNORE INTO `engine4_profilecompleteness_weights` (`type_id`, `field_id`, `weight`) VALUES (0,0,2);

INSERT IGNORE INTO `engine4_core_content` (`page_id`, `type`, `name`, `parent_content_id`, `order`, `params`, `attribs`) VALUES
(4, 'widget', 'profile-completeness.profile-completeness', 410, 2, '{"title":"Profile Completeness"}', NULL);

INSERT IGNORE INTO `engine4_profilecompleteness_settings` () VALUES ();

INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `order`) VALUES
('core_admin_main_plugins_profilecompleteness', 'profile-completeness', 'Profile Completeness', '', '{"route":"admin_default","module":"profile-completeness","controller":"manage"}', 'core_admin_main_plugins', '', 699),
('profilecompleteness_admin_main_manage', 'profile-completeness', 'Weight Settings', '', '{"route":"admin_default","module":"profile-completeness","controller":"manage"}', 'profilecompleteness_admin_main', '', 1),
('profilecompleteness_admin_main_setting', 'profile-completeness', 'Global Settings', '', '{"route":"admin_default","module":"profile-completeness","controller":"setting"}', 'profilecompleteness_admin_main', '', 2);

INSERT IGNORE INTO `engine4_core_modules` (`name`, `title`, `description`, `version`, `enabled`, `type`) VALUES  ('profile-completeness', 'Profile Completeness', 'displays percent your profile completed', '4.01p2', 1, 'extra') ;


-- 30/05/2015
ALTER TABLE `engine4_user_playercards` ADD `country_id` INT(11) NOT NULL DEFAULT '0' ;