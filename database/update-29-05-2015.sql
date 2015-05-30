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

