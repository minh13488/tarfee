CREATE TABLE IF NOT EXISTS `engine4_user_signup1` (
`signup_id` int(11) unsigned NOT NULL,
  `class` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `order` smallint(6) NOT NULL DEFAULT '999',
  `enable` smallint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY  (`signup_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `engine4_user_signup1`
--

INSERT INTO `engine4_user_signup1` (`signup_id`, `class`, `order`, `enable`) VALUES
(1, 'User_Plugin_Signup1_Step1', 1, 1),
(2, 'User_Plugin_Signup1_Step2', 2, 1),
(3, 'User_Plugin_Signup1_Account', 3, 1),
(4, 'User_Plugin_Signup1_Fields', 4, 1),
(5, 'Payment_Plugin_Signup1_Subscription', 5, 1);




ALTER TABLE `engine4_group_groups` ADD `verified` TINYINT(1) NOT NULL DEFAULT '0' AFTER `approval`;
ALTER TABLE `engine4_group_groups` ADD `requested` TINYINT(1) NOT NULL DEFAULT '0' AFTER `verified`;

INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `order`) VALUES
('advgroup_admin_main_request', 'advgroup', 'Verification Requests', '', '{"route":"admin_default","module":"advgroup","controller":"request"}', 'advgroup_admin_main', '', 4);

--
-- Table structure for table `engine4_group_requests`
--

CREATE TABLE IF NOT EXISTS `engine4_group_requests` (
  `request_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `group_id` int(11) unsigned NOT NULL DEFAULT '0',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0',
  `description` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `creation_date` datetime NOT NULL,
  `modified_date` datetime DEFAULT NULL,
  PRIMARY KEY (`request_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ;