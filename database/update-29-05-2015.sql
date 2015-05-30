ALTER TABLE `engine4_group_groups` ADD `sportcategory_id` INT(11) UNSIGNED NOT NULL DEFAULT '0' AFTER `category_id`;


CREATE TABLE IF NOT EXISTS `engine4_group_follow` (
  `resource_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL, 
  `follow` tinyint(3) NOT NULL DEFAULT '3',
   PRIMARY KEY (`resource_id`,`user_id`),
  KEY `REVERSE` (`user_id`)
);

INSERT IGNORE INTO `engine4_activity_notificationtypes` (`type`, `module`, `body`, `is_request`, `handler`) VALUES
('advgroup_follow_edit', 'advgroup', 'The club {item:$object} that you are following has edited.', 0, '');

INSERT IGNORE INTO `engine4_core_mailtemplates` (`type`, `module`, `vars`) VALUES
('notify_advgroup_follow_edit', 'advgroup', '[host],[email],[recipient_title],[recipient_link],[recipient_photo],[sender_title],[sender_link],[sender_photo],[object_title],[object_link],[object_photo],[object_description]');


# notify_advgroup_follow_edit
"_EMAIL_NOTIFY_ADVGROUP_FOLLOW_EDIT_TITLE";"Following Club Edit"
"_EMAIL_NOTIFY_ADVGROUP_FOLLOW_EDIT_DESCRIPTION";"This email is sent to the followers of clubs."
"_EMAIL_NOTIFY_ADVGROUP_FOLLOW_EDIT_SUBJECT";"The club information [object_title] has been edited"
"_EMAIL_NOTIFY_ADVGROUP_FOLLOW_EDIT_BODY";"[header]

The club information ""[object_title]"" has been edited . Please click the following link to view it:

http://[host][object_link]

[footer]"


-- --------------------------------------------------------
--
-- Dumping data for table `engine4_core_mailtemplates`
--

INSERT IGNORE INTO `engine4_core_mailtemplates` (`type`, `module`, `vars`) VALUES
('advgroup_email_to_friends', 'advgroup', '[host],[email],[date],[sender_title],[sender_link],[sender_photo],[object_title],[message],[object_link],[object_photo],[object_description]');

# advgroup_email_to_friends
"_EMAIL_ADVGROUP_EMAIL_TO_FRIENDS_TITLE";"Followers Notification"
"_EMAIL_ADVGROUP_EMAIL_TO_FRIENDS_DESCRIPTION";"This is the email that gets sent when user wants to send message to followers."
"_EMAIL_ADVGROUP_EMAIL_TO_FRIENDS_SUBJECT";"You have received an notification of the following club [object_title]!"
"_EMAIL_ADVGROUP_EMAIL_TO_FRIENDS_BODY";"[header]

[message]

Check out this club
<img src='http://[host][object_photo]' />[object_description]
http://[host][object_link]

[footer]"


-- --------------------------------------------------------

-- Table structure for table `engine4_user_groupmappings`
--
CREATE TABLE IF NOT EXISTS `engine4_user_groupmappings` (
`groupmapping_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
`user_id` int(11) unsigned NOT NULL,
`group_id` int(11) unsigned NOT NULL,
PRIMARY KEY (`groupmapping_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;