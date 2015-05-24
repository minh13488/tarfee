-- 5.21.2015
ALTER TABLE `engine4_users` ADD `bio` TEXT NULL ;
INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `order`) VALUES
('core_admin_main_plugins_profilesection', 'user', 'Profile Section Settings', '', '{"route":"admin_default","module":"user","controller":"settings", "action":"general"}', 'core_admin_main_settings', '', 999),
('profilesection_admin_settings_general', 'user', 'General Settings', '', '{"route":"admin_default","module":"user","controller":"settings", "action":"general"}', 'profilesection_admin_main', '', 1),
('profilesection_admin_settings_section', 'user', 'Profile Section Settings', '', '{"route":"admin_default","module":"user","controller":"settings", "action":"section"}', 'profilesection_admin_main', '', 2),
('profilesection_admin_settings_service', 'user', 'Manage Services', '', '{"route":"admin_default","module":"user","controller":"services"}', 'profilesection_admin_main', '', 3);

-- insert default permissions of member level settings

-- for profile sections
INSERT IGNORE INTO `engine4_authorization_permissions`
SELECT
    level_id as `level_id`,
    'user' as `type`,
    'bio_max' as `name`,
    3 as `value`,
	0 as `params`
FROM `engine4_authorization_levels` WHERE `type` NOT IN('public');

-- --------------------------------------------------------
--
-- Table structure for table `engine4_user_services`
--

CREATE TABLE IF NOT EXISTS `engine4_user_services` (
`service_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
`title` varchar(255) NOT NULL ,
PRIMARY KEY (`service_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;


INSERT IGNORE INTO `engine4_user_services` (`title`) VALUES
('Coach'),
('Representation'),
('Scout'),
('Scout on behalf'),
('Player Assessment'),
('Medical'),
('Admin & Operations'),
('Sales'),
('Other')
;

-- --------------------------------------------------------
--
-- Table structure for table `engine4_user_offerservices`
--

CREATE TABLE IF NOT EXISTS `engine4_user_offerservices` (
`offerservice_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
`user_id` int(11) unsigned NOT NULL,
`service_id` int(11) unsigned NULL,
`title` varchar(255) NULL,
`location` text NULL,
`longitude` varchar(64) CHARACTER SET utf8 DEFAULT NULL,
`latitude` varchar(64) CHARACTER SET utf8 DEFAULT NULL,
PRIMARY KEY (`offerservice_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- 5.23.2015

ALTER TABLE `engine4_users` ADD `contact_num` TEXT NULL ;
ALTER TABLE `engine4_users` ADD `email1` varchar(256) NULL ;
ALTER TABLE `engine4_users` ADD `email2` varchar(256) NULL ;
ALTER TABLE `engine4_users` ADD `skype` varchar(256) NULL ;
-- --------------------------------------------------------

-- Table structure for table `engine4_user_experiences`
--
CREATE TABLE IF NOT EXISTS `engine4_user_experiences` (
`experience_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
`user_id` int(11) unsigned NOT NULL,
`title` varchar(255) NOT NULL,
`company` varchar(255) NULL,
`description` text NULL,
`start_month` int(11) NULL,
`start_year` YEAR NOT NULL,
`end_month` int(11) NULL,
`end_year` YEAR NULL,
`creation_date` datetime NOT NULL,
`modified_date` datetime DEFAULT NULL,
PRIMARY KEY (`experience_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- Table structure for table `engine4_user_recommendations`
--
CREATE TABLE IF NOT EXISTS `engine4_user_recommendations` (
`recommendation_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
`giver_id` int(11) unsigned NOT NULL,
`receiver_id` varchar(255) NOT NULL,
`content` text NULL,
`approved` tinyint(1) NOT NULL DEFAULT '0',
`request` tinyint(1) NOT NULL DEFAULT '1',
`show` tinyint(1) NOT NULL DEFAULT '1',
`given_date` datetime NULL,
`approved_date` datetime NULL,
`creation_date` datetime NOT NULL,
`modified_date` datetime DEFAULT NULL,
PRIMARY KEY (`recommendation_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- 5.24.2015

--
-- Table structure for table `engine4_user_educations`
--
CREATE TABLE IF NOT EXISTS `engine4_user_educations` (
  `education_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `degree` text NOT NULL,
  `institute` text COLLATE utf8_unicode_ci NOT NULL,
  `attend_from` YEAR NULL,
  `attend_to` YEAR NULL,
  `location` text NULL,
  `longitude` varchar(64) CHARACTER SET utf8 DEFAULT NULL,
  `latitude` varchar(64) CHARACTER SET utf8 DEFAULT NULL,
  `creation_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  PRIMARY KEY (`education_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Table structure for table `engine4_user_archievements`
--
CREATE TABLE IF NOT EXISTS `engine4_user_archievements` (
  `archievement_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `type` enum('trophy','archievement') NOT NULL,
  `photo_id` int(11) NOT NULL DEFAULT '0',
  `title` text NOT NULL,
  `year` YEAR NOT NULL,
  `short_description` text COLLATE utf8_unicode_ci NULL,
  `creation_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  PRIMARY KEY (`archievement_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Table structure for table `engine4_user_licenses`
--
CREATE TABLE IF NOT EXISTS `engine4_user_licenses` (
  `license_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `type` enum('license','certificate') NOT NULL,
  `photo_id` int(11) NOT NULL DEFAULT '0',
  `title` text NOT NULL,
  `number` text NOT NULL,
  `year` YEAR NOT NULL,
  `month` int(11) NULL,
  `creation_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  PRIMARY KEY (`license_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;