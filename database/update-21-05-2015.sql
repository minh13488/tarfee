DROP TABLE IF EXISTS `engine4_user_playercards`;
CREATE TABLE IF NOT EXISTS `engine4_user_playercards` (
  `playercard_id` int(11) unsigned NOT NULL auto_increment,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `photo_id` int(11) unsigned default NULL,
  `relation_id` int(11) default NULL,
  `relation_other` varchar(100) default NULL,
  `description` text NOT NULL,
  `user_id` int(11) NOT NULL,
  `category_id` int(11) unsigned NOT NULL default '0',
  `gender` tinyint(1) NOT NULL,
  `referred_foot` tinyint(1) NOT NULL,
  `birth_date` datetime NOT NULL,
  `province_id` int(11) unsigned NOT NULL default '0',
  `city_id` int(11) unsigned NOT NULL default '0',
  `position_id` int(11) unsigned NOT NULL default '0',
  `creation_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  PRIMARY KEY  (`playercard_id`),
  KEY `creation_date` (`creation_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ;

INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `order`) VALUES
('core_admin_main_plugins_player', 'user', 'Player Card Settings', '', '{"route":"admin_default","module":"user","controller":"global-settings"}', 'core_admin_main_settings', '', 999),

INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `order`) VALUES
('player_admin_main_managerelation', 'user', 'Manage Relation', '', '{"route":"admin_default","module":"user","controller":"manage-relation"}', 'player_admin_main', '', 2),
('player_admin_main_sportcategory', 'user', 'Sport Categories', '', '{"route":"admin_default","module":"user","controller":"sport-categories"}', 'player_admin_main', '', 4),
('player_admin_main_usergroupsettings', 'user', 'Member Level Settings', '', '{"route":"admin_default","module":"user","controller":"level-settings"}', 'player_admin_main', '', 3),
('player_admin_main_globalsettings', 'user', 'Global Settings', '', '{"route":"admin_default","module":"user","controller":"global-settings"}', 'player_admin_main', '', 1);

CREATE TABLE IF NOT EXISTS `engine4_user_sportcategories` (
  `sportcategory_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `parent_id` int(11) unsigned DEFAULT NULL,
  `pleft` int(11) unsigned NOT NULL,
  `pright` int(11) unsigned NOT NULL,
  `level` int(11) unsigned NOT NULL DEFAULT '0',
  `title` varchar(64) NOT NULL,
  PRIMARY KEY (`sportcategory_id`),
  KEY `user_id` (`user_id`),
  KEY `parent_id` (`parent_id`),
  KEY `pleft` (`pleft`),
  KEY `pright` (`pright`),
  KEY `level` (`level`)
) ENGINE=InnoDB;

INSERT IGNORE INTO `engine4_user_sportcategories` (`sportcategory_id`, `user_id`, `parent_id`, `pleft`, `pright`, `level`, `title`) VALUES (1, 0, NULL, 1, 4, 0, 'All Categories');

CREATE TABLE IF NOT EXISTS `engine4_user_relations` (
  `relation_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` text NOT NULL,
  PRIMARY KEY (`relation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT IGNORE INTO `engine4_user_relations` (`title`) VALUES
('This is my card'),
('I am his/her Parent'),
('I am his brother/sister'),
('I am his/her Coach, Agent, Scout'),
('I am his/her Friend');