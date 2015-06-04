ALTER TABLE `engine4_blog_blogs` ADD `photo_id` INT(11) NOT NULL DEFAULT '0' AFTER `title`;

INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `order`) VALUES
('blog_main_favoriteblog', 'ynblog', 'My Favourite Blogs', '', '{"route":"blog_general","action":"favorite"}', 'ynblog_main', '', 3);

CREATE TABLE IF NOT EXISTS `engine4_blog_favorites`(
	`favorite_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`blog_id` INT(11) UNSIGNED NOT NULL,
	`user_id` INT(11) UNSIGNED NOT NULL,
	PRIMARY KEY (`favorite_id`),
	KEY `blogId` (`blog_id`),
	KEY `userId` (`user_id`)
	)ENGINE=MyISAM DEFAULT CHARSET=utf8;