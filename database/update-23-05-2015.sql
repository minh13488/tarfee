
INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `order`) VALUES
('core_admin_main_plugins_library', 'user', 'Libraries Settings', '', '{"route":"admin_default","module":"user","controller":"libraries","action":"settings"}', 'core_admin_main_settings', '', 999);

INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `order`) VALUES
('libraries_admin_main_levelsettings', 'user', 'Member Level Settings', '', '{"route":"admin_default","module":"user","controller":"libraries","action":"level"}', 'libraries_admin_main', '', 2),
('libraries_admin_main_globalsettings', 'user', 'Global Settings', '', '{"route":"admin_default","module":"user","controller":"libraries","action":"settings"}', 'libraries_admin_main', '', 1);


INSERT IGNORE INTO `engine4_core_tasks` (`title`, `module`, `plugin`, `timeout`, `processes`, `semaphore`, 
`started_last`, `started_count`, `completed_last`, `completed_count`, `failure_last`, 
`failure_count`, `success_last`, `success_count`) VALUES 
('Video Upload Channel', 'ynvideo', 'Ynvideo_Plugin_Task_Upload', 1800, 1, 0, 0, 0, 0, 0, 
0, 0, 0, 0);

-- HOANGND

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