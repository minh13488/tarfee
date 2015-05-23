INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `order`) VALUES
('core_admin_main_youtube_channel', 'user', 'Youtube Channel Settings', '', '{"route":"admin_default","module":"user","controller":"youtube","action":"settings"}', 'core_admin_main_settings', '', 999);

INSERT IGNORE INTO `engine4_core_tasks` (`title`, `module`, `plugin`, `timeout`, `processes`, `semaphore`, 
`started_last`, `started_count`, `completed_last`, `completed_count`, `failure_last`, 
`failure_count`, `success_last`, `success_count`) VALUES 
('Video Upload Channel', 'video', 'Video_Plugin_Task_Upload', 1800, 1, 0, 0, 0, 0, 0, 
0, 0, 0, 0);