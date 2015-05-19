-- phpMyAdmin SQL Dump
-- version 4.4.4
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: May 19, 2015 at 06:07 PM
-- Server version: 5.6.24
-- PHP Version: 5.5.24

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `tarfee`
--

-- --------------------------------------------------------

--
-- Table structure for table `engine4_activity_actions`
--

CREATE TABLE IF NOT EXISTS `engine4_activity_actions` (
  `action_id` int(11) unsigned NOT NULL,
  `type` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `subject_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `subject_id` int(11) unsigned NOT NULL,
  `object_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `object_id` int(11) unsigned NOT NULL,
  `body` text COLLATE utf8_unicode_ci,
  `params` text COLLATE utf8_unicode_ci,
  `date` datetime NOT NULL,
  `attachment_count` smallint(3) unsigned NOT NULL DEFAULT '0',
  `comment_count` mediumint(5) unsigned NOT NULL DEFAULT '0',
  `like_count` mediumint(5) unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_activity_actionsettings`
--

CREATE TABLE IF NOT EXISTS `engine4_activity_actionsettings` (
  `user_id` int(11) unsigned NOT NULL,
  `type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `publish` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_activity_actiontypes`
--

CREATE TABLE IF NOT EXISTS `engine4_activity_actiontypes` (
  `type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `module` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `displayable` tinyint(1) NOT NULL DEFAULT '3',
  `attachable` tinyint(1) NOT NULL DEFAULT '1',
  `commentable` tinyint(1) NOT NULL DEFAULT '1',
  `shareable` tinyint(1) NOT NULL DEFAULT '1',
  `is_generated` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `engine4_activity_actiontypes`
--

INSERT INTO `engine4_activity_actiontypes` (`type`, `module`, `body`, `enabled`, `displayable`, `attachable`, `commentable`, `shareable`, `is_generated`) VALUES
('friends', 'user', '{item:$subject} is now friends with {item:$object}.', 1, 3, 0, 1, 1, 1),
('friends_follow', 'user', '{item:$subject} is now following {item:$object}.', 1, 3, 0, 1, 1, 1),
('login', 'user', '{item:$subject} has signed in.', 0, 1, 0, 1, 1, 1),
('logout', 'user', '{item:$subject} has signed out.', 0, 1, 0, 1, 1, 1),
('network_join', 'network', '{item:$subject} joined the network {item:$object}', 1, 3, 1, 1, 1, 1),
('post', 'user', '{actors:$subject:$object}: {body:$body}', 1, 7, 1, 4, 1, 0),
('post_self', 'user', '{item:$subject} {body:$body}', 1, 5, 1, 4, 1, 0),
('profile_photo_update', 'user', '{item:$subject} has added a new profile photo.', 1, 5, 1, 4, 1, 1),
('share', 'activity', '{item:$subject} shared {item:$object}''s {var:$type}. {body:$body}', 1, 5, 1, 1, 0, 1),
('signup', 'user', '{item:$subject} has just signed up. Say hello!', 1, 5, 0, 1, 1, 1),
('status', 'user', '{item:$subject} {body:$body}', 1, 5, 0, 1, 4, 0),
('tagged', 'user', '{item:$subject} tagged {item:$object} in a {var:$label}:', 1, 7, 1, 1, 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_activity_attachments`
--

CREATE TABLE IF NOT EXISTS `engine4_activity_attachments` (
  `attachment_id` int(11) unsigned NOT NULL,
  `action_id` int(11) unsigned NOT NULL,
  `type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `id` int(11) unsigned NOT NULL,
  `mode` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_activity_comments`
--

CREATE TABLE IF NOT EXISTS `engine4_activity_comments` (
  `comment_id` int(11) unsigned NOT NULL,
  `resource_id` int(11) unsigned NOT NULL,
  `poster_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `poster_id` int(11) unsigned NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `creation_date` datetime NOT NULL,
  `like_count` int(11) unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_activity_likes`
--

CREATE TABLE IF NOT EXISTS `engine4_activity_likes` (
  `like_id` int(11) unsigned NOT NULL,
  `resource_id` int(11) unsigned NOT NULL,
  `poster_type` varchar(16) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `poster_id` int(11) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_activity_notifications`
--

CREATE TABLE IF NOT EXISTS `engine4_activity_notifications` (
  `notification_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `subject_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `subject_id` int(11) unsigned NOT NULL,
  `object_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `object_id` int(11) unsigned NOT NULL,
  `type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `params` text COLLATE utf8_unicode_ci,
  `read` tinyint(1) NOT NULL DEFAULT '0',
  `mitigated` tinyint(1) NOT NULL DEFAULT '0',
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_activity_notificationsettings`
--

CREATE TABLE IF NOT EXISTS `engine4_activity_notificationsettings` (
  `user_id` int(11) unsigned NOT NULL,
  `type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `email` tinyint(4) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_activity_notificationtypes`
--

CREATE TABLE IF NOT EXISTS `engine4_activity_notificationtypes` (
  `type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `module` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `is_request` tinyint(1) NOT NULL DEFAULT '0',
  `handler` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `default` tinyint(4) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `engine4_activity_notificationtypes`
--

INSERT INTO `engine4_activity_notificationtypes` (`type`, `module`, `body`, `is_request`, `handler`, `default`) VALUES
('commented', 'activity', '{item:$subject} has commented on your {item:$object:$label}.', 0, '', 1),
('commented_commented', 'activity', '{item:$subject} has commented on a {item:$object:$label} you commented on.', 0, '', 1),
('friend_accepted', 'user', 'You and {item:$subject} are now friends.', 0, '', 1),
('friend_follow', 'user', '{item:$subject} is now following you.', 0, '', 1),
('friend_follow_accepted', 'user', 'You are now following {item:$subject}.', 0, '', 1),
('friend_follow_request', 'user', '{item:$subject} has requested to follow you.', 1, 'user.friends.request-follow', 1),
('friend_request', 'user', '{item:$subject} has requested to be your friend.', 1, 'user.friends.request-friend', 1),
('liked', 'activity', '{item:$subject} likes your {item:$object:$label}.', 0, '', 1),
('liked_commented', 'activity', '{item:$subject} has commented on a {item:$object:$label} you liked.', 0, '', 1),
('message_new', 'messages', '{item:$subject} has sent you a {item:$object:message}.', 0, '', 1),
('post_user', 'user', '{item:$subject} has posted on your {item:$object:profile}.', 0, '', 1),
('shared', 'activity', '{item:$subject} has shared your {item:$object:$label}.', 0, '', 1),
('tagged', 'user', '{item:$subject} tagged you in a {item:$object:$label}.', 0, '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_activity_stream`
--

CREATE TABLE IF NOT EXISTS `engine4_activity_stream` (
  `target_type` varchar(16) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `target_id` int(11) unsigned NOT NULL,
  `subject_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `subject_id` int(11) unsigned NOT NULL,
  `object_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `object_id` int(11) unsigned NOT NULL,
  `type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `action_id` int(11) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_announcement_announcements`
--

CREATE TABLE IF NOT EXISTS `engine4_announcement_announcements` (
  `announcement_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `creation_date` datetime NOT NULL,
  `modified_date` datetime DEFAULT NULL,
  `networks` text COLLATE utf8_unicode_ci,
  `member_levels` text COLLATE utf8_unicode_ci,
  `profile_types` text COLLATE utf8_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_authorization_allow`
--

CREATE TABLE IF NOT EXISTS `engine4_authorization_allow` (
  `resource_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `resource_id` int(11) unsigned NOT NULL,
  `action` varchar(16) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `role` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `role_id` int(11) unsigned NOT NULL DEFAULT '0',
  `value` tinyint(1) NOT NULL DEFAULT '0',
  `params` text COLLATE utf8_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `engine4_authorization_allow`
--

INSERT INTO `engine4_authorization_allow` (`resource_type`, `resource_id`, `action`, `role`, `role_id`, `value`, `params`) VALUES
('user', 1, 'comment', 'everyone', 0, 1, NULL),
('user', 1, 'comment', 'member', 0, 1, NULL),
('user', 1, 'comment', 'network', 0, 1, NULL),
('user', 1, 'comment', 'registered', 0, 1, NULL),
('user', 1, 'view', 'everyone', 0, 1, NULL),
('user', 1, 'view', 'member', 0, 1, NULL),
('user', 1, 'view', 'network', 0, 1, NULL),
('user', 1, 'view', 'registered', 0, 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_authorization_levels`
--

CREATE TABLE IF NOT EXISTS `engine4_authorization_levels` (
  `level_id` int(11) NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `type` enum('public','user','moderator','admin') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'user',
  `flag` enum('default','superadmin','public') COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `engine4_authorization_levels`
--

INSERT INTO `engine4_authorization_levels` (`level_id`, `title`, `description`, `type`, `flag`) VALUES
(1, 'Superadmins', 'Users of this level can modify all of your settings and data.  This level cannot be modified or deleted.', 'admin', 'superadmin'),
(2, 'Admins', 'Users of this level have full access to all of your network settings and data.', 'admin', ''),
(3, 'Moderators', 'Users of this level may edit user-side content.', 'moderator', ''),
(4, 'Default Level', 'This is the default user level.  New users are assigned to it automatically.', 'user', 'default'),
(5, 'Public', 'Settings for this level apply to users who have not logged in.', 'public', 'public');

-- --------------------------------------------------------

--
-- Table structure for table `engine4_authorization_permissions`
--

CREATE TABLE IF NOT EXISTS `engine4_authorization_permissions` (
  `level_id` int(11) unsigned NOT NULL,
  `type` varchar(16) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `name` varchar(16) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `value` tinyint(3) NOT NULL DEFAULT '0',
  `params` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `engine4_authorization_permissions`
--

INSERT INTO `engine4_authorization_permissions` (`level_id`, `type`, `name`, `value`, `params`) VALUES
(1, 'admin', 'view', 1, NULL),
(1, 'announcement', 'create', 1, NULL),
(1, 'announcement', 'delete', 2, NULL),
(1, 'announcement', 'edit', 2, NULL),
(1, 'announcement', 'view', 2, NULL),
(1, 'core_link', 'create', 1, NULL),
(1, 'core_link', 'delete', 2, NULL),
(1, 'core_link', 'view', 2, NULL),
(1, 'general', 'activity', 2, NULL),
(1, 'general', 'style', 2, NULL),
(1, 'messages', 'auth', 3, 'friends'),
(1, 'messages', 'create', 1, NULL),
(1, 'messages', 'editor', 3, 'plaintext'),
(1, 'user', 'activity', 1, NULL),
(1, 'user', 'auth_comment', 5, '["everyone","registered","network","member","owner"]'),
(1, 'user', 'auth_view', 5, '["everyone","registered","network","member","owner"]'),
(1, 'user', 'block', 1, NULL),
(1, 'user', 'comment', 2, NULL),
(1, 'user', 'create', 1, NULL),
(1, 'user', 'delete', 2, NULL),
(1, 'user', 'edit', 2, NULL),
(1, 'user', 'search', 1, NULL),
(1, 'user', 'status', 1, NULL),
(1, 'user', 'style', 2, NULL),
(1, 'user', 'username', 2, NULL),
(1, 'user', 'view', 2, NULL),
(2, 'admin', 'view', 1, NULL),
(2, 'announcement', 'create', 1, NULL),
(2, 'announcement', 'delete', 2, NULL),
(2, 'announcement', 'edit', 2, NULL),
(2, 'announcement', 'view', 2, NULL),
(2, 'core_link', 'create', 1, NULL),
(2, 'core_link', 'delete', 2, NULL),
(2, 'core_link', 'view', 2, NULL),
(2, 'general', 'activity', 2, NULL),
(2, 'general', 'style', 2, NULL),
(2, 'messages', 'auth', 3, 'friends'),
(2, 'messages', 'create', 1, NULL),
(2, 'messages', 'editor', 3, 'plaintext'),
(2, 'user', 'activity', 1, NULL),
(2, 'user', 'auth_comment', 5, '["everyone","registered","network","member","owner"]'),
(2, 'user', 'auth_view', 5, '["everyone","registered","network","member","owner"]'),
(2, 'user', 'block', 1, NULL),
(2, 'user', 'comment', 2, NULL),
(2, 'user', 'create', 1, NULL),
(2, 'user', 'delete', 2, NULL),
(2, 'user', 'edit', 2, NULL),
(2, 'user', 'search', 1, NULL),
(2, 'user', 'status', 1, NULL),
(2, 'user', 'style', 2, NULL),
(2, 'user', 'username', 2, NULL),
(2, 'user', 'view', 2, NULL),
(3, 'announcement', 'view', 1, NULL),
(3, 'core_link', 'create', 1, NULL),
(3, 'core_link', 'delete', 2, NULL),
(3, 'core_link', 'view', 2, NULL),
(3, 'general', 'activity', 2, NULL),
(3, 'general', 'style', 2, NULL),
(3, 'messages', 'auth', 3, 'friends'),
(3, 'messages', 'create', 1, NULL),
(3, 'messages', 'editor', 3, 'plaintext'),
(3, 'user', 'activity', 1, NULL),
(3, 'user', 'auth_comment', 5, '["everyone","registered","network","member","owner"]'),
(3, 'user', 'auth_view', 5, '["everyone","registered","network","member","owner"]'),
(3, 'user', 'block', 1, NULL),
(3, 'user', 'comment', 2, NULL),
(3, 'user', 'create', 1, NULL),
(3, 'user', 'delete', 2, NULL),
(3, 'user', 'edit', 2, NULL),
(3, 'user', 'search', 1, NULL),
(3, 'user', 'status', 1, NULL),
(3, 'user', 'style', 2, NULL),
(3, 'user', 'username', 2, NULL),
(3, 'user', 'view', 2, NULL),
(4, 'announcement', 'view', 1, NULL),
(4, 'core_link', 'create', 1, NULL),
(4, 'core_link', 'delete', 1, NULL),
(4, 'core_link', 'view', 1, NULL),
(4, 'general', 'style', 1, NULL),
(4, 'messages', 'auth', 3, 'friends'),
(4, 'messages', 'create', 1, NULL),
(4, 'messages', 'editor', 3, 'plaintext'),
(4, 'user', 'auth_comment', 5, '["everyone","registered","network","member","owner"]'),
(4, 'user', 'auth_view', 5, '["everyone","registered","network","member","owner"]'),
(4, 'user', 'block', 1, NULL),
(4, 'user', 'comment', 1, NULL),
(4, 'user', 'create', 1, NULL),
(4, 'user', 'delete', 1, NULL),
(4, 'user', 'edit', 1, NULL),
(4, 'user', 'search', 1, NULL),
(4, 'user', 'status', 1, NULL),
(4, 'user', 'style', 1, NULL),
(4, 'user', 'username', 1, NULL),
(4, 'user', 'view', 1, NULL),
(5, 'announcement', 'view', 1, NULL),
(5, 'core_link', 'view', 1, NULL),
(5, 'user', 'view', 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_adcampaigns`
--

CREATE TABLE IF NOT EXISTS `engine4_core_adcampaigns` (
  `adcampaign_id` int(11) unsigned NOT NULL,
  `end_settings` tinyint(4) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `limit_view` int(11) unsigned NOT NULL DEFAULT '0',
  `limit_click` int(11) unsigned NOT NULL DEFAULT '0',
  `limit_ctr` varchar(11) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `network` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `level` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `views` int(11) unsigned NOT NULL DEFAULT '0',
  `clicks` int(11) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_adphotos`
--

CREATE TABLE IF NOT EXISTS `engine4_core_adphotos` (
  `adphoto_id` int(11) unsigned NOT NULL,
  `ad_id` int(11) unsigned NOT NULL,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `file_id` int(11) unsigned NOT NULL,
  `creation_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_ads`
--

CREATE TABLE IF NOT EXISTS `engine4_core_ads` (
  `ad_id` int(11) unsigned NOT NULL,
  `name` varchar(16) COLLATE utf8_unicode_ci NOT NULL,
  `ad_campaign` int(11) unsigned NOT NULL,
  `views` int(11) unsigned NOT NULL DEFAULT '0',
  `clicks` int(11) unsigned NOT NULL DEFAULT '0',
  `media_type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `html_code` text COLLATE utf8_unicode_ci NOT NULL,
  `photo_id` int(11) unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_auth`
--

CREATE TABLE IF NOT EXISTS `engine4_core_auth` (
  `id` varchar(40) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `expires` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_bannedemails`
--

CREATE TABLE IF NOT EXISTS `engine4_core_bannedemails` (
  `bannedemail_id` int(10) unsigned NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_bannedips`
--

CREATE TABLE IF NOT EXISTS `engine4_core_bannedips` (
  `bannedip_id` int(10) unsigned NOT NULL,
  `start` varbinary(16) NOT NULL,
  `stop` varbinary(16) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_bannedusernames`
--

CREATE TABLE IF NOT EXISTS `engine4_core_bannedusernames` (
  `bannedusername_id` int(10) unsigned NOT NULL,
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_bannedwords`
--

CREATE TABLE IF NOT EXISTS `engine4_core_bannedwords` (
  `bannedword_id` int(10) unsigned NOT NULL,
  `word` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_comments`
--

CREATE TABLE IF NOT EXISTS `engine4_core_comments` (
  `comment_id` int(11) unsigned NOT NULL,
  `resource_type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `resource_id` int(11) unsigned NOT NULL,
  `poster_type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `poster_id` int(11) unsigned NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `creation_date` datetime NOT NULL,
  `like_count` int(11) unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_content`
--

CREATE TABLE IF NOT EXISTS `engine4_core_content` (
  `content_id` int(11) unsigned NOT NULL,
  `page_id` int(11) unsigned NOT NULL,
  `type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT 'widget',
  `name` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `parent_content_id` int(11) unsigned DEFAULT NULL,
  `order` int(11) NOT NULL DEFAULT '1',
  `params` text COLLATE utf8_unicode_ci,
  `attribs` text COLLATE utf8_unicode_ci
) ENGINE=InnoDB AUTO_INCREMENT=638 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `engine4_core_content`
--

INSERT INTO `engine4_core_content` (`content_id`, `page_id`, `type`, `name`, `parent_content_id`, `order`, `params`, `attribs`) VALUES
(100, 1, 'container', 'main', NULL, 1, '', NULL),
(110, 1, 'widget', 'core.menu-mini', 100, 1, '', NULL),
(111, 1, 'widget', 'core.menu-logo', 100, 2, '', NULL),
(112, 1, 'widget', 'core.menu-main', 100, 3, '', NULL),
(200, 2, 'container', 'main', NULL, 1, '', NULL),
(210, 2, 'widget', 'core.menu-footer', 200, 2, '', NULL),
(300, 3, 'container', 'main', NULL, 1, '', NULL),
(310, 3, 'container', 'left', 300, 1, '', NULL),
(311, 3, 'container', 'right', 300, 2, '', NULL),
(312, 3, 'container', 'middle', 300, 3, '', NULL),
(320, 3, 'widget', 'user.login-or-signup', 310, 1, '', NULL),
(321, 3, 'widget', 'user.list-online', 310, 2, '{"title":"%s Members Online"}', NULL),
(322, 3, 'widget', 'core.statistics', 310, 3, '{"title":"Network Stats"}', NULL),
(330, 3, 'widget', 'user.list-signups', 311, 1, '{"title":"Newest Members"}', NULL),
(331, 3, 'widget', 'user.list-popular', 311, 2, '{"title":"Popular Members"}', NULL),
(340, 3, 'widget', 'announcement.list-announcements', 312, 1, '', NULL),
(341, 3, 'widget', 'activity.feed', 312, 2, '{"title":"What''s New"}', NULL),
(400, 4, 'container', 'main', NULL, 1, '', NULL),
(410, 4, 'container', 'left', 400, 1, '', NULL),
(411, 4, 'container', 'right', 400, 2, '', NULL),
(412, 4, 'container', 'middle', 400, 3, '', NULL),
(420, 4, 'widget', 'user.home-photo', 410, 1, '', NULL),
(421, 4, 'widget', 'user.home-links', 410, 2, '', NULL),
(422, 4, 'widget', 'user.list-online', 410, 3, '{"title":"%s Members Online"}', NULL),
(423, 4, 'widget', 'core.statistics', 410, 4, '{"title":"Network Stats"}', NULL),
(430, 4, 'widget', 'activity.list-requests', 411, 1, '{"title":"Requests"}', NULL),
(431, 4, 'widget', 'user.list-signups', 411, 2, '{"title":"Newest Members"}', NULL),
(432, 4, 'widget', 'user.list-popular', 411, 3, '{"title":"Popular Members"}', NULL),
(440, 4, 'widget', 'announcement.list-announcements', 412, 1, '', NULL),
(441, 4, 'widget', 'activity.feed', 412, 2, '{"title":"What''s New"}', NULL),
(500, 5, 'container', 'main', NULL, 1, '', NULL),
(510, 5, 'container', 'left', 500, 1, '', NULL),
(511, 5, 'container', 'middle', 500, 3, '', NULL),
(520, 5, 'widget', 'user.profile-photo', 510, 1, '', NULL),
(521, 5, 'widget', 'user.profile-options', 510, 2, '', NULL),
(522, 5, 'widget', 'user.profile-friends-common', 510, 3, '{"title":"Mutual Friends"}', NULL),
(523, 5, 'widget', 'user.profile-info', 510, 4, '{"title":"Member Info"}', NULL),
(530, 5, 'widget', 'user.profile-status', 511, 1, '', NULL),
(531, 5, 'widget', 'core.container-tabs', 511, 2, '{"max":"6"}', NULL),
(540, 5, 'widget', 'activity.feed', 531, 1, '{"title":"Updates"}', NULL),
(541, 5, 'widget', 'user.profile-fields', 531, 2, '{"title":"Info"}', NULL),
(542, 5, 'widget', 'user.profile-friends', 531, 3, '{"title":"Friends","titleCount":true}', NULL),
(546, 5, 'widget', 'core.profile-links', 531, 7, '{"title":"Links","titleCount":true}', NULL),
(547, 6, 'container', 'main', NULL, 1, NULL, NULL),
(548, 6, 'container', 'middle', 547, 2, NULL, NULL),
(549, 6, 'widget', 'core.content', 548, 1, NULL, NULL),
(550, 7, 'container', 'main', NULL, 1, NULL, NULL),
(551, 7, 'container', 'middle', 550, 2, NULL, NULL),
(552, 7, 'widget', 'core.content', 551, 1, NULL, NULL),
(553, 8, 'container', 'main', NULL, 1, NULL, NULL),
(554, 8, 'container', 'middle', 553, 2, NULL, NULL),
(555, 8, 'widget', 'core.content', 554, 1, NULL, NULL),
(556, 9, 'container', 'main', NULL, 1, NULL, NULL),
(557, 9, 'container', 'middle', 556, 1, NULL, NULL),
(558, 9, 'widget', 'core.content', 557, 1, NULL, NULL),
(559, 10, 'container', 'main', NULL, 1, NULL, NULL),
(560, 10, 'container', 'middle', 559, 1, NULL, NULL),
(561, 10, 'widget', 'core.content', 560, 1, NULL, NULL),
(562, 11, 'container', 'main', NULL, 1, NULL, NULL),
(563, 11, 'container', 'middle', 562, 1, NULL, NULL),
(564, 11, 'widget', 'core.content', 563, 1, NULL, NULL),
(565, 12, 'container', 'main', NULL, 1, NULL, NULL),
(566, 12, 'container', 'middle', 565, 1, NULL, NULL),
(567, 12, 'widget', 'core.content', 566, 1, NULL, NULL),
(568, 13, 'container', 'main', NULL, 1, NULL, NULL),
(569, 13, 'container', 'middle', 568, 1, NULL, NULL),
(570, 13, 'widget', 'core.content', 569, 1, NULL, NULL),
(571, 14, 'container', 'top', NULL, 1, NULL, NULL),
(572, 14, 'container', 'main', NULL, 2, NULL, NULL),
(573, 14, 'container', 'middle', 571, 1, NULL, NULL),
(574, 14, 'container', 'middle', 572, 2, NULL, NULL),
(575, 14, 'widget', 'user.settings-menu', 573, 1, NULL, NULL),
(576, 14, 'widget', 'core.content', 574, 1, NULL, NULL),
(577, 15, 'container', 'top', NULL, 1, NULL, NULL),
(578, 15, 'container', 'main', NULL, 2, NULL, NULL),
(579, 15, 'container', 'middle', 577, 1, NULL, NULL),
(580, 15, 'container', 'middle', 578, 2, NULL, NULL),
(581, 15, 'widget', 'user.settings-menu', 579, 1, NULL, NULL),
(582, 15, 'widget', 'core.content', 580, 1, NULL, NULL),
(583, 16, 'container', 'top', NULL, 1, NULL, NULL),
(584, 16, 'container', 'main', NULL, 2, NULL, NULL),
(585, 16, 'container', 'middle', 583, 1, NULL, NULL),
(586, 16, 'container', 'middle', 584, 2, NULL, NULL),
(587, 16, 'widget', 'user.settings-menu', 585, 1, NULL, NULL),
(588, 16, 'widget', 'core.content', 586, 1, NULL, NULL),
(589, 17, 'container', 'top', NULL, 1, NULL, NULL),
(590, 17, 'container', 'main', NULL, 2, NULL, NULL),
(591, 17, 'container', 'middle', 589, 1, NULL, NULL),
(592, 17, 'container', 'middle', 590, 2, NULL, NULL),
(593, 17, 'widget', 'user.settings-menu', 591, 1, NULL, NULL),
(594, 17, 'widget', 'core.content', 592, 1, NULL, NULL),
(595, 18, 'container', 'top', NULL, 1, NULL, NULL),
(596, 18, 'container', 'main', NULL, 2, NULL, NULL),
(597, 18, 'container', 'middle', 595, 1, NULL, NULL),
(598, 18, 'container', 'middle', 596, 2, NULL, NULL),
(599, 18, 'widget', 'user.settings-menu', 597, 1, NULL, NULL),
(600, 18, 'widget', 'core.content', 598, 1, NULL, NULL),
(601, 19, 'container', 'top', NULL, 1, NULL, NULL),
(602, 19, 'container', 'main', NULL, 2, NULL, NULL),
(603, 19, 'container', 'middle', 601, 1, NULL, NULL),
(604, 19, 'container', 'middle', 602, 2, NULL, NULL),
(605, 19, 'widget', 'user.settings-menu', 603, 1, NULL, NULL),
(606, 19, 'widget', 'core.content', 604, 1, NULL, NULL),
(607, 20, 'container', 'top', NULL, 1, NULL, NULL),
(608, 20, 'container', 'main', NULL, 2, NULL, NULL),
(609, 20, 'container', 'middle', 607, 1, NULL, NULL),
(610, 20, 'container', 'middle', 608, 2, NULL, NULL),
(611, 20, 'container', 'left', 608, 1, NULL, NULL),
(612, 20, 'widget', 'user.browse-menu', 609, 1, NULL, NULL),
(613, 20, 'widget', 'core.content', 610, 1, NULL, NULL),
(614, 20, 'widget', 'user.browse-search', 611, 1, NULL, NULL),
(615, 21, 'container', 'main', NULL, 1, NULL, NULL),
(616, 21, 'container', 'middle', 615, 1, NULL, NULL),
(617, 21, 'widget', 'core.content', 616, 1, NULL, NULL),
(618, 22, 'container', 'main', NULL, 1, NULL, NULL),
(619, 22, 'container', 'middle', 618, 1, NULL, NULL),
(620, 22, 'widget', 'core.content', 619, 2, NULL, NULL),
(621, 22, 'widget', 'messages.menu', 619, 1, NULL, NULL),
(622, 23, 'container', 'main', NULL, 1, NULL, NULL),
(623, 23, 'container', 'middle', 622, 1, NULL, NULL),
(624, 23, 'widget', 'core.content', 623, 2, NULL, NULL),
(625, 23, 'widget', 'messages.menu', 623, 1, NULL, NULL),
(626, 24, 'container', 'main', NULL, 1, NULL, NULL),
(627, 24, 'container', 'middle', 626, 1, NULL, NULL),
(628, 24, 'widget', 'core.content', 627, 2, NULL, NULL),
(629, 24, 'widget', 'messages.menu', 627, 1, NULL, NULL),
(630, 25, 'container', 'main', NULL, 1, NULL, NULL),
(631, 25, 'container', 'middle', 630, 1, NULL, NULL),
(632, 25, 'widget', 'core.content', 631, 2, NULL, NULL),
(633, 25, 'widget', 'messages.menu', 631, 1, NULL, NULL),
(634, 26, 'container', 'main', NULL, 1, NULL, NULL),
(635, 26, 'container', 'middle', 634, 1, NULL, NULL),
(636, 26, 'widget', 'core.content', 635, 2, NULL, NULL),
(637, 26, 'widget', 'messages.menu', 635, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_geotags`
--

CREATE TABLE IF NOT EXISTS `engine4_core_geotags` (
  `geotag_id` int(11) unsigned NOT NULL,
  `latitude` float NOT NULL,
  `longitude` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_jobs`
--

CREATE TABLE IF NOT EXISTS `engine4_core_jobs` (
  `job_id` bigint(20) unsigned NOT NULL,
  `jobtype_id` int(10) unsigned NOT NULL,
  `state` enum('pending','active','sleeping','failed','cancelled','completed','timeout') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'pending',
  `is_complete` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `progress` decimal(5,4) unsigned NOT NULL DEFAULT '0.0000',
  `creation_date` datetime NOT NULL,
  `modified_date` datetime DEFAULT NULL,
  `started_date` datetime DEFAULT NULL,
  `completion_date` datetime DEFAULT NULL,
  `priority` mediumint(9) NOT NULL DEFAULT '100',
  `data` text COLLATE utf8_unicode_ci,
  `messages` text COLLATE utf8_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_jobtypes`
--

CREATE TABLE IF NOT EXISTS `engine4_core_jobtypes` (
  `jobtype_id` int(11) unsigned NOT NULL,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `module` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `plugin` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `form` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `priority` mediumint(9) NOT NULL DEFAULT '100',
  `multi` tinyint(3) unsigned DEFAULT '1'
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `engine4_core_jobtypes`
--

INSERT INTO `engine4_core_jobtypes` (`jobtype_id`, `title`, `type`, `module`, `plugin`, `form`, `enabled`, `priority`, `multi`) VALUES
(1, 'Download File', 'file_download', 'core', 'Core_Plugin_Job_FileDownload', 'Core_Form_Admin_Job_FileDownload', 1, 100, 1),
(2, 'Upload File', 'file_upload', 'core', 'Core_Plugin_Job_FileUpload', 'Core_Form_Admin_Job_FileUpload', 1, 100, 1),
(3, 'Rebuild Activity Privacy', 'activity_maintenance_rebuild_privacy', 'activity', 'Activity_Plugin_Job_Maintenance_RebuildPrivacy', NULL, 1, 50, 1),
(4, 'Rebuild Member Privacy', 'user_maintenance_rebuild_privacy', 'user', 'User_Plugin_Job_Maintenance_RebuildPrivacy', NULL, 1, 50, 1),
(5, 'Rebuild Network Membership', 'network_maintenance_rebuild_membership', 'network', 'Network_Plugin_Job_Maintenance_RebuildMembership', NULL, 1, 50, 1),
(6, 'Storage Transfer', 'storage_transfer', 'core', 'Storage_Plugin_Job_Transfer', 'Core_Form_Admin_Job_Generic', 1, 100, 1),
(7, 'Storage Cleanup', 'storage_cleanup', 'core', 'Storage_Plugin_Job_Cleanup', 'Core_Form_Admin_Job_Generic', 1, 100, 1);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_languages`
--

CREATE TABLE IF NOT EXISTS `engine4_core_languages` (
  `language_id` int(11) unsigned NOT NULL,
  `code` varchar(8) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `fallback` varchar(8) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `order` smallint(6) NOT NULL DEFAULT '1'
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `engine4_core_languages`
--

INSERT INTO `engine4_core_languages` (`language_id`, `code`, `name`, `fallback`, `order`) VALUES
(1, 'en', 'English', 'en', 1);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_likes`
--

CREATE TABLE IF NOT EXISTS `engine4_core_likes` (
  `like_id` int(11) unsigned NOT NULL,
  `resource_type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `resource_id` int(11) unsigned NOT NULL,
  `poster_type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `poster_id` int(11) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_links`
--

CREATE TABLE IF NOT EXISTS `engine4_core_links` (
  `link_id` int(11) unsigned NOT NULL,
  `uri` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `photo_id` int(11) unsigned NOT NULL DEFAULT '0',
  `parent_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `parent_id` int(11) unsigned NOT NULL,
  `owner_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `owner_id` int(11) unsigned NOT NULL,
  `view_count` mediumint(6) unsigned NOT NULL DEFAULT '0',
  `creation_date` datetime NOT NULL,
  `search` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_listitems`
--

CREATE TABLE IF NOT EXISTS `engine4_core_listitems` (
  `listitem_id` int(11) unsigned NOT NULL,
  `list_id` int(11) unsigned NOT NULL,
  `child_id` int(11) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_lists`
--

CREATE TABLE IF NOT EXISTS `engine4_core_lists` (
  `list_id` int(11) unsigned NOT NULL,
  `title` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `owner_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `owner_id` int(11) unsigned NOT NULL,
  `child_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `child_count` int(11) unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_log`
--

CREATE TABLE IF NOT EXISTS `engine4_core_log` (
  `message_id` bigint(20) unsigned NOT NULL,
  `domain` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `plugin` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `timestamp` datetime NOT NULL,
  `message` longtext COLLATE utf8_unicode_ci NOT NULL,
  `priority` smallint(2) NOT NULL DEFAULT '6',
  `priorityName` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'INFO'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_mail`
--

CREATE TABLE IF NOT EXISTS `engine4_core_mail` (
  `mail_id` int(11) unsigned NOT NULL,
  `type` enum('system','zend') CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `body` longtext COLLATE utf8_unicode_ci NOT NULL,
  `priority` smallint(3) DEFAULT '100',
  `recipient_count` int(11) unsigned DEFAULT '0',
  `recipient_total` int(10) NOT NULL DEFAULT '0',
  `creation_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_mailrecipients`
--

CREATE TABLE IF NOT EXISTS `engine4_core_mailrecipients` (
  `recipient_id` int(11) unsigned NOT NULL,
  `mail_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned DEFAULT NULL,
  `email` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_mailtemplates`
--

CREATE TABLE IF NOT EXISTS `engine4_core_mailtemplates` (
  `mailtemplate_id` int(11) unsigned NOT NULL,
  `type` varchar(255) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `module` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `vars` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `engine4_core_mailtemplates`
--

INSERT INTO `engine4_core_mailtemplates` (`mailtemplate_id`, `type`, `module`, `vars`) VALUES
(1, 'header', 'core', ''),
(2, 'footer', 'core', ''),
(3, 'header_member', 'core', ''),
(4, 'footer_member', 'core', ''),
(5, 'core_contact', 'core', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_name],[sender_email],[sender_link],[sender_photo],[message]'),
(6, 'core_verification', 'core', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[object_link]'),
(7, 'core_verification_password', 'core', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[object_link],[password]'),
(8, 'core_welcome', 'core', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[object_link]'),
(9, 'core_welcome_password', 'core', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[object_link],[password]'),
(10, 'notify_admin_user_signup', 'core', '[host],[email],[date],[recipient_title],[object_title],[object_link]'),
(11, 'core_lostpassword', 'core', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[object_link]'),
(12, 'notify_commented', 'activity', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]'),
(13, 'notify_commented_commented', 'activity', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]'),
(14, 'notify_liked', 'activity', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]'),
(15, 'notify_liked_commented', 'activity', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]'),
(16, 'user_account_approved', 'user', '[host],[email],[recipient_title],[recipient_link],[recipient_photo]'),
(17, 'notify_friend_accepted', 'user', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]'),
(18, 'notify_friend_request', 'user', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]'),
(19, 'notify_friend_follow_request', 'user', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]'),
(20, 'notify_friend_follow_accepted', 'user', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]'),
(21, 'notify_friend_follow', 'user', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]'),
(22, 'notify_post_user', 'user', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]'),
(23, 'notify_tagged', 'user', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]'),
(24, 'notify_message_new', 'messages', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]'),
(25, 'invite', 'invite', '[host],[email],[sender_email],[sender_title],[sender_link],[sender_photo],[message],[object_link],[code]'),
(26, 'invite_code', 'invite', '[host],[email],[sender_email],[sender_title],[sender_link],[sender_photo],[message],[object_link],[code]'),
(27, 'payment_subscription_active', 'payment', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[subscription_title],[subscription_description],[object_link]'),
(28, 'payment_subscription_cancelled', 'payment', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[subscription_title],[subscription_description],[object_link]'),
(29, 'payment_subscription_expired', 'payment', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[subscription_title],[subscription_description],[object_link]'),
(30, 'payment_subscription_overdue', 'payment', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[subscription_title],[subscription_description],[object_link]'),
(31, 'payment_subscription_pending', 'payment', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[subscription_title],[subscription_description],[object_link]'),
(32, 'payment_subscription_recurrence', 'payment', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[subscription_title],[subscription_description],[object_link]'),
(33, 'payment_subscription_refunded', 'payment', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[subscription_title],[subscription_description],[object_link]');

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_menuitems`
--

CREATE TABLE IF NOT EXISTS `engine4_core_menuitems` (
  `id` int(11) unsigned NOT NULL,
  `name` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `module` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `label` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `plugin` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `params` text COLLATE utf8_unicode_ci NOT NULL,
  `menu` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `submenu` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `custom` tinyint(1) NOT NULL DEFAULT '0',
  `order` smallint(6) NOT NULL DEFAULT '999'
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `engine4_core_menuitems`
--

INSERT INTO `engine4_core_menuitems` (`id`, `name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES
(1, 'core_main_home', 'core', 'Home', 'User_Plugin_Menus', '', 'core_main', '', 1, 0, 1),
(2, 'core_sitemap_home', 'core', 'Home', '', '{"route":"default"}', 'core_sitemap', '', 1, 0, 1),
(3, 'core_footer_privacy', 'core', 'Privacy', '', '{"route":"default","module":"core","controller":"help","action":"privacy"}', 'core_footer', '', 1, 0, 1),
(4, 'core_footer_terms', 'core', 'Terms of Service', '', '{"route":"default","module":"core","controller":"help","action":"terms"}', 'core_footer', '', 1, 0, 2),
(5, 'core_footer_contact', 'core', 'Contact', '', '{"route":"default","module":"core","controller":"help","action":"contact"}', 'core_footer', '', 1, 0, 3),
(6, 'core_mini_admin', 'core', 'Admin', 'User_Plugin_Menus', '', 'core_mini', '', 1, 0, 6),
(7, 'core_mini_profile', 'user', 'My Profile', 'User_Plugin_Menus', '', 'core_mini', '', 1, 0, 5),
(8, 'core_mini_settings', 'user', 'Settings', 'User_Plugin_Menus', '', 'core_mini', '', 1, 0, 3),
(9, 'core_mini_auth', 'user', 'Auth', 'User_Plugin_Menus', '', 'core_mini', '', 1, 0, 2),
(10, 'core_mini_signup', 'user', 'Signup', 'User_Plugin_Menus', '', 'core_mini', '', 1, 0, 1),
(11, 'core_admin_main_home', 'core', 'Home', '', '{"route":"admin_default"}', 'core_admin_main', '', 1, 0, 1),
(12, 'core_admin_main_manage', 'core', 'Manage', '', '{"uri":"javascript:void(0);this.blur();"}', 'core_admin_main', 'core_admin_main_manage', 1, 0, 2),
(13, 'core_admin_main_settings', 'core', 'Settings', '', '{"uri":"javascript:void(0);this.blur();"}', 'core_admin_main', 'core_admin_main_settings', 1, 0, 3),
(14, 'core_admin_main_plugins', 'core', 'Plugins', '', '{"uri":"javascript:void(0);this.blur();"}', 'core_admin_main', 'core_admin_main_plugins', 1, 0, 4),
(15, 'core_admin_main_layout', 'core', 'Layout', '', '{"uri":"javascript:void(0);this.blur();"}', 'core_admin_main', 'core_admin_main_layout', 1, 0, 5),
(16, 'core_admin_main_ads', 'core', 'Ads', '', '{"uri":"javascript:void(0);this.blur();"}', 'core_admin_main', 'core_admin_main_ads', 1, 0, 6),
(17, 'core_admin_main_stats', 'core', 'Stats', '', '{"uri":"javascript:void(0);this.blur();"}', 'core_admin_main', 'core_admin_main_stats', 1, 0, 8),
(18, 'core_admin_main_manage_levels', 'core', 'Member Levels', '', '{"route":"admin_default","module":"authorization","controller":"level"}', 'core_admin_main_manage', '', 1, 0, 2),
(19, 'core_admin_main_manage_networks', 'network', 'Networks', '', '{"route":"admin_default","module":"network","controller":"manage"}', 'core_admin_main_manage', '', 1, 0, 3),
(20, 'core_admin_main_manage_announcements', 'announcement', 'Announcements', '', '{"route":"admin_default","module":"announcement","controller":"manage"}', 'core_admin_main_manage', '', 1, 0, 4),
(21, 'core_admin_message_mail', 'core', 'Email All Members', '', '{"route":"admin_default","module":"core","controller":"message","action":"mail"}', 'core_admin_main_manage', '', 1, 0, 5),
(22, 'core_admin_main_manage_reports', 'core', 'Abuse Reports', '', '{"route":"admin_default","module":"core","controller":"report"}', 'core_admin_main_manage', '', 1, 0, 6),
(23, 'core_admin_main_manage_packages', 'core', 'Packages & Plugins', '', '{"route":"admin_default","module":"core","controller":"packages"}', 'core_admin_main_manage', '', 1, 0, 7),
(24, 'core_admin_main_settings_general', 'core', 'General Settings', '', '{"route":"core_admin_settings","action":"general"}', 'core_admin_main_settings', '', 1, 0, 1),
(25, 'core_admin_main_settings_locale', 'core', 'Locale Settings', '', '{"route":"core_admin_settings","action":"locale"}', 'core_admin_main_settings', '', 1, 0, 1),
(26, 'core_admin_main_settings_fields', 'fields', 'Profile Questions', '', '{"route":"admin_default","module":"user","controller":"fields"}', 'core_admin_main_settings', '', 1, 0, 2),
(27, 'core_admin_main_wibiya', 'core', 'Wibiya Integration', '', '{"route":"admin_default", "action":"wibiya", "controller":"settings", "module":"core"}', 'core_admin_main_settings', '', 1, 0, 4),
(28, 'core_admin_main_settings_spam', 'core', 'Spam & Banning Tools', '', '{"route":"core_admin_settings","action":"spam"}', 'core_admin_main_settings', '', 1, 0, 5),
(29, 'core_admin_main_settings_mailtemplates', 'core', 'Mail Templates', '', '{"route":"admin_default","controller":"mail","action":"templates"}', 'core_admin_main_settings', '', 1, 0, 6),
(30, 'core_admin_main_settings_mailsettings', 'core', 'Mail Settings', '', '{"route":"admin_default","controller":"mail","action":"settings"}', 'core_admin_main_settings', '', 1, 0, 7),
(31, 'core_admin_main_settings_performance', 'core', 'Performance & Caching', '', '{"route":"core_admin_settings","action":"performance"}', 'core_admin_main_settings', '', 1, 0, 8),
(32, 'core_admin_main_settings_password', 'core', 'Admin Password', '', '{"route":"core_admin_settings","action":"password"}', 'core_admin_main_settings', '', 1, 0, 9),
(33, 'core_admin_main_settings_tasks', 'core', 'Task Scheduler', '', '{"route":"admin_default","controller":"tasks"}', 'core_admin_main_settings', '', 1, 0, 10),
(34, 'core_admin_main_layout_content', 'core', 'Layout Editor', '', '{"route":"admin_default","controller":"content"}', 'core_admin_main_layout', '', 1, 0, 1),
(35, 'core_admin_main_layout_themes', 'core', 'Theme Editor', '', '{"route":"admin_default","controller":"themes"}', 'core_admin_main_layout', '', 1, 0, 2),
(36, 'core_admin_main_layout_files', 'core', 'File & Media Manager', '', '{"route":"admin_default","controller":"files"}', 'core_admin_main_layout', '', 1, 0, 3),
(37, 'core_admin_main_layout_language', 'core', 'Language Manager', '', '{"route":"admin_default","controller":"language"}', 'core_admin_main_layout', '', 1, 0, 4),
(38, 'core_admin_main_layout_menus', 'core', 'Menu Editor', '', '{"route":"admin_default","controller":"menus"}', 'core_admin_main_layout', '', 1, 0, 5),
(39, 'core_admin_main_ads_manage', 'core', 'Manage Ad Campaigns', '', '{"route":"admin_default","controller":"ads"}', 'core_admin_main_ads', '', 1, 0, 1),
(40, 'core_admin_main_ads_create', 'core', 'Create New Campaign', '', '{"route":"admin_default","controller":"ads","action":"create"}', 'core_admin_main_ads', '', 1, 0, 2),
(41, 'core_admin_main_ads_affiliate', 'core', 'SE Affiliate Program', '', '{"route":"admin_default","controller":"settings","action":"affiliate"}', 'core_admin_main_ads', '', 1, 0, 3),
(42, 'core_admin_main_ads_viglink', 'core', 'VigLink', '', '{"route":"admin_default","controller":"settings","action":"viglink"}', 'core_admin_main_ads', '', 1, 0, 4),
(43, 'core_admin_main_stats_statistics', 'core', 'Site-wide Statistics', '', '{"route":"admin_default","controller":"stats"}', 'core_admin_main_stats', '', 1, 0, 1),
(44, 'core_admin_main_stats_url', 'core', 'Referring URLs', '', '{"route":"admin_default","controller":"stats","action":"referrers"}', 'core_admin_main_stats', '', 1, 0, 2),
(45, 'core_admin_main_stats_resources', 'core', 'Server Information', '', '{"route":"admin_default","controller":"system"}', 'core_admin_main_stats', '', 1, 0, 3),
(46, 'core_admin_main_stats_logs', 'core', 'Log Browser', '', '{"route":"admin_default","controller":"log","action":"index"}', 'core_admin_main_stats', '', 1, 0, 3),
(47, 'core_admin_banning_general', 'core', 'Spam & Banning Tools', '', '{"route":"core_admin_settings","action":"spam"}', 'core_admin_banning', '', 1, 0, 1),
(48, 'adcampaign_admin_main_edit', 'core', 'Edit Settings', '', '{"route":"admin_default","module":"core","controller":"ads","action":"edit"}', 'adcampaign_admin_main', '', 1, 0, 1),
(49, 'adcampaign_admin_main_manageads', 'core', 'Manage Advertisements', '', '{"route":"admin_default","module":"core","controller":"ads","action":"manageads"}', 'adcampaign_admin_main', '', 1, 0, 2),
(50, 'core_admin_main_settings_activity', 'activity', 'Activity Feed Settings', '', '{"route":"admin_default","module":"activity","controller":"settings","action":"index"}', 'core_admin_main_settings', '', 1, 0, 4),
(51, 'core_admin_main_settings_notifications', 'activity', 'Default Email Notifications', '', '{"route":"admin_default","module":"activity","controller":"settings","action":"notifications"}', 'core_admin_main_settings', '', 1, 0, 11),
(52, 'authorization_admin_main_manage', 'authorization', 'View Member Levels', '', '{"route":"admin_default","module":"authorization","controller":"level"}', 'authorization_admin_main', '', 1, 0, 1),
(53, 'authorization_admin_main_level', 'authorization', 'Member Level Settings', '', '{"route":"admin_default","module":"authorization","controller":"level","action":"edit"}', 'authorization_admin_main', '', 1, 0, 3),
(54, 'authorization_admin_level_main', 'authorization', 'Level Info', '', '{"route":"admin_default","module":"authorization","controller":"level","action":"edit"}', 'authorization_admin_level', '', 1, 0, 1),
(55, 'core_main_user', 'user', 'Members', '', '{"route":"user_general","action":"browse"}', 'core_main', '', 1, 0, 2),
(56, 'core_sitemap_user', 'user', 'Members', '', '{"route":"user_general","action":"browse"}', 'core_sitemap', '', 1, 0, 2),
(57, 'user_home_updates', 'user', 'View Recent Updates', '', '{"route":"recent_activity","icon":"application/modules/User/externals/images/links/updates.png"}', 'user_home', '', 1, 0, 1),
(58, 'user_home_view', 'user', 'View My Profile', 'User_Plugin_Menus', '{"route":"user_profile_self","icon":"application/modules/User/externals/images/links/profile.png"}', 'user_home', '', 1, 0, 2),
(59, 'user_home_edit', 'user', 'Edit My Profile', 'User_Plugin_Menus', '{"route":"user_extended","module":"user","controller":"edit","action":"profile","icon":"application/modules/User/externals/images/links/edit.png"}', 'user_home', '', 1, 0, 3),
(60, 'user_home_friends', 'user', 'Browse Members', '', '{"route":"user_general","controller":"index","action":"browse","icon":"application/modules/User/externals/images/links/search.png"}', 'user_home', '', 1, 0, 4),
(61, 'user_profile_edit', 'user', 'Edit Profile', 'User_Plugin_Menus', '', 'user_profile', '', 1, 0, 1),
(62, 'user_profile_friend', 'user', 'Friends', 'User_Plugin_Menus', '', 'user_profile', '', 1, 0, 3),
(63, 'user_profile_block', 'user', 'Block', 'User_Plugin_Menus', '', 'user_profile', '', 1, 0, 4),
(64, 'user_profile_report', 'user', 'Report User', 'User_Plugin_Menus', '', 'user_profile', '', 1, 0, 5),
(65, 'user_profile_admin', 'user', 'Admin Settings', 'User_Plugin_Menus', '', 'user_profile', '', 1, 0, 9),
(66, 'user_edit_profile', 'user', 'Personal Info', '', '{"route":"user_extended","module":"user","controller":"edit","action":"profile"}', 'user_edit', '', 1, 0, 1),
(67, 'user_edit_photo', 'user', 'Edit My Photo', '', '{"route":"user_extended","module":"user","controller":"edit","action":"photo"}', 'user_edit', '', 1, 0, 2),
(68, 'user_edit_style', 'user', 'Profile Style', 'User_Plugin_Menus', '{"route":"user_extended","module":"user","controller":"edit","action":"style"}', 'user_edit', '', 1, 0, 3),
(69, 'user_settings_general', 'user', 'General', '', '{"route":"user_extended","module":"user","controller":"settings","action":"general"}', 'user_settings', '', 1, 0, 1),
(70, 'user_settings_privacy', 'user', 'Privacy', '', '{"route":"user_extended","module":"user","controller":"settings","action":"privacy"}', 'user_settings', '', 1, 0, 2),
(71, 'user_settings_notifications', 'user', 'Notifications', '', '{"route":"user_extended","module":"user","controller":"settings","action":"notifications"}', 'user_settings', '', 1, 0, 3),
(72, 'user_settings_password', 'user', 'Change Password', '', '{"route":"user_extended", "module":"user", "controller":"settings", "action":"password"}', 'user_settings', '', 1, 0, 5),
(73, 'user_settings_delete', 'user', 'Delete Account', 'User_Plugin_Menus::canDelete', '{"route":"user_extended", "module":"user", "controller":"settings", "action":"delete"}', 'user_settings', '', 1, 0, 6),
(74, 'core_admin_main_manage_members', 'user', 'Members', '', '{"route":"admin_default","module":"user","controller":"manage"}', 'core_admin_main_manage', '', 1, 0, 1),
(75, 'core_admin_main_signup', 'user', 'Signup Process', '', '{"route":"admin_default", "controller":"signup", "module":"user"}', 'core_admin_main_settings', '', 1, 0, 3),
(76, 'core_admin_main_facebook', 'user', 'Facebook Integration', '', '{"route":"admin_default", "action":"facebook", "controller":"settings", "module":"user"}', 'core_admin_main_settings', '', 1, 0, 4),
(77, 'core_admin_main_twitter', 'user', 'Twitter Integration', '', '{"route":"admin_default", "action":"twitter", "controller":"settings", "module":"user"}', 'core_admin_main_settings', '', 1, 0, 4),
(78, 'core_admin_main_janrain', 'user', 'Janrain Integration', '', '{"route":"admin_default", "action":"janrain", "controller":"settings", "module":"user"}', 'core_admin_main_settings', '', 1, 0, 4),
(79, 'core_admin_main_settings_friends', 'user', 'Friendship Settings', '', '{"route":"admin_default","module":"user","controller":"settings","action":"friends"}', 'core_admin_main_settings', '', 1, 0, 6),
(80, 'user_admin_banning_logins', 'user', 'Login History', '', '{"route":"admin_default","module":"user","controller":"logins","action":"index"}', 'core_admin_banning', '', 1, 0, 2),
(81, 'authorization_admin_level_user', 'user', 'Members', '', '{"route":"admin_default","module":"user","controller":"settings","action":"level"}', 'authorization_admin_level', '', 1, 0, 2),
(82, 'core_mini_messages', 'messages', 'Messages', 'Messages_Plugin_Menus', '', 'core_mini', '', 1, 0, 4),
(83, 'user_profile_message', 'messages', 'Send Message', 'Messages_Plugin_Menus', '', 'user_profile', '', 1, 0, 2),
(84, 'authorization_admin_level_messages', 'messages', 'Messages', '', '{"route":"admin_default","module":"messages","controller":"settings","action":"level"}', 'authorization_admin_level', '', 1, 0, 3),
(85, 'messages_main_inbox', 'messages', 'Inbox', '', '{"route":"messages_general","action":"inbox"}', 'messages_main', '', 1, 0, 1),
(86, 'messages_main_outbox', 'messages', 'Sent Messages', '', '{"route":"messages_general","action":"outbox"}', 'messages_main', '', 1, 0, 2),
(87, 'messages_main_compose', 'messages', 'Compose Message', '', '{"route":"messages_general","action":"compose"}', 'messages_main', '', 1, 0, 3),
(88, 'user_settings_network', 'network', 'Networks', '', '{"route":"user_extended", "module":"user", "controller":"settings", "action":"network"}', 'user_settings', '', 1, 0, 3),
(89, 'core_main_invite', 'invite', 'Invite', 'Invite_Plugin_Menus::canInvite', '{"route":"default","module":"invite"}', 'core_main', '', 1, 0, 1),
(90, 'user_home_invite', 'invite', 'Invite Your Friends', 'Invite_Plugin_Menus::canInvite', '{"route":"default","module":"invite","icon":"application/modules/Invite/externals/images/invite.png"}', 'user_home', '', 1, 0, 5),
(91, 'core_admin_main_settings_storage', 'core', 'Storage System', '', '{"route":"admin_default","module":"storage","controller":"services","action":"index"}', 'core_admin_main_settings', '', 1, 0, 11),
(92, 'user_settings_payment', 'user', 'Subscription', 'Payment_Plugin_Menus', '{"route":"default", "module":"payment", "controller":"settings", "action":"index"}', 'user_settings', '', 1, 0, 4),
(93, 'core_admin_main_payment', 'payment', 'Billing', '', '{"uri":"javascript:void(0);this.blur();"}', 'core_admin_main', 'core_admin_main_payment', 1, 0, 7),
(94, 'core_admin_main_payment_transactions', 'payment', 'Transactions', '', '{"route":"admin_default","module":"payment","controller":"index","action":"index"}', 'core_admin_main_payment', '', 1, 0, 1),
(95, 'core_admin_main_payment_settings', 'payment', 'Settings', '', '{"route":"admin_default","module":"payment","controller":"settings","action":"index"}', 'core_admin_main_payment', '', 1, 0, 2),
(96, 'core_admin_main_payment_gateways', 'payment', 'Gateways', '', '{"route":"admin_default","module":"payment","controller":"gateway","action":"index"}', 'core_admin_main_payment', '', 1, 0, 3),
(97, 'core_admin_main_payment_packages', 'payment', 'Plans', '', '{"route":"admin_default","module":"payment","controller":"package","action":"index"}', 'core_admin_main_payment', '', 1, 0, 4),
(98, 'core_admin_main_payment_subscriptions', 'payment', 'Subscriptions', '', '{"route":"admin_default","module":"payment","controller":"subscription","action":"index"}', 'core_admin_main_payment', '', 1, 0, 5);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_menus`
--

CREATE TABLE IF NOT EXISTS `engine4_core_menus` (
  `id` int(11) unsigned NOT NULL,
  `name` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `type` enum('standard','hidden','custom') CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT 'standard',
  `title` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `order` smallint(3) NOT NULL DEFAULT '999'
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `engine4_core_menus`
--

INSERT INTO `engine4_core_menus` (`id`, `name`, `type`, `title`, `order`) VALUES
(1, 'core_main', 'standard', 'Main Navigation Menu', 1),
(2, 'core_mini', 'standard', 'Mini Navigation Menu', 2),
(3, 'core_footer', 'standard', 'Footer Menu', 3),
(4, 'core_sitemap', 'standard', 'Sitemap', 4),
(5, 'user_home', 'standard', 'Member Home Quick Links Menu', 999),
(6, 'user_profile', 'standard', 'Member Profile Options Menu', 999),
(7, 'user_edit', 'standard', 'Member Edit Profile Navigation Menu', 999),
(8, 'user_browse', 'standard', 'Member Browse Navigation Menu', 999),
(9, 'user_settings', 'standard', 'Member Settings Navigation Menu', 999),
(10, 'messages_main', 'standard', 'Messages Main Navigation Menu', 999);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_migrations`
--

CREATE TABLE IF NOT EXISTS `engine4_core_migrations` (
  `package` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `current` int(10) unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_modules`
--

CREATE TABLE IF NOT EXISTS `engine4_core_modules` (
  `name` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `title` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `version` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `type` enum('core','standard','extra') CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT 'extra'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `engine4_core_modules`
--

INSERT INTO `engine4_core_modules` (`name`, `title`, `description`, `version`, `enabled`, `type`) VALUES
('activity', 'Activity', 'Activity', '4.8.8', 1, 'core'),
('announcement', 'Announcements', 'Announcements', '4.8.0', 1, 'standard'),
('authorization', 'Authorization', 'Authorization', '4.7.0', 1, 'core'),
('core', 'Core', 'Core', '4.8.8', 1, 'core'),
('fields', 'Fields', 'Fields', '4.8.8', 1, 'core'),
('invite', 'Invite', 'Invite', '4.8.7', 1, 'standard'),
('messages', 'Messages', 'Messages', '4.8.7', 1, 'standard'),
('network', 'Networks', 'Networks', '4.8.6', 1, 'standard'),
('payment', 'Payment', 'Payment', '4.8.7', 1, 'standard'),
('storage', 'Storage', 'Storage', '4.8.5', 1, 'core'),
('user', 'Members', 'Members', '4.8.7', 1, 'core');

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_nodes`
--

CREATE TABLE IF NOT EXISTS `engine4_core_nodes` (
  `node_id` int(10) unsigned NOT NULL,
  `signature` char(40) COLLATE utf8_unicode_ci NOT NULL,
  `host` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `ip` varbinary(16) NOT NULL,
  `first_seen` datetime NOT NULL,
  `last_seen` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_pages`
--

CREATE TABLE IF NOT EXISTS `engine4_core_pages` (
  `page_id` int(11) unsigned NOT NULL,
  `name` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `displayname` varchar(128) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `url` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `keywords` text COLLATE utf8_unicode_ci NOT NULL,
  `custom` tinyint(1) NOT NULL DEFAULT '1',
  `fragment` tinyint(1) NOT NULL DEFAULT '0',
  `layout` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `levels` text COLLATE utf8_unicode_ci,
  `provides` text COLLATE utf8_unicode_ci,
  `view_count` int(11) unsigned NOT NULL DEFAULT '0',
  `search` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `engine4_core_pages`
--

INSERT INTO `engine4_core_pages` (`page_id`, `name`, `displayname`, `url`, `title`, `description`, `keywords`, `custom`, `fragment`, `layout`, `levels`, `provides`, `view_count`, `search`) VALUES
(1, 'header', 'Site Header', NULL, '', '', '', 0, 1, '', NULL, 'header-footer', 0, 0),
(2, 'footer', 'Site Footer', NULL, '', '', '', 0, 1, '', NULL, 'header-footer', 0, 0),
(3, 'core_index_index', 'Landing Page', NULL, 'Landing Page', 'This is your site''s landing page.', '', 0, 0, '', NULL, 'no-viewer;no-subject', 0, 0),
(4, 'user_index_home', 'Member Home Page', NULL, 'Member Home Page', 'This is the home page for members.', '', 0, 0, '', NULL, 'viewer;no-subject', 0, 0),
(5, 'user_profile_index', 'Member Profile', NULL, 'Member Profile', 'This is a member''s profile.', '', 0, 0, '', NULL, 'subject=user', 0, 0),
(6, 'core_help_contact', 'Contact Page', NULL, 'Contact Us', 'This is the contact page', '', 0, 0, '', NULL, 'no-viewer;no-subject', 0, 0),
(7, 'core_help_privacy', 'Privacy Page', NULL, 'Privacy Policy', 'This is the privacy policy page', '', 0, 0, '', NULL, 'no-viewer;no-subject', 0, 0),
(8, 'core_help_terms', 'Terms of Service Page', NULL, 'Terms of Service', 'This is the terms of service page', '', 0, 0, '', NULL, 'no-viewer;no-subject', 0, 0),
(9, 'core_error_requireuser', 'Sign-in Required Page', NULL, 'Sign-in Required', '', '', 0, 0, '', NULL, NULL, 0, 0),
(10, 'core_search_index', 'Search Page', NULL, 'Searc', '', '', 0, 0, '', NULL, NULL, 0, 0),
(11, 'user_auth_login', 'Sign-in Page', NULL, 'Sign-in', 'This is the site sign-in page.', '', 0, 0, '', NULL, NULL, 0, 0),
(12, 'user_signup_index', 'Sign-up Page', NULL, 'Sign-up', 'This is the site sign-up page.', '', 0, 0, '', NULL, NULL, 0, 0),
(13, 'user_auth_forgot', 'Forgot Password Page', NULL, 'Forgot Password', 'This is the site forgot password page.', '', 0, 0, '', NULL, NULL, 0, 0),
(14, 'user_settings_general', 'User General Settings Page', NULL, 'General', 'This page is the user general settings page.', '', 0, 0, '', NULL, NULL, 0, 0),
(15, 'user_settings_privacy', 'User Privacy Settings Page', NULL, 'Privacy', 'This page is the user privacy settings page.', '', 0, 0, '', NULL, NULL, 0, 0),
(16, 'user_settings_network', 'User Networks Settings Page', NULL, 'Networks', 'This page is the user networks settings page.', '', 0, 0, '', NULL, NULL, 0, 0),
(17, 'user_settings_notifications', 'User Notifications Settings Page', NULL, 'Notifications', 'This page is the user notification settings page.', '', 0, 0, '', NULL, NULL, 0, 0),
(18, 'user_settings_password', 'User Change Password Settings Page', NULL, 'Change Password', 'This page is the change password page.', '', 0, 0, '', NULL, NULL, 0, 0),
(19, 'user_settings_delete', 'User Delete Account Settings Page', NULL, 'Delete Account', 'This page is the delete accout page.', '', 0, 0, '', NULL, NULL, 0, 0),
(20, 'user_index_browse', 'Member Browse Page', NULL, 'Member Browse', 'This page show member lists.', '', 0, 0, '', NULL, NULL, 0, 0),
(21, 'invite_index_index', 'Invite Page', NULL, 'Invite', '', '', 0, 0, '', NULL, NULL, 0, 0),
(22, 'messages_messages_compose', 'Messages Compose Page', NULL, 'Compose', '', '', 0, 0, '', NULL, NULL, 0, 0),
(23, 'messages_messages_inbox', 'Messages Inbox Page', NULL, 'Inbox', '', '', 0, 0, '', NULL, NULL, 0, 0),
(24, 'messages_messages_outbox', 'Messages Outbox Page', NULL, 'Inbox', '', '', 0, 0, '', NULL, NULL, 0, 0),
(25, 'messages_messages_search', 'Messages Search Page', NULL, 'Search', '', '', 0, 0, '', NULL, NULL, 0, 0),
(26, 'messages_messages_view', 'Messages View Page', NULL, 'My Message', '', '', 0, 0, '', NULL, NULL, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_processes`
--

CREATE TABLE IF NOT EXISTS `engine4_core_processes` (
  `pid` int(10) unsigned NOT NULL,
  `parent_pid` int(10) unsigned NOT NULL DEFAULT '0',
  `system_pid` int(10) unsigned NOT NULL DEFAULT '0',
  `started` int(10) unsigned NOT NULL,
  `timeout` mediumint(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_referrers`
--

CREATE TABLE IF NOT EXISTS `engine4_core_referrers` (
  `host` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `path` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `query` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `value` int(11) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_reports`
--

CREATE TABLE IF NOT EXISTS `engine4_core_reports` (
  `report_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `category` varchar(16) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `subject_type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `subject_id` int(11) NOT NULL,
  `creation_date` datetime NOT NULL,
  `read` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_routes`
--

CREATE TABLE IF NOT EXISTS `engine4_core_routes` (
  `name` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `config` text COLLATE utf8_unicode_ci NOT NULL,
  `order` smallint(6) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_search`
--

CREATE TABLE IF NOT EXISTS `engine4_core_search` (
  `type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `id` int(11) unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `keywords` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `hidden` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_serviceproviders`
--

CREATE TABLE IF NOT EXISTS `engine4_core_serviceproviders` (
  `serviceprovider_id` int(10) unsigned NOT NULL,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `name` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `class` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `engine4_core_serviceproviders`
--

INSERT INTO `engine4_core_serviceproviders` (`serviceprovider_id`, `title`, `type`, `name`, `class`, `enabled`) VALUES
(1, 'MySQL', 'database', 'mysql', 'Engine_ServiceLocator_Plugin_Database_Mysql', 1),
(2, 'PDO MySQL', 'database', 'mysql_pdo', 'Engine_ServiceLocator_Plugin_Database_MysqlPdo', 1),
(3, 'MySQLi', 'database', 'mysqli', 'Engine_ServiceLocator_Plugin_Database_Mysqli', 1),
(4, 'File', 'cache', 'file', 'Engine_ServiceLocator_Plugin_Cache_File', 1),
(5, 'APC', 'cache', 'apc', 'Engine_ServiceLocator_Plugin_Cache_Apc', 1),
(6, 'Memcache', 'cache', 'memcached', 'Engine_ServiceLocator_Plugin_Cache_Memcached', 1),
(7, 'Simple', 'captcha', 'image', 'Engine_ServiceLocator_Plugin_Captcha_Image', 1),
(8, 'ReCaptcha', 'captcha', 'recaptcha', 'Engine_ServiceLocator_Plugin_Captcha_Recaptcha', 1),
(9, 'SMTP', 'mail', 'smtp', 'Engine_ServiceLocator_Plugin_Mail_Smtp', 1),
(10, 'Sendmail', 'mail', 'sendmail', 'Engine_ServiceLocator_Plugin_Mail_Sendmail', 1),
(11, 'GD', 'image', 'gd', 'Engine_ServiceLocator_Plugin_Image_Gd', 1),
(12, 'Imagick', 'image', 'imagick', 'Engine_ServiceLocator_Plugin_Image_Imagick', 1),
(13, 'Akismet', 'akismet', 'standard', 'Engine_ServiceLocator_Plugin_Akismet', 1);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_services`
--

CREATE TABLE IF NOT EXISTS `engine4_core_services` (
  `service_id` int(10) unsigned NOT NULL,
  `type` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `name` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `profile` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT 'default',
  `config` text COLLATE utf8_unicode_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_servicetypes`
--

CREATE TABLE IF NOT EXISTS `engine4_core_servicetypes` (
  `servicetype_id` int(10) unsigned NOT NULL,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `interface` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `engine4_core_servicetypes`
--

INSERT INTO `engine4_core_servicetypes` (`servicetype_id`, `title`, `type`, `interface`, `enabled`) VALUES
(1, 'Database', 'database', 'Zend_Db_Adapter_Abstract', 1),
(2, 'Cache', 'cache', 'Zend_Cache_Backend', 1),
(3, 'Captcha', 'captcha', 'Zend_Captcha_Adapter', 1),
(4, 'Mail Transport', 'mail', 'Zend_Mail_Transport_Abstract', 1),
(5, 'Image', 'image', 'Engine_Image_Adapter_Abstract', 1),
(6, 'Akismet', 'akismet', 'Zend_Service_Akismet', 1);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_session`
--

CREATE TABLE IF NOT EXISTS `engine4_core_session` (
  `id` char(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `modified` int(11) DEFAULT NULL,
  `lifetime` int(11) DEFAULT NULL,
  `data` text COLLATE utf8_unicode_ci,
  `user_id` int(10) unsigned DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `engine4_core_session`
--

INSERT INTO `engine4_core_session` (`id`, `modified`, `lifetime`, `data`, `user_id`) VALUES
('2a8ae09c9bc57081966f9f7363273f6d', 1432058131, 86400, 'Zend_Auth|a:1:{s:7:"storage";i:1;}', NULL),
('fugvoe0qb1o80gi2t57g54o8t5', 1432058788, 86400, '', NULL),
('m8bvd729npg7sdjtj82315lv96', 1432058549, 86400, '', NULL),
('o0n5r3v4las3tqu47pqcfljl85', 1432058817, 86400, 'redirectURL|s:23:"/Tarfee/index.php/login";ActivityFormToken|a:1:{s:5:"token";s:32:"2f7f53d98b3823e79610c86f9c2e70a2";}Zend_Auth|a:1:{s:7:"storage";i:1;}login_id|s:1:"1";twitter_lock|i:1;twitter_uid|b:0;', 1),
('pgd9e5v4uc06rvrnp07o08jrc7', 1432058256, 86400, '', NULL),
('rjrfmmcj3u82ppf8m7v1m18ne1', 1432058139, 86400, '', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_settings`
--

CREATE TABLE IF NOT EXISTS `engine4_core_settings` (
  `name` varchar(255) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `value` longtext COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `engine4_core_settings`
--

INSERT INTO `engine4_core_settings` (`name`, `value`) VALUES
('activity.content', 'everyone'),
('activity.disallowed', 'N'),
('activity.filter', '1'),
('activity.length', '15'),
('activity.liveupdate', '120000'),
('activity.publish', '1'),
('activity.userdelete', '1'),
('activity.userlength', '5'),
('core.admin.mode', 'none'),
('core.admin.password', ''),
('core.admin.reauthenticate', '0'),
('core.admin.timeout', '600'),
('core.doctype', 'XHTML1_STRICT'),
('core.facebook.enable', 'none'),
('core.facebook.key', ''),
('core.facebook.secret', ''),
('core.general.browse', '1'),
('core.general.commenthtml', ''),
('core.general.notificationupdate', '120000'),
('core.general.portal', '1'),
('core.general.profile', '1'),
('core.general.quota', '0'),
('core.general.search', '1'),
('core.general.site.title', 'Tarfee'),
('core.license.email', 'email@domain.com'),
('core.license.key', '2595-4179-5245-0200'),
('core.license.statistics', '1'),
('core.locale.locale', 'auto'),
('core.locale.timezone', 'US/Pacific'),
('core.log.adapter', 'file'),
('core.mail.count', '25'),
('core.mail.enabled', '1'),
('core.mail.from', 'email@domain.com'),
('core.mail.name', 'Site Admin'),
('core.mail.queueing', '1'),
('core.secret', '32eb05c09aff3a918d5c5f5428e9a8efdda72b9a'),
('core.site.counter', '2'),
('core.site.creation', '2015-05-19 17:48:58'),
('core.site.title', 'Social Network'),
('core.spam.censor', ''),
('core.spam.comment', '0'),
('core.spam.contact', '0'),
('core.spam.email.antispam.login', '1'),
('core.spam.email.antispam.signup', '1'),
('core.spam.invite', '0'),
('core.spam.ipbans', ''),
('core.spam.login', '0'),
('core.spam.signup', '0'),
('core.tasks.count', '1'),
('core.tasks.interval', '60'),
('core.tasks.jobs', '3'),
('core.tasks.key', '1eeabf37'),
('core.tasks.last', '1432058788'),
('core.tasks.mode', 'curl'),
('core.tasks.pid', ''),
('core.tasks.processes', '2'),
('core.tasks.time', '120'),
('core.tasks.timeout', '900'),
('core.thumbnails.icon.height', '48'),
('core.thumbnails.icon.mode', 'crop'),
('core.thumbnails.icon.width', '48'),
('core.thumbnails.main.height', '720'),
('core.thumbnails.main.mode', 'resize'),
('core.thumbnails.main.width', '720'),
('core.thumbnails.normal.height', '160'),
('core.thumbnails.normal.mode', 'resize'),
('core.thumbnails.normal.width', '140'),
('core.thumbnails.profile.height', '400'),
('core.thumbnails.profile.mode', 'resize'),
('core.thumbnails.profile.width', '200'),
('core.translate.adapter', 'csv'),
('core.twitter.enable', 'none'),
('core.twitter.key', ''),
('core.twitter.secret', ''),
('invite.allowCustomMessage', '1'),
('invite.fromEmail', ''),
('invite.fromName', ''),
('invite.max', '10'),
('invite.message', 'You are being invited to join our social network.'),
('invite.subject', 'Join Us'),
('payment.benefit', 'all'),
('payment.currency', 'USD'),
('payment.secret', '6637ccd60cbb5aa33b366f32f19477a9'),
('storage.service.mirrored.counter', '0'),
('storage.service.mirrored.index', '0'),
('storage.service.roundrobin.counter', '0'),
('user.friends.direction', '1'),
('user.friends.eligible', '2'),
('user.friends.lists', '1'),
('user.friends.verification', '1'),
('user.signup.approve', '1'),
('user.signup.checkemail', '1'),
('user.signup.inviteonly', '0'),
('user.signup.random', '0'),
('user.signup.terms', '1'),
('user.signup.username', '1'),
('user.signup.verifyemail', '0'),
('user.support.links', '1');

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_statistics`
--

CREATE TABLE IF NOT EXISTS `engine4_core_statistics` (
  `type` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `date` datetime NOT NULL,
  `value` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `engine4_core_statistics`
--

INSERT INTO `engine4_core_statistics` (`type`, `date`, `value`) VALUES
('core.views', '2015-05-19 17:00:00', 3),
('core.views', '2015-05-19 18:00:00', 2),
('user.logins', '2015-05-19 17:00:00', 1);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_status`
--

CREATE TABLE IF NOT EXISTS `engine4_core_status` (
  `status_id` int(11) unsigned NOT NULL,
  `resource_type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `resource_id` int(11) unsigned NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `creation_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_styles`
--

CREATE TABLE IF NOT EXISTS `engine4_core_styles` (
  `type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `id` int(11) unsigned NOT NULL,
  `style` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_tagmaps`
--

CREATE TABLE IF NOT EXISTS `engine4_core_tagmaps` (
  `tagmap_id` int(11) unsigned NOT NULL,
  `resource_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `resource_id` int(11) unsigned NOT NULL,
  `tagger_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `tagger_id` int(11) unsigned NOT NULL,
  `tag_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `tag_id` int(11) unsigned NOT NULL,
  `creation_date` datetime DEFAULT NULL,
  `extra` text COLLATE utf8_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_tags`
--

CREATE TABLE IF NOT EXISTS `engine4_core_tags` (
  `tag_id` int(11) unsigned NOT NULL,
  `text` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_tasks`
--

CREATE TABLE IF NOT EXISTS `engine4_core_tasks` (
  `task_id` int(11) unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `module` varchar(128) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `plugin` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `timeout` int(11) unsigned NOT NULL DEFAULT '60',
  `processes` smallint(3) unsigned NOT NULL DEFAULT '1',
  `semaphore` smallint(3) NOT NULL DEFAULT '0',
  `started_last` int(11) NOT NULL DEFAULT '0',
  `started_count` int(11) unsigned NOT NULL DEFAULT '0',
  `completed_last` int(11) NOT NULL DEFAULT '0',
  `completed_count` int(11) unsigned NOT NULL DEFAULT '0',
  `failure_last` int(11) NOT NULL DEFAULT '0',
  `failure_count` int(11) unsigned NOT NULL DEFAULT '0',
  `success_last` int(11) NOT NULL DEFAULT '0',
  `success_count` int(11) unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `engine4_core_tasks`
--

INSERT INTO `engine4_core_tasks` (`task_id`, `title`, `module`, `plugin`, `timeout`, `processes`, `semaphore`, `started_last`, `started_count`, `completed_last`, `completed_count`, `failure_last`, `failure_count`, `success_last`, `success_count`) VALUES
(1, 'Job Queue', 'core', 'Core_Plugin_Task_Jobs', 5, 1, 0, 1432058788, 4, 1432058788, 4, 0, 0, 1432058788, 4),
(2, 'Background Mailer', 'core', 'Core_Plugin_Task_Mail', 15, 1, 0, 1432058788, 4, 1432058788, 4, 0, 0, 1432058788, 4),
(3, 'Cache Prefetch', 'core', 'Core_Plugin_Task_Prefetch', 300, 1, 0, 1432058549, 2, 1432058549, 2, 0, 0, 1432058549, 2),
(4, 'Statistics', 'core', 'Core_Plugin_Task_Statistics', 43200, 1, 0, 1432058255, 1, 1432058256, 1, 0, 0, 1432058256, 1),
(5, 'Log Rotation', 'core', 'Core_Plugin_Task_LogRotation', 7200, 1, 0, 1432058788, 1, 1432058788, 1, 0, 0, 1432058788, 1),
(6, 'Member Data Maintenance', 'user', 'User_Plugin_Task_Cleanup', 60, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(7, 'Payment Maintenance', 'user', 'Payment_Plugin_Task_Cleanup', 43200, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_core_themes`
--

CREATE TABLE IF NOT EXISTS `engine4_core_themes` (
  `theme_id` int(11) unsigned NOT NULL,
  `name` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `engine4_core_themes`
--

INSERT INTO `engine4_core_themes` (`theme_id`, `name`, `title`, `description`, `active`) VALUES
(1, 'default', 'Default', '', 0),
(2, 'midnight', 'Midnight', '', 0),
(3, 'clean', 'Clean', '', 0),
(4, 'modern', 'Modern', '', 0),
(5, 'bamboo', 'Bamboo', '', 0),
(6, 'digita', 'Digita', '', 0),
(7, 'grid-blue', 'Grid Blue', '', 0),
(8, 'grid-brown', 'Grid Brown', '', 0),
(9, 'grid-dark', 'Grid Dark', '', 0),
(10, 'grid-gray', 'Grid Gray', '', 0),
(11, 'grid-green', 'Grid Green', '', 0),
(12, 'grid-pink', 'Grid Pink', '', 0),
(13, 'grid-purple', 'Grid Purple', '', 0),
(14, 'grid-red', 'Grid Red', '', 0),
(15, 'kandy-cappuccino', 'Kandy Cappuccino', '', 0),
(16, 'kandy-limeorange', 'Kandy Limeorange', '', 0),
(17, 'kandy-mangoberry', 'Kandy Mangoberry', '', 0),
(18, 'kandy-watermelon', 'Kandy Watermelon', '', 0),
(19, 'musicbox-blue', 'Musicbox Blue', '', 0),
(20, 'musicbox-brown', 'Musicbox Brown', '', 0),
(21, 'musicbox-gray', 'Musicbox Gray', '', 0),
(22, 'musicbox-green', 'Musicbox Green', '', 0),
(23, 'musicbox-pink', 'Musicbox Pink', '', 0),
(24, 'musicbox-purple', 'Musicbox Purple', '', 0),
(25, 'musicbox-red', 'Musicbox Red', '', 0),
(26, 'musicbox-yellow', 'Musicbox Yellow', '', 0),
(27, 'quantum-beige', 'Quantum Beige', '', 0),
(28, 'quantum-blue', 'Quantum Blue', '', 1),
(29, 'quantum-gray', 'Quantum Gray', '', 0),
(30, 'quantum-green', 'Quantum Green', '', 0),
(31, 'quantum-orange', 'Quantum Orange', '', 0),
(32, 'quantum-pink', 'Quantum Pink', '', 0),
(33, 'quantum-purple', 'Quantum Purple', '', 0),
(34, 'quantum-red', 'Quantum Red', '', 0),
(35, 'slipstream', 'Slipstream', '', 0),
(36, 'snowbot', 'Snowbot', '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_invites`
--

CREATE TABLE IF NOT EXISTS `engine4_invites` (
  `id` int(10) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `recipient` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `code` varchar(255) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `send_request` int(11) NOT NULL,
  `timestamp` datetime NOT NULL,
  `message` text COLLATE utf8_unicode_ci NOT NULL,
  `new_user_id` int(11) unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_messages_conversations`
--

CREATE TABLE IF NOT EXISTS `engine4_messages_conversations` (
  `conversation_id` int(11) unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `user_id` int(11) unsigned NOT NULL,
  `recipients` int(11) unsigned NOT NULL,
  `modified` datetime NOT NULL,
  `locked` tinyint(1) NOT NULL DEFAULT '0',
  `resource_type` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT '',
  `resource_id` int(11) unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_messages_messages`
--

CREATE TABLE IF NOT EXISTS `engine4_messages_messages` (
  `message_id` int(11) unsigned NOT NULL,
  `conversation_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `date` datetime NOT NULL,
  `attachment_type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT '',
  `attachment_id` int(11) unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_messages_recipients`
--

CREATE TABLE IF NOT EXISTS `engine4_messages_recipients` (
  `user_id` int(11) unsigned NOT NULL,
  `conversation_id` int(11) unsigned NOT NULL,
  `inbox_message_id` int(11) unsigned DEFAULT NULL,
  `inbox_updated` datetime DEFAULT NULL,
  `inbox_read` tinyint(1) DEFAULT NULL,
  `inbox_deleted` tinyint(1) DEFAULT NULL,
  `outbox_message_id` int(11) unsigned DEFAULT NULL,
  `outbox_updated` datetime DEFAULT NULL,
  `outbox_deleted` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_network_membership`
--

CREATE TABLE IF NOT EXISTS `engine4_network_membership` (
  `resource_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `resource_approved` tinyint(1) NOT NULL DEFAULT '0',
  `user_approved` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_network_networks`
--

CREATE TABLE IF NOT EXISTS `engine4_network_networks` (
  `network_id` int(11) unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `field_id` int(11) unsigned NOT NULL DEFAULT '0',
  `pattern` text COLLATE utf8_unicode_ci,
  `member_count` int(11) unsigned NOT NULL DEFAULT '0',
  `hide` tinyint(1) NOT NULL DEFAULT '0',
  `assignment` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `engine4_network_networks`
--

INSERT INTO `engine4_network_networks` (`network_id`, `title`, `description`, `field_id`, `pattern`, `member_count`, `hide`, `assignment`) VALUES
(1, 'North America', '', 0, NULL, 0, 0, 0),
(2, 'South America', '', 0, NULL, 0, 0, 0),
(3, 'Europe', '', 0, NULL, 0, 0, 0),
(4, 'Asia', '', 0, NULL, 0, 0, 0),
(5, 'Africa', '', 0, NULL, 0, 0, 0),
(6, 'Australia', '', 0, NULL, 0, 0, 0),
(7, 'Antarctica', '', 0, NULL, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_payment_gateways`
--

CREATE TABLE IF NOT EXISTS `engine4_payment_gateways` (
  `gateway_id` int(10) unsigned NOT NULL,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `plugin` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `config` mediumblob,
  `test_mode` tinyint(1) unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `engine4_payment_gateways`
--

INSERT INTO `engine4_payment_gateways` (`gateway_id`, `title`, `description`, `enabled`, `plugin`, `config`, `test_mode`) VALUES
(1, '2Checkout', NULL, 0, 'Payment_Plugin_Gateway_2Checkout', NULL, 0),
(2, 'PayPal', NULL, 0, 'Payment_Plugin_Gateway_PayPal', NULL, 0),
(3, 'Testing', NULL, 0, 'Payment_Plugin_Gateway_Testing', NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_payment_orders`
--

CREATE TABLE IF NOT EXISTS `engine4_payment_orders` (
  `order_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `gateway_id` int(10) unsigned NOT NULL,
  `gateway_order_id` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `gateway_transaction_id` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `state` enum('pending','cancelled','failed','incomplete','complete') CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT 'pending',
  `creation_date` datetime NOT NULL,
  `source_type` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `source_id` int(10) unsigned DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_payment_packages`
--

CREATE TABLE IF NOT EXISTS `engine4_payment_packages` (
  `package_id` int(10) unsigned NOT NULL,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `level_id` int(10) unsigned NOT NULL,
  `downgrade_level_id` int(10) unsigned NOT NULL DEFAULT '0',
  `price` decimal(16,2) unsigned NOT NULL,
  `recurrence` int(11) unsigned NOT NULL,
  `recurrence_type` enum('day','week','month','year','forever') COLLATE utf8_unicode_ci NOT NULL,
  `duration` int(11) unsigned NOT NULL,
  `duration_type` enum('day','week','month','year','forever') COLLATE utf8_unicode_ci NOT NULL,
  `trial_duration` int(11) unsigned NOT NULL DEFAULT '0',
  `trial_duration_type` enum('day','week','month','year','forever') COLLATE utf8_unicode_ci DEFAULT NULL,
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `signup` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `after_signup` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `default` tinyint(1) unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_payment_products`
--

CREATE TABLE IF NOT EXISTS `engine4_payment_products` (
  `product_id` int(10) unsigned NOT NULL,
  `extension_type` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `extension_id` int(10) unsigned DEFAULT NULL,
  `sku` bigint(20) unsigned NOT NULL,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `price` decimal(16,2) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_payment_subscriptions`
--

CREATE TABLE IF NOT EXISTS `engine4_payment_subscriptions` (
  `subscription_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `package_id` int(11) unsigned NOT NULL,
  `status` enum('initial','trial','pending','active','cancelled','expired','overdue','refunded') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'initial',
  `active` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `creation_date` datetime NOT NULL,
  `modified_date` datetime DEFAULT NULL,
  `payment_date` datetime DEFAULT NULL,
  `expiration_date` datetime DEFAULT NULL,
  `notes` text COLLATE utf8_unicode_ci,
  `gateway_id` int(10) unsigned DEFAULT NULL,
  `gateway_profile_id` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_payment_transactions`
--

CREATE TABLE IF NOT EXISTS `engine4_payment_transactions` (
  `transaction_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `gateway_id` int(10) unsigned NOT NULL,
  `timestamp` datetime NOT NULL,
  `order_id` int(10) unsigned NOT NULL DEFAULT '0',
  `type` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `state` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `gateway_transaction_id` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `gateway_parent_transaction_id` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `gateway_order_id` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `amount` decimal(16,2) NOT NULL,
  `currency` char(3) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_storage_chunks`
--

CREATE TABLE IF NOT EXISTS `engine4_storage_chunks` (
  `chunk_id` bigint(20) unsigned NOT NULL,
  `file_id` int(11) unsigned NOT NULL,
  `data` blob NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_storage_files`
--

CREATE TABLE IF NOT EXISTS `engine4_storage_files` (
  `file_id` int(10) unsigned NOT NULL,
  `parent_file_id` int(10) unsigned DEFAULT NULL,
  `type` varchar(16) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `parent_type` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `creation_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  `service_id` int(10) unsigned NOT NULL DEFAULT '1',
  `storage_path` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `extension` varchar(8) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mime_major` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `mime_minor` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `size` bigint(20) unsigned NOT NULL,
  `hash` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_storage_mirrors`
--

CREATE TABLE IF NOT EXISTS `engine4_storage_mirrors` (
  `file_id` bigint(20) unsigned NOT NULL,
  `service_id` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_storage_services`
--

CREATE TABLE IF NOT EXISTS `engine4_storage_services` (
  `service_id` int(10) unsigned NOT NULL,
  `servicetype_id` int(10) unsigned NOT NULL,
  `config` text CHARACTER SET latin1 COLLATE latin1_general_ci,
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `default` tinyint(1) unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `engine4_storage_services`
--

INSERT INTO `engine4_storage_services` (`service_id`, `servicetype_id`, `config`, `enabled`, `default`) VALUES
(1, 1, NULL, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_storage_servicetypes`
--

CREATE TABLE IF NOT EXISTS `engine4_storage_servicetypes` (
  `servicetype_id` int(10) unsigned NOT NULL,
  `title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `plugin` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `form` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `engine4_storage_servicetypes`
--

INSERT INTO `engine4_storage_servicetypes` (`servicetype_id`, `title`, `plugin`, `form`, `enabled`) VALUES
(1, 'Local Storage', 'Storage_Service_Local', 'Storage_Form_Admin_Service_Local', 1),
(2, 'Database Storage', 'Storage_Service_Db', 'Storage_Form_Admin_Service_Db', 0),
(3, 'Amazon S3', 'Storage_Service_S3', 'Storage_Form_Admin_Service_S3', 1),
(4, 'Virtual File System', 'Storage_Service_Vfs', 'Storage_Form_Admin_Service_Vfs', 1),
(5, 'Round-Robin', 'Storage_Service_RoundRobin', 'Storage_Form_Admin_Service_RoundRobin', 0),
(6, 'Mirrored', 'Storage_Service_Mirrored', 'Storage_Form_Admin_Service_Mirrored', 0);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_users`
--

CREATE TABLE IF NOT EXISTS `engine4_users` (
  `user_id` int(11) unsigned NOT NULL,
  `email` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `username` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `displayname` varchar(128) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `photo_id` int(11) unsigned NOT NULL DEFAULT '0',
  `status` text COLLATE utf8_unicode_ci,
  `status_date` datetime DEFAULT NULL,
  `password` char(32) COLLATE utf8_unicode_ci NOT NULL,
  `salt` char(64) COLLATE utf8_unicode_ci NOT NULL,
  `locale` varchar(16) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT 'auto',
  `language` varchar(8) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT 'en_US',
  `timezone` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT 'America/Los_Angeles',
  `search` tinyint(1) NOT NULL DEFAULT '1',
  `show_profileviewers` tinyint(1) NOT NULL DEFAULT '1',
  `level_id` int(11) unsigned NOT NULL,
  `invites_used` int(11) unsigned NOT NULL DEFAULT '0',
  `extra_invites` int(11) unsigned NOT NULL DEFAULT '0',
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `verified` tinyint(1) NOT NULL DEFAULT '0',
  `approved` tinyint(1) NOT NULL DEFAULT '1',
  `creation_date` datetime NOT NULL,
  `creation_ip` varbinary(16) NOT NULL,
  `modified_date` datetime NOT NULL,
  `lastlogin_date` datetime DEFAULT NULL,
  `lastlogin_ip` varbinary(16) DEFAULT NULL,
  `update_date` int(11) DEFAULT NULL,
  `member_count` smallint(5) unsigned NOT NULL DEFAULT '0',
  `view_count` int(11) unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `engine4_users`
--

INSERT INTO `engine4_users` (`user_id`, `email`, `username`, `displayname`, `photo_id`, `status`, `status_date`, `password`, `salt`, `locale`, `language`, `timezone`, `search`, `show_profileviewers`, `level_id`, `invites_used`, `extra_invites`, `enabled`, `verified`, `approved`, `creation_date`, `creation_ip`, `modified_date`, `lastlogin_date`, `lastlogin_ip`, `update_date`, `member_count`, `view_count`) VALUES
(1, 'minhnc@younetco.com', 'minhnc', 'minhnc', 0, NULL, NULL, '47c3e8fc96c8f5c52393f2fc069aaacb', '3926124', 'auto', 'en_US', 'Asia/Krasnoyarsk', 1, 1, 1, 0, 0, 1, 1, 1, '2015-05-19 17:55:31', '', '0000-00-00 00:00:00', '2015-05-19 17:55:50', 0x00000000000000000000000000000001, NULL, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_user_block`
--

CREATE TABLE IF NOT EXISTS `engine4_user_block` (
  `user_id` int(11) unsigned NOT NULL,
  `blocked_user_id` int(11) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_user_facebook`
--

CREATE TABLE IF NOT EXISTS `engine4_user_facebook` (
  `user_id` int(11) unsigned NOT NULL,
  `facebook_uid` bigint(20) unsigned NOT NULL,
  `access_token` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `code` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `expires` bigint(20) unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_user_fields_maps`
--

CREATE TABLE IF NOT EXISTS `engine4_user_fields_maps` (
  `field_id` int(11) unsigned NOT NULL,
  `option_id` int(11) unsigned NOT NULL,
  `child_id` int(11) unsigned NOT NULL,
  `order` smallint(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `engine4_user_fields_maps`
--

INSERT INTO `engine4_user_fields_maps` (`field_id`, `option_id`, `child_id`, `order`) VALUES
(0, 0, 1, 1),
(1, 1, 2, 2),
(1, 1, 3, 3),
(1, 1, 4, 4),
(1, 1, 5, 5),
(1, 1, 6, 6),
(1, 1, 7, 7),
(1, 1, 8, 8),
(1, 1, 9, 9),
(1, 1, 10, 10),
(1, 1, 11, 11),
(1, 1, 12, 12),
(1, 1, 13, 13);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_user_fields_meta`
--

CREATE TABLE IF NOT EXISTS `engine4_user_fields_meta` (
  `field_id` int(11) unsigned NOT NULL,
  `type` varchar(24) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `label` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `alias` varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `display` tinyint(1) unsigned NOT NULL,
  `publish` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `search` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `show` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `order` smallint(3) unsigned NOT NULL DEFAULT '999',
  `config` text COLLATE utf8_unicode_ci,
  `validators` text COLLATE utf8_unicode_ci,
  `filters` text COLLATE utf8_unicode_ci,
  `style` text COLLATE utf8_unicode_ci,
  `error` text COLLATE utf8_unicode_ci
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `engine4_user_fields_meta`
--

INSERT INTO `engine4_user_fields_meta` (`field_id`, `type`, `label`, `description`, `alias`, `required`, `display`, `publish`, `search`, `show`, `order`, `config`, `validators`, `filters`, `style`, `error`) VALUES
(1, 'profile_type', 'Profile Type', '', 'profile_type', 1, 0, 0, 2, 1, 999, '', NULL, NULL, NULL, NULL),
(2, 'heading', 'Personal Information', '', '', 0, 1, 0, 0, 1, 999, '', NULL, NULL, NULL, NULL),
(3, 'first_name', 'First Name', '', 'first_name', 1, 1, 0, 2, 1, 999, '', '[["StringLength",false,[1,32]]]', NULL, NULL, NULL),
(4, 'last_name', 'Last Name', '', 'last_name', 1, 1, 0, 2, 1, 999, '', '[["StringLength",false,[1,32]]]', NULL, NULL, NULL),
(5, 'gender', 'Gender', '', 'gender', 0, 1, 0, 1, 1, 999, '', NULL, NULL, NULL, NULL),
(6, 'birthdate', 'Birthday', '', 'birthdate', 0, 1, 0, 1, 1, 999, '', NULL, NULL, NULL, NULL),
(7, 'heading', 'Contact Information', '', '', 0, 1, 0, 0, 1, 999, '', NULL, NULL, NULL, NULL),
(8, 'website', 'Website', '', '', 0, 1, 0, 0, 1, 999, '', NULL, NULL, NULL, NULL),
(9, 'twitter', 'Twitter', '', '', 0, 1, 0, 0, 1, 999, '', NULL, NULL, NULL, NULL),
(10, 'facebook', 'Facebook', '', '', 0, 1, 0, 0, 1, 999, '', NULL, NULL, NULL, NULL),
(11, 'aim', 'AIM', '', '', 0, 1, 0, 0, 1, 999, '', NULL, NULL, NULL, NULL),
(12, 'heading', 'Personal Details', '', '', 0, 1, 0, 0, 1, 999, '', NULL, NULL, NULL, NULL),
(13, 'about_me', 'About Me', '', '', 0, 1, 0, 0, 1, 999, '', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_user_fields_options`
--

CREATE TABLE IF NOT EXISTS `engine4_user_fields_options` (
  `option_id` int(11) unsigned NOT NULL,
  `field_id` int(11) unsigned NOT NULL,
  `label` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `order` smallint(6) NOT NULL DEFAULT '999'
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `engine4_user_fields_options`
--

INSERT INTO `engine4_user_fields_options` (`option_id`, `field_id`, `label`, `order`) VALUES
(1, 1, 'Regular Member', 1),
(2, 5, 'Male', 1),
(3, 5, 'Female', 2);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_user_fields_search`
--

CREATE TABLE IF NOT EXISTS `engine4_user_fields_search` (
  `item_id` int(11) unsigned NOT NULL,
  `profile_type` smallint(11) unsigned DEFAULT NULL,
  `first_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `gender` smallint(6) unsigned DEFAULT NULL,
  `birthdate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_user_fields_values`
--

CREATE TABLE IF NOT EXISTS `engine4_user_fields_values` (
  `item_id` int(11) unsigned NOT NULL,
  `field_id` int(11) unsigned NOT NULL,
  `index` smallint(3) unsigned NOT NULL DEFAULT '0',
  `value` text COLLATE utf8_unicode_ci NOT NULL,
  `privacy` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `engine4_user_fields_values`
--

INSERT INTO `engine4_user_fields_values` (`item_id`, `field_id`, `index`, `value`, `privacy`) VALUES
(1, 1, 0, '1', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_user_forgot`
--

CREATE TABLE IF NOT EXISTS `engine4_user_forgot` (
  `user_id` int(11) unsigned NOT NULL,
  `code` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `creation_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_user_janrain`
--

CREATE TABLE IF NOT EXISTS `engine4_user_janrain` (
  `user_id` int(11) unsigned NOT NULL,
  `identifier` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `provider` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_user_listitems`
--

CREATE TABLE IF NOT EXISTS `engine4_user_listitems` (
  `listitem_id` int(11) unsigned NOT NULL,
  `list_id` int(11) unsigned NOT NULL,
  `child_id` int(11) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_user_lists`
--

CREATE TABLE IF NOT EXISTS `engine4_user_lists` (
  `list_id` int(11) unsigned NOT NULL,
  `title` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `owner_id` int(11) unsigned NOT NULL,
  `child_count` int(11) unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_user_logins`
--

CREATE TABLE IF NOT EXISTS `engine4_user_logins` (
  `login_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `email` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ip` varbinary(16) NOT NULL,
  `timestamp` datetime NOT NULL,
  `state` enum('success','no-member','bad-password','disabled','unpaid','third-party','v3-migration','unknown') CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT 'unknown',
  `source` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `engine4_user_logins`
--

INSERT INTO `engine4_user_logins` (`login_id`, `user_id`, `email`, `ip`, `timestamp`, `state`, `source`, `active`) VALUES
(1, 1, 'minhnc@younetco.com', 0x00000000000000000000000000000001, '2015-05-19 17:55:50', 'success', NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_user_membership`
--

CREATE TABLE IF NOT EXISTS `engine4_user_membership` (
  `resource_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `resource_approved` tinyint(1) NOT NULL DEFAULT '0',
  `user_approved` tinyint(1) NOT NULL DEFAULT '0',
  `message` text COLLATE utf8_unicode_ci,
  `description` text COLLATE utf8_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_user_online`
--

CREATE TABLE IF NOT EXISTS `engine4_user_online` (
  `ip` varbinary(16) NOT NULL,
  `user_id` int(11) unsigned NOT NULL DEFAULT '0',
  `active` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `engine4_user_online`
--

INSERT INTO `engine4_user_online` (`ip`, `user_id`, `active`) VALUES
(0x00000000000000000000000000000001, 0, '2015-05-19 18:06:28'),
(0x00000000000000000000000000000001, 1, '2015-05-19 18:06:57');

-- --------------------------------------------------------

--
-- Table structure for table `engine4_user_settings`
--

CREATE TABLE IF NOT EXISTS `engine4_user_settings` (
  `user_id` int(10) unsigned NOT NULL,
  `name` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `value` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_user_signup`
--

CREATE TABLE IF NOT EXISTS `engine4_user_signup` (
  `signup_id` int(11) unsigned NOT NULL,
  `class` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `order` smallint(6) NOT NULL DEFAULT '999',
  `enable` smallint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `engine4_user_signup`
--

INSERT INTO `engine4_user_signup` (`signup_id`, `class`, `order`, `enable`) VALUES
(1, 'User_Plugin_Signup_Account', 1, 1),
(2, 'User_Plugin_Signup_Fields', 2, 1),
(3, 'User_Plugin_Signup_Photo', 3, 1),
(4, 'User_Plugin_Signup_Invite', 4, 0),
(5, 'Payment_Plugin_Signup_Subscription', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `engine4_user_twitter`
--

CREATE TABLE IF NOT EXISTS `engine4_user_twitter` (
  `user_id` int(10) unsigned NOT NULL,
  `twitter_uid` bigint(20) unsigned NOT NULL,
  `twitter_token` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `twitter_secret` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `engine4_user_verify`
--

CREATE TABLE IF NOT EXISTS `engine4_user_verify` (
  `user_id` int(11) unsigned NOT NULL,
  `code` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `engine4_activity_actions`
--
ALTER TABLE `engine4_activity_actions`
  ADD PRIMARY KEY (`action_id`),
  ADD KEY `SUBJECT` (`subject_type`,`subject_id`),
  ADD KEY `OBJECT` (`object_type`,`object_id`);

--
-- Indexes for table `engine4_activity_actionsettings`
--
ALTER TABLE `engine4_activity_actionsettings`
  ADD PRIMARY KEY (`user_id`,`type`);

--
-- Indexes for table `engine4_activity_actiontypes`
--
ALTER TABLE `engine4_activity_actiontypes`
  ADD PRIMARY KEY (`type`);

--
-- Indexes for table `engine4_activity_attachments`
--
ALTER TABLE `engine4_activity_attachments`
  ADD PRIMARY KEY (`attachment_id`),
  ADD KEY `action_id` (`action_id`),
  ADD KEY `type_id` (`type`,`id`);

--
-- Indexes for table `engine4_activity_comments`
--
ALTER TABLE `engine4_activity_comments`
  ADD PRIMARY KEY (`comment_id`),
  ADD KEY `resource_type` (`resource_id`),
  ADD KEY `poster_type` (`poster_type`,`poster_id`);

--
-- Indexes for table `engine4_activity_likes`
--
ALTER TABLE `engine4_activity_likes`
  ADD PRIMARY KEY (`like_id`),
  ADD KEY `resource_id` (`resource_id`),
  ADD KEY `poster_type` (`poster_type`,`poster_id`);

--
-- Indexes for table `engine4_activity_notifications`
--
ALTER TABLE `engine4_activity_notifications`
  ADD PRIMARY KEY (`notification_id`),
  ADD KEY `LOOKUP` (`user_id`,`date`),
  ADD KEY `subject` (`subject_type`,`subject_id`),
  ADD KEY `object` (`object_type`,`object_id`);

--
-- Indexes for table `engine4_activity_notificationsettings`
--
ALTER TABLE `engine4_activity_notificationsettings`
  ADD PRIMARY KEY (`user_id`,`type`);

--
-- Indexes for table `engine4_activity_notificationtypes`
--
ALTER TABLE `engine4_activity_notificationtypes`
  ADD PRIMARY KEY (`type`);

--
-- Indexes for table `engine4_activity_stream`
--
ALTER TABLE `engine4_activity_stream`
  ADD PRIMARY KEY (`target_type`,`target_id`,`action_id`),
  ADD KEY `SUBJECT` (`subject_type`,`subject_id`,`action_id`),
  ADD KEY `OBJECT` (`object_type`,`object_id`,`action_id`);

--
-- Indexes for table `engine4_announcement_announcements`
--
ALTER TABLE `engine4_announcement_announcements`
  ADD PRIMARY KEY (`announcement_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `engine4_authorization_allow`
--
ALTER TABLE `engine4_authorization_allow`
  ADD PRIMARY KEY (`resource_type`,`resource_id`,`action`,`role`,`role_id`);

--
-- Indexes for table `engine4_authorization_levels`
--
ALTER TABLE `engine4_authorization_levels`
  ADD PRIMARY KEY (`level_id`);

--
-- Indexes for table `engine4_authorization_permissions`
--
ALTER TABLE `engine4_authorization_permissions`
  ADD PRIMARY KEY (`level_id`,`type`,`name`);

--
-- Indexes for table `engine4_core_adcampaigns`
--
ALTER TABLE `engine4_core_adcampaigns`
  ADD PRIMARY KEY (`adcampaign_id`);

--
-- Indexes for table `engine4_core_adphotos`
--
ALTER TABLE `engine4_core_adphotos`
  ADD PRIMARY KEY (`adphoto_id`),
  ADD KEY `ad_id` (`ad_id`);

--
-- Indexes for table `engine4_core_ads`
--
ALTER TABLE `engine4_core_ads`
  ADD PRIMARY KEY (`ad_id`),
  ADD KEY `ad_campaign` (`ad_campaign`);

--
-- Indexes for table `engine4_core_auth`
--
ALTER TABLE `engine4_core_auth`
  ADD PRIMARY KEY (`id`,`user_id`),
  ADD KEY `expires` (`expires`);

--
-- Indexes for table `engine4_core_bannedemails`
--
ALTER TABLE `engine4_core_bannedemails`
  ADD PRIMARY KEY (`bannedemail_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `engine4_core_bannedips`
--
ALTER TABLE `engine4_core_bannedips`
  ADD PRIMARY KEY (`bannedip_id`),
  ADD UNIQUE KEY `start` (`start`,`stop`);

--
-- Indexes for table `engine4_core_bannedusernames`
--
ALTER TABLE `engine4_core_bannedusernames`
  ADD PRIMARY KEY (`bannedusername_id`),
  ADD KEY `username` (`username`);

--
-- Indexes for table `engine4_core_bannedwords`
--
ALTER TABLE `engine4_core_bannedwords`
  ADD PRIMARY KEY (`bannedword_id`);

--
-- Indexes for table `engine4_core_comments`
--
ALTER TABLE `engine4_core_comments`
  ADD PRIMARY KEY (`comment_id`),
  ADD KEY `resource_type` (`resource_type`,`resource_id`),
  ADD KEY `poster_type` (`poster_type`,`poster_id`);

--
-- Indexes for table `engine4_core_content`
--
ALTER TABLE `engine4_core_content`
  ADD PRIMARY KEY (`content_id`),
  ADD KEY `page_id` (`page_id`,`order`);

--
-- Indexes for table `engine4_core_geotags`
--
ALTER TABLE `engine4_core_geotags`
  ADD PRIMARY KEY (`geotag_id`),
  ADD KEY `latitude` (`latitude`,`longitude`);

--
-- Indexes for table `engine4_core_jobs`
--
ALTER TABLE `engine4_core_jobs`
  ADD PRIMARY KEY (`job_id`),
  ADD KEY `jobtype_id` (`jobtype_id`),
  ADD KEY `state` (`state`),
  ADD KEY `is_complete` (`is_complete`,`priority`,`job_id`);

--
-- Indexes for table `engine4_core_jobtypes`
--
ALTER TABLE `engine4_core_jobtypes`
  ADD PRIMARY KEY (`jobtype_id`),
  ADD UNIQUE KEY `type` (`type`);

--
-- Indexes for table `engine4_core_languages`
--
ALTER TABLE `engine4_core_languages`
  ADD PRIMARY KEY (`language_id`);

--
-- Indexes for table `engine4_core_likes`
--
ALTER TABLE `engine4_core_likes`
  ADD PRIMARY KEY (`like_id`),
  ADD KEY `resource_type` (`resource_type`,`resource_id`),
  ADD KEY `poster_type` (`poster_type`,`poster_id`);

--
-- Indexes for table `engine4_core_links`
--
ALTER TABLE `engine4_core_links`
  ADD PRIMARY KEY (`link_id`),
  ADD KEY `owner` (`owner_type`,`owner_id`),
  ADD KEY `parent` (`parent_type`,`parent_id`);

--
-- Indexes for table `engine4_core_listitems`
--
ALTER TABLE `engine4_core_listitems`
  ADD PRIMARY KEY (`listitem_id`),
  ADD KEY `list_id` (`list_id`),
  ADD KEY `child_id` (`child_id`);

--
-- Indexes for table `engine4_core_lists`
--
ALTER TABLE `engine4_core_lists`
  ADD PRIMARY KEY (`list_id`),
  ADD KEY `owner_type` (`owner_type`,`owner_id`);

--
-- Indexes for table `engine4_core_log`
--
ALTER TABLE `engine4_core_log`
  ADD PRIMARY KEY (`message_id`),
  ADD KEY `domain` (`domain`,`timestamp`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `engine4_core_mail`
--
ALTER TABLE `engine4_core_mail`
  ADD PRIMARY KEY (`mail_id`),
  ADD KEY `priority` (`priority`);

--
-- Indexes for table `engine4_core_mailrecipients`
--
ALTER TABLE `engine4_core_mailrecipients`
  ADD PRIMARY KEY (`recipient_id`);

--
-- Indexes for table `engine4_core_mailtemplates`
--
ALTER TABLE `engine4_core_mailtemplates`
  ADD PRIMARY KEY (`mailtemplate_id`),
  ADD UNIQUE KEY `type` (`type`);

--
-- Indexes for table `engine4_core_menuitems`
--
ALTER TABLE `engine4_core_menuitems`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `LOOKUP` (`name`,`order`);

--
-- Indexes for table `engine4_core_menus`
--
ALTER TABLE `engine4_core_menus`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `order` (`order`);

--
-- Indexes for table `engine4_core_migrations`
--
ALTER TABLE `engine4_core_migrations`
  ADD PRIMARY KEY (`package`);

--
-- Indexes for table `engine4_core_modules`
--
ALTER TABLE `engine4_core_modules`
  ADD PRIMARY KEY (`name`);

--
-- Indexes for table `engine4_core_nodes`
--
ALTER TABLE `engine4_core_nodes`
  ADD PRIMARY KEY (`node_id`),
  ADD UNIQUE KEY `signature` (`signature`);

--
-- Indexes for table `engine4_core_pages`
--
ALTER TABLE `engine4_core_pages`
  ADD PRIMARY KEY (`page_id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD UNIQUE KEY `url` (`url`);

--
-- Indexes for table `engine4_core_processes`
--
ALTER TABLE `engine4_core_processes`
  ADD PRIMARY KEY (`pid`),
  ADD KEY `name` (`name`);

--
-- Indexes for table `engine4_core_referrers`
--
ALTER TABLE `engine4_core_referrers`
  ADD PRIMARY KEY (`host`,`path`,`query`),
  ADD KEY `value` (`value`);

--
-- Indexes for table `engine4_core_reports`
--
ALTER TABLE `engine4_core_reports`
  ADD PRIMARY KEY (`report_id`),
  ADD KEY `category` (`category`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `read` (`read`);

--
-- Indexes for table `engine4_core_routes`
--
ALTER TABLE `engine4_core_routes`
  ADD PRIMARY KEY (`name`),
  ADD KEY `order` (`order`);

--
-- Indexes for table `engine4_core_search`
--
ALTER TABLE `engine4_core_search`
  ADD PRIMARY KEY (`type`,`id`),
  ADD FULLTEXT KEY `LOOKUP` (`title`,`description`,`keywords`,`hidden`);

--
-- Indexes for table `engine4_core_serviceproviders`
--
ALTER TABLE `engine4_core_serviceproviders`
  ADD PRIMARY KEY (`serviceprovider_id`),
  ADD UNIQUE KEY `type` (`type`,`name`);

--
-- Indexes for table `engine4_core_services`
--
ALTER TABLE `engine4_core_services`
  ADD PRIMARY KEY (`service_id`),
  ADD UNIQUE KEY `type` (`type`,`profile`);

--
-- Indexes for table `engine4_core_servicetypes`
--
ALTER TABLE `engine4_core_servicetypes`
  ADD PRIMARY KEY (`servicetype_id`),
  ADD UNIQUE KEY `type` (`type`);

--
-- Indexes for table `engine4_core_session`
--
ALTER TABLE `engine4_core_session`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `engine4_core_settings`
--
ALTER TABLE `engine4_core_settings`
  ADD PRIMARY KEY (`name`);

--
-- Indexes for table `engine4_core_statistics`
--
ALTER TABLE `engine4_core_statistics`
  ADD PRIMARY KEY (`type`,`date`);

--
-- Indexes for table `engine4_core_status`
--
ALTER TABLE `engine4_core_status`
  ADD PRIMARY KEY (`status_id`);

--
-- Indexes for table `engine4_core_styles`
--
ALTER TABLE `engine4_core_styles`
  ADD PRIMARY KEY (`type`,`id`);

--
-- Indexes for table `engine4_core_tagmaps`
--
ALTER TABLE `engine4_core_tagmaps`
  ADD PRIMARY KEY (`tagmap_id`),
  ADD KEY `resource_type` (`resource_type`,`resource_id`),
  ADD KEY `tagger_type` (`tagger_type`,`tagger_id`),
  ADD KEY `tag_type` (`tag_type`,`tag_id`);

--
-- Indexes for table `engine4_core_tags`
--
ALTER TABLE `engine4_core_tags`
  ADD PRIMARY KEY (`tag_id`),
  ADD UNIQUE KEY `text` (`text`);

--
-- Indexes for table `engine4_core_tasks`
--
ALTER TABLE `engine4_core_tasks`
  ADD PRIMARY KEY (`task_id`),
  ADD UNIQUE KEY `plugin` (`plugin`),
  ADD KEY `module` (`module`),
  ADD KEY `started_last` (`started_last`);

--
-- Indexes for table `engine4_core_themes`
--
ALTER TABLE `engine4_core_themes`
  ADD PRIMARY KEY (`theme_id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `active` (`active`);

--
-- Indexes for table `engine4_invites`
--
ALTER TABLE `engine4_invites`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `recipient` (`recipient`);

--
-- Indexes for table `engine4_messages_conversations`
--
ALTER TABLE `engine4_messages_conversations`
  ADD PRIMARY KEY (`conversation_id`);

--
-- Indexes for table `engine4_messages_messages`
--
ALTER TABLE `engine4_messages_messages`
  ADD PRIMARY KEY (`message_id`),
  ADD UNIQUE KEY `CONVERSATIONS` (`conversation_id`,`message_id`);

--
-- Indexes for table `engine4_messages_recipients`
--
ALTER TABLE `engine4_messages_recipients`
  ADD PRIMARY KEY (`user_id`,`conversation_id`),
  ADD KEY `INBOX_UPDATED` (`user_id`,`conversation_id`,`inbox_updated`),
  ADD KEY `OUTBOX_UPDATED` (`user_id`,`conversation_id`,`outbox_updated`);

--
-- Indexes for table `engine4_network_membership`
--
ALTER TABLE `engine4_network_membership`
  ADD PRIMARY KEY (`resource_id`,`user_id`);

--
-- Indexes for table `engine4_network_networks`
--
ALTER TABLE `engine4_network_networks`
  ADD PRIMARY KEY (`network_id`),
  ADD KEY `assignment` (`assignment`);

--
-- Indexes for table `engine4_payment_gateways`
--
ALTER TABLE `engine4_payment_gateways`
  ADD PRIMARY KEY (`gateway_id`),
  ADD KEY `enabled` (`enabled`);

--
-- Indexes for table `engine4_payment_orders`
--
ALTER TABLE `engine4_payment_orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `gateway_id` (`gateway_id`,`gateway_order_id`),
  ADD KEY `state` (`state`),
  ADD KEY `source_type` (`source_type`,`source_id`);

--
-- Indexes for table `engine4_payment_packages`
--
ALTER TABLE `engine4_payment_packages`
  ADD PRIMARY KEY (`package_id`),
  ADD KEY `level_id` (`level_id`);

--
-- Indexes for table `engine4_payment_products`
--
ALTER TABLE `engine4_payment_products`
  ADD PRIMARY KEY (`product_id`),
  ADD UNIQUE KEY `sku` (`sku`),
  ADD KEY `extension_type` (`extension_type`,`extension_id`);

--
-- Indexes for table `engine4_payment_subscriptions`
--
ALTER TABLE `engine4_payment_subscriptions`
  ADD PRIMARY KEY (`subscription_id`),
  ADD UNIQUE KEY `gateway_id` (`gateway_id`,`gateway_profile_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `package_id` (`package_id`),
  ADD KEY `status` (`status`),
  ADD KEY `active` (`active`);

--
-- Indexes for table `engine4_payment_transactions`
--
ALTER TABLE `engine4_payment_transactions`
  ADD PRIMARY KEY (`transaction_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `gateway_id` (`gateway_id`),
  ADD KEY `type` (`type`),
  ADD KEY `state` (`state`),
  ADD KEY `gateway_transaction_id` (`gateway_transaction_id`),
  ADD KEY `gateway_parent_transaction_id` (`gateway_parent_transaction_id`);

--
-- Indexes for table `engine4_storage_chunks`
--
ALTER TABLE `engine4_storage_chunks`
  ADD PRIMARY KEY (`chunk_id`),
  ADD KEY `file_id` (`file_id`);

--
-- Indexes for table `engine4_storage_files`
--
ALTER TABLE `engine4_storage_files`
  ADD PRIMARY KEY (`file_id`),
  ADD UNIQUE KEY `parent_file_id` (`parent_file_id`,`type`),
  ADD KEY `PARENT` (`parent_type`,`parent_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `service_id` (`service_id`);

--
-- Indexes for table `engine4_storage_mirrors`
--
ALTER TABLE `engine4_storage_mirrors`
  ADD PRIMARY KEY (`file_id`,`service_id`),
  ADD KEY `service_id` (`service_id`);

--
-- Indexes for table `engine4_storage_services`
--
ALTER TABLE `engine4_storage_services`
  ADD PRIMARY KEY (`service_id`);

--
-- Indexes for table `engine4_storage_servicetypes`
--
ALTER TABLE `engine4_storage_servicetypes`
  ADD PRIMARY KEY (`servicetype_id`),
  ADD UNIQUE KEY `plugin` (`plugin`);

--
-- Indexes for table `engine4_users`
--
ALTER TABLE `engine4_users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `EMAIL` (`email`),
  ADD UNIQUE KEY `USERNAME` (`username`),
  ADD KEY `MEMBER_COUNT` (`member_count`),
  ADD KEY `CREATION_DATE` (`creation_date`),
  ADD KEY `search` (`search`),
  ADD KEY `enabled` (`enabled`);

--
-- Indexes for table `engine4_user_block`
--
ALTER TABLE `engine4_user_block`
  ADD PRIMARY KEY (`user_id`,`blocked_user_id`),
  ADD KEY `REVERSE` (`blocked_user_id`);

--
-- Indexes for table `engine4_user_facebook`
--
ALTER TABLE `engine4_user_facebook`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `facebook_uid` (`facebook_uid`);

--
-- Indexes for table `engine4_user_fields_maps`
--
ALTER TABLE `engine4_user_fields_maps`
  ADD PRIMARY KEY (`field_id`,`option_id`,`child_id`);

--
-- Indexes for table `engine4_user_fields_meta`
--
ALTER TABLE `engine4_user_fields_meta`
  ADD PRIMARY KEY (`field_id`);

--
-- Indexes for table `engine4_user_fields_options`
--
ALTER TABLE `engine4_user_fields_options`
  ADD PRIMARY KEY (`option_id`),
  ADD KEY `field_id` (`field_id`);

--
-- Indexes for table `engine4_user_fields_search`
--
ALTER TABLE `engine4_user_fields_search`
  ADD PRIMARY KEY (`item_id`),
  ADD KEY `profile_type` (`profile_type`),
  ADD KEY `first_name` (`first_name`),
  ADD KEY `last_name` (`last_name`),
  ADD KEY `gender` (`gender`),
  ADD KEY `birthdate` (`birthdate`);

--
-- Indexes for table `engine4_user_fields_values`
--
ALTER TABLE `engine4_user_fields_values`
  ADD PRIMARY KEY (`item_id`,`field_id`,`index`);

--
-- Indexes for table `engine4_user_forgot`
--
ALTER TABLE `engine4_user_forgot`
  ADD PRIMARY KEY (`user_id`),
  ADD KEY `code` (`code`);

--
-- Indexes for table `engine4_user_janrain`
--
ALTER TABLE `engine4_user_janrain`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `identifier` (`identifier`);

--
-- Indexes for table `engine4_user_listitems`
--
ALTER TABLE `engine4_user_listitems`
  ADD PRIMARY KEY (`listitem_id`),
  ADD KEY `list_id` (`list_id`),
  ADD KEY `child_id` (`child_id`);

--
-- Indexes for table `engine4_user_lists`
--
ALTER TABLE `engine4_user_lists`
  ADD PRIMARY KEY (`list_id`),
  ADD KEY `owner_id` (`owner_id`);

--
-- Indexes for table `engine4_user_logins`
--
ALTER TABLE `engine4_user_logins`
  ADD PRIMARY KEY (`login_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `email` (`email`),
  ADD KEY `ip` (`ip`);

--
-- Indexes for table `engine4_user_membership`
--
ALTER TABLE `engine4_user_membership`
  ADD PRIMARY KEY (`resource_id`,`user_id`),
  ADD KEY `REVERSE` (`user_id`);

--
-- Indexes for table `engine4_user_online`
--
ALTER TABLE `engine4_user_online`
  ADD PRIMARY KEY (`ip`,`user_id`),
  ADD KEY `LOOKUP` (`active`);

--
-- Indexes for table `engine4_user_settings`
--
ALTER TABLE `engine4_user_settings`
  ADD PRIMARY KEY (`user_id`,`name`);

--
-- Indexes for table `engine4_user_signup`
--
ALTER TABLE `engine4_user_signup`
  ADD PRIMARY KEY (`signup_id`);

--
-- Indexes for table `engine4_user_twitter`
--
ALTER TABLE `engine4_user_twitter`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `twitter_uid` (`twitter_uid`);

--
-- Indexes for table `engine4_user_verify`
--
ALTER TABLE `engine4_user_verify`
  ADD PRIMARY KEY (`user_id`),
  ADD KEY `code` (`code`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `engine4_activity_actions`
--
ALTER TABLE `engine4_activity_actions`
  MODIFY `action_id` int(11) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `engine4_activity_attachments`
--
ALTER TABLE `engine4_activity_attachments`
  MODIFY `attachment_id` int(11) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `engine4_activity_comments`
--
ALTER TABLE `engine4_activity_comments`
  MODIFY `comment_id` int(11) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `engine4_activity_likes`
--
ALTER TABLE `engine4_activity_likes`
  MODIFY `like_id` int(11) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `engine4_activity_notifications`
--
ALTER TABLE `engine4_activity_notifications`
  MODIFY `notification_id` int(11) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `engine4_announcement_announcements`
--
ALTER TABLE `engine4_announcement_announcements`
  MODIFY `announcement_id` int(11) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `engine4_authorization_levels`
--
ALTER TABLE `engine4_authorization_levels`
  MODIFY `level_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `engine4_core_adcampaigns`
--
ALTER TABLE `engine4_core_adcampaigns`
  MODIFY `adcampaign_id` int(11) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `engine4_core_adphotos`
--
ALTER TABLE `engine4_core_adphotos`
  MODIFY `adphoto_id` int(11) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `engine4_core_ads`
--
ALTER TABLE `engine4_core_ads`
  MODIFY `ad_id` int(11) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `engine4_core_bannedemails`
--
ALTER TABLE `engine4_core_bannedemails`
  MODIFY `bannedemail_id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `engine4_core_bannedips`
--
ALTER TABLE `engine4_core_bannedips`
  MODIFY `bannedip_id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `engine4_core_bannedusernames`
--
ALTER TABLE `engine4_core_bannedusernames`
  MODIFY `bannedusername_id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `engine4_core_bannedwords`
--
ALTER TABLE `engine4_core_bannedwords`
  MODIFY `bannedword_id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `engine4_core_comments`
--
ALTER TABLE `engine4_core_comments`
  MODIFY `comment_id` int(11) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `engine4_core_content`
--
ALTER TABLE `engine4_core_content`
  MODIFY `content_id` int(11) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=638;
--
-- AUTO_INCREMENT for table `engine4_core_jobs`
--
ALTER TABLE `engine4_core_jobs`
  MODIFY `job_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `engine4_core_jobtypes`
--
ALTER TABLE `engine4_core_jobtypes`
  MODIFY `jobtype_id` int(11) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `engine4_core_languages`
--
ALTER TABLE `engine4_core_languages`
  MODIFY `language_id` int(11) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `engine4_core_likes`
--
ALTER TABLE `engine4_core_likes`
  MODIFY `like_id` int(11) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `engine4_core_links`
--
ALTER TABLE `engine4_core_links`
  MODIFY `link_id` int(11) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `engine4_core_listitems`
--
ALTER TABLE `engine4_core_listitems`
  MODIFY `listitem_id` int(11) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `engine4_core_lists`
--
ALTER TABLE `engine4_core_lists`
  MODIFY `list_id` int(11) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `engine4_core_log`
--
ALTER TABLE `engine4_core_log`
  MODIFY `message_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `engine4_core_mail`
--
ALTER TABLE `engine4_core_mail`
  MODIFY `mail_id` int(11) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `engine4_core_mailrecipients`
--
ALTER TABLE `engine4_core_mailrecipients`
  MODIFY `recipient_id` int(11) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `engine4_core_mailtemplates`
--
ALTER TABLE `engine4_core_mailtemplates`
  MODIFY `mailtemplate_id` int(11) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=34;
--
-- AUTO_INCREMENT for table `engine4_core_menuitems`
--
ALTER TABLE `engine4_core_menuitems`
  MODIFY `id` int(11) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=99;
--
-- AUTO_INCREMENT for table `engine4_core_menus`
--
ALTER TABLE `engine4_core_menus`
  MODIFY `id` int(11) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `engine4_core_nodes`
--
ALTER TABLE `engine4_core_nodes`
  MODIFY `node_id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `engine4_core_pages`
--
ALTER TABLE `engine4_core_pages`
  MODIFY `page_id` int(11) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=27;
--
-- AUTO_INCREMENT for table `engine4_core_reports`
--
ALTER TABLE `engine4_core_reports`
  MODIFY `report_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `engine4_core_serviceproviders`
--
ALTER TABLE `engine4_core_serviceproviders`
  MODIFY `serviceprovider_id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT for table `engine4_core_services`
--
ALTER TABLE `engine4_core_services`
  MODIFY `service_id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `engine4_core_servicetypes`
--
ALTER TABLE `engine4_core_servicetypes`
  MODIFY `servicetype_id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `engine4_core_status`
--
ALTER TABLE `engine4_core_status`
  MODIFY `status_id` int(11) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `engine4_core_tagmaps`
--
ALTER TABLE `engine4_core_tagmaps`
  MODIFY `tagmap_id` int(11) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `engine4_core_tags`
--
ALTER TABLE `engine4_core_tags`
  MODIFY `tag_id` int(11) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `engine4_core_tasks`
--
ALTER TABLE `engine4_core_tasks`
  MODIFY `task_id` int(11) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `engine4_core_themes`
--
ALTER TABLE `engine4_core_themes`
  MODIFY `theme_id` int(11) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=37;
--
-- AUTO_INCREMENT for table `engine4_invites`
--
ALTER TABLE `engine4_invites`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `engine4_messages_conversations`
--
ALTER TABLE `engine4_messages_conversations`
  MODIFY `conversation_id` int(11) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `engine4_messages_messages`
--
ALTER TABLE `engine4_messages_messages`
  MODIFY `message_id` int(11) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `engine4_network_networks`
--
ALTER TABLE `engine4_network_networks`
  MODIFY `network_id` int(11) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `engine4_payment_gateways`
--
ALTER TABLE `engine4_payment_gateways`
  MODIFY `gateway_id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `engine4_payment_orders`
--
ALTER TABLE `engine4_payment_orders`
  MODIFY `order_id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `engine4_payment_packages`
--
ALTER TABLE `engine4_payment_packages`
  MODIFY `package_id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `engine4_payment_products`
--
ALTER TABLE `engine4_payment_products`
  MODIFY `product_id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `engine4_payment_subscriptions`
--
ALTER TABLE `engine4_payment_subscriptions`
  MODIFY `subscription_id` int(11) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `engine4_payment_transactions`
--
ALTER TABLE `engine4_payment_transactions`
  MODIFY `transaction_id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `engine4_storage_chunks`
--
ALTER TABLE `engine4_storage_chunks`
  MODIFY `chunk_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `engine4_storage_files`
--
ALTER TABLE `engine4_storage_files`
  MODIFY `file_id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `engine4_storage_services`
--
ALTER TABLE `engine4_storage_services`
  MODIFY `service_id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `engine4_storage_servicetypes`
--
ALTER TABLE `engine4_storage_servicetypes`
  MODIFY `servicetype_id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `engine4_users`
--
ALTER TABLE `engine4_users`
  MODIFY `user_id` int(11) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `engine4_user_fields_meta`
--
ALTER TABLE `engine4_user_fields_meta`
  MODIFY `field_id` int(11) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT for table `engine4_user_fields_options`
--
ALTER TABLE `engine4_user_fields_options`
  MODIFY `option_id` int(11) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `engine4_user_listitems`
--
ALTER TABLE `engine4_user_listitems`
  MODIFY `listitem_id` int(11) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `engine4_user_lists`
--
ALTER TABLE `engine4_user_lists`
  MODIFY `list_id` int(11) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `engine4_user_logins`
--
ALTER TABLE `engine4_user_logins`
  MODIFY `login_id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `engine4_user_signup`
--
ALTER TABLE `engine4_user_signup`
  MODIFY `signup_id` int(11) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
