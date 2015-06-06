-- --------------------------------------------------------

--
-- Change table permissions (change length of column type)
--

ALTER TABLE `engine4_authorization_permissions` MODIFY `type` VARCHAR(64);
ALTER TABLE `engine4_activity_notifications` MODIFY  `type` VARCHAR(64) NOT NULL;
ALTER TABLE `engine4_activity_notificationtypes` MODIFY  `type` VARCHAR(64) NOT NULL;
ALTER TABLE `engine4_activity_actiontypes` CHANGE  `type`  `type` VARCHAR( 64 ) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL ;
ALTER TABLE `engine4_activity_actions` CHANGE  `type`  `type` VARCHAR( 64 ) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL ;
ALTER TABLE `engine4_activity_stream` CHANGE  `type`  `type` VARCHAR( 64 ) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL ;


-- --------------------------------------------------------

--
-- Table structure for table `engine4_tfcampaign_campaigns`
--

CREATE TABLE IF NOT EXISTS `engine4_tfcampaign_campaigns` (
`campaign_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
`user_id` int(11) NOT NULL,
`photo_id` int(11) NOT NULL DEFAULT '0',
`title` text COLLATE utf8_unicode_ci NOT NULL,
`description` text COLLATE utf8_unicode_ci NOT NULL,
`creation_date` datetime NOT NULL,
`modified_date` datetime NOT NULL,
`start_date` datetime NOT NULL,
`end_date` datetime NOT NULL,

`from_age` varchar(16) NULL,
`to_age` varchar(16) NULL,
`gender` varchar(16) NULL,
`category_id` int(11) unsigned NOT NULL default '0',
`position_id` int(11) unsigned NOT NULL default '0',
`referred_foot` tinyint(1) NOT NULL,
`country_id` int(11) unsigned NOT NULL default '0',
`province_id` int(11) unsigned NOT NULL default '0',
`city_id` int(11) unsigned NOT NULL default '0',
`photo_required` tinyint(1) NOT NULL default '0',
`video_required` tinyint(1) NOT NULL default '0',
`deleted` tinyint(1) NOT NULL default '0',

PRIMARY KEY (`campaign_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_tfcampaign_reasons`
--

CREATE TABLE IF NOT EXISTS `engine4_tfcampaign_reasons` (
  `reason_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` text NOT NULL,
  PRIMARY KEY (`reason_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- --------------------------------------------------------

--
-- Insert back-end menu items
--

INSERT IGNORE INTO `engine4_core_menus` (`name`, `type`, `title`, `order`) VALUES
('tfcampaign_main', 'standard', 'Campaign Main Navigation Menu', 999);

INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `order`) VALUES
('core_admin_main_plugins_tfcampaign', 'tfcampaign', 'Campaigns', '', '{"route":"admin_default","module":"tfcampaign","controller":"settings", "action":"global"}', 'core_admin_main_plugins', '', 999),
('tfcampaign_admin_settings_global', 'tfcampaign', 'Global Settings', '', '{"route":"admin_default","module":"tfcampaign","controller":"settings", "action":"global"}', 'tfcampaign_admin_main', '', 1),
('tfcampaign_admin_settings_level', 'tfcampaign', 'Member Level Settings', '', '{"route":"admin_default","module":"tfcampaign","controller":"settings", "action":"level"}', 'tfcampaign_admin_main', '', 2),
('tfcampaign_admin_reasons', 'tfcampaign', 'Reasons', '', '{"route":"admin_default","module":"tfcampaign","controller":"reasons", "action":"index"}', 'tfcampaign_admin_main', '', 3);

INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `order`) VALUES
('core_main_tfcampaign', 'tfcampaign', 'Campaigns', '', '{"route":"tfcampaign_general"}', 'core_main', '', 999),
('tfcampaign_main_browse', 'tfcampaign', 'Browse Campaigns', '', '{"route":"tfcampaign_general","action":"browse"}', 'tfcampaign_main', '', 2),
('tfcampaign_main_manage', 'tfcampaign', 'My Campaigns', 'Tfcampaign_Plugin_Menus', '{"route":"tfcampaign_general","action":"manage"}', 'tfcampaign_main', '', 3),
('tfcampaign_main_create', 'tfcampaign', 'Create New Campaign', 'Tfcampaign_Plugin_Menus', '{"route":tfcampaign_general","action":"create"}', 'tfcampaign_main', '', 4);


-- --------------------------------------------------------

-- set default permissions for level settings of listing

-- ALL
INSERT IGNORE INTO `engine4_authorization_permissions`
SELECT
    level_id as `level_id`,
    'ynmultilisting_listing' as `type`,
    'auth_view' as `name`,
    5 as `value`,
    '["everyone","registered","owner_network","owner_member_member","owner_member","owner"]' as `params`
FROM `engine4_authorization_levels` WHERE `type` NOT IN('public');


-- ADMIN - MODERATOR


INSERT IGNORE INTO `engine4_authorization_permissions`
SELECT
    level_id as `level_id`,
    'tfcampaign_campaign' as `type`,
    'create' as `name`,
    1 as `value`,
    NULL as `params`
FROM `engine4_authorization_levels` WHERE `type` IN('moderator', 'admin');

INSERT IGNORE INTO `engine4_authorization_permissions`
SELECT
    level_id as `level_id`,
    'tfcampaign_campaign' as `type`,
    'edit' as `name`,
    2 as `value`,
    NULL as `params`
FROM `engine4_authorization_levels` WHERE `type` IN('moderator', 'admin');

INSERT IGNORE INTO `engine4_authorization_permissions`
SELECT
    level_id as `level_id`,
    'tfcampaign_campaign' as `type`,
    'delete' as `name`,
    2 as `value`,
    NULL as `params`
FROM `engine4_authorization_levels` WHERE `type` IN('moderator', 'admin');

INSERT IGNORE INTO `engine4_authorization_permissions`
SELECT
    level_id as `level_id`,
    'tfcampaign_campaign' as `type`,
    'view' as `name`,
    1 as `value`,
    NULL as `params`
FROM `engine4_authorization_levels` WHERE `type` IN('moderator', 'admin');


-- USER

INSERT IGNORE INTO `engine4_authorization_permissions`
SELECT
    level_id as `level_id`,
    'tfcampaign_campaign' as `type`,
    'create' as `name`,
    1 as `value`,
    NULL as `params`
FROM `engine4_authorization_levels` WHERE `type` IN('user');

INSERT IGNORE INTO `engine4_authorization_permissions`
SELECT
    level_id as `level_id`,
    'tfcampaign_campaign' as `type`,
    'edit' as `name`,
    1 as `value`,
    NULL as `params`
FROM `engine4_authorization_levels` WHERE `type` IN('user');

INSERT IGNORE INTO `engine4_authorization_permissions`
SELECT
    level_id as `level_id`,
    'tfcampaign_campaign' as `type`,
    'delete' as `name`,
    1 as `value`,
    NULL as `params`
FROM `engine4_authorization_levels` WHERE `type` IN('user');

INSERT IGNORE INTO `engine4_authorization_permissions`
SELECT
    level_id as `level_id`,
    'tfcampaign_campaign' as `type`,
    'view' as `name`,
    1 as `value`,
    NULL as `params`
FROM `engine4_authorization_levels` WHERE `type` IN('user');


-- PUBLIC
INSERT IGNORE INTO `engine4_authorization_permissions`
SELECT
    level_id as `level_id`,
    'tfcampaign_campaign' as `type`,
    'view' as `name`,
    1 as `value`,
    NULL as `params`
FROM `engine4_authorization_levels` WHERE `type` IN('public');

