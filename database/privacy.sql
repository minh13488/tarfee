ALTER TABLE `engine4_users` ADD `private_contact` TINYINT(1) NOT NULL DEFAULT '0' AFTER `city_id`;
ALTER TABLE `engine4_users` ADD `languages` VARCHAR(128) NULL DEFAULT NULL AFTER `private_contact`;