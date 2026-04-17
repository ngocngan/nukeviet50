<?php

/**
 * @Project NUKEVIET 5.x
 * @Author VINADES.,JSC (contact@vinades.vn)
 * @Copyright (C) 2016 VINADES.,JSC. All rights reserved
 * @License: Not free read more http://nukeviet.vn/vi/store/modules/nvtools/
 * @Createdate Tue, 02 Mar 2026 09:11:42 GMT
 */

if (!defined('NV_IS_FILE_MODULES')) {
    die('Stop!!!');
}
$sql_drop_module = array();
$sql_drop_module[] = "DROP TABLE IF EXISTS " . $db_config['prefix'] . "_" . $module_data . "_config;";
$sql_drop_module[] = "DROP TABLE IF EXISTS " . $db_config['prefix'] . "_" . $lang . "_" . $module_data . "_detail;";
$sql_drop_module[] = "DROP TABLE IF EXISTS " . $db_config['prefix'] . "_" . $module_data . "_logs;";

$sql_create_module = $sql_drop_module;
$sql_create_module[] = "CREATE TABLE " . $db_config['prefix'] . "_" . $lang . "_" . $module_data . "_detail (
    id int(11) unsigned NOT NULL AUTO_INCREMENT  COMMENT 'ID popup',
    title VARCHAR(500) NOT NULL DEFAULT '' COMMENT 'Tiêu đề popup',
    description VARCHAR(500) NOT NULL DEFAULT '' COMMENT 'Mô tả ngắn',
    content TEXT NOT NULL DEFAULT '' COMMENT 'Nội dung',
    popup_type VARCHAR(100) NOT NULL DEFAULT '' COMMENT 'Loại Popup',
    priority TINYINT(4) NOT NULL DEFAULT '0' COMMENT 'Độ ưu tiên',
    status TINYINT(4) NOT NULL DEFAULT '0' COMMENT 'Trạng thái: 0: Chờ duyệt, 1: Đang hoạt động, 2: Bị đình chỉ',
    display_pages TEXT NOT NULL DEFAULT '' COMMENT 'Danh sách các trang hiển thị',
    is_all_page TINYINT(4) NOT NULL DEFAULT '0' COMMENT 'Hiển thị tất cả các trang',
    display_object VARCHAR(20) NOT NULL DEFAULT '' COMMENT 'Đối tượng hiển thị: 0 - Tất cả, 1 - đã đăng nhập, 2 - chưa đăng nhập',
    display_layout TINYINT(4) NOT NULL DEFAULT '0' COMMENT 'Giao diện hiển thị: 1 - Center Middle, 2 - Large Modal',
    display_type TINYINT(4) NOT NULL DEFAULT '1' COMMENT 'Tần suất hiển thị: 1 - Once per session, 2 - Once per day, 3 - Sau mỗi X phút, 4 - Always',
    display_interval INT(11) NOT NULL DEFAULT '0' COMMENT 'Khoảng thời gian (phút) cho kiểu hiển thị 3',
    max_show INT(11) NOT NULL DEFAULT '0' COMMENT 'Số lần tối đa được hiển thị cho mỗi người dùng/thiết bị: 0 - Không giới hạn',
    start_time INT(11) NOT NULL DEFAULT '0' COMMENT 'Thời gian bắt đầu',
    end_time INT(11) NOT NULL DEFAULT '0' COMMENT 'Thời gian kết thúc',
    url VARCHAR(255) NOT NULL DEFAULT '' COMMENT 'Url liên kết',
    type_open VARCHAR(20) NOT NULL DEFAULT '' COMMENT 'Cửa sổ khi click: _blank-Cửa sổ mới (_blank),_self-Cùng một cửa sổ (_self)',
    display_device TINYINT(4) NOT NULL DEFAULT '1' COMMENT 'Thiết bị hiển thị (1: Cả Mobile và Desktop, 2: Mobile, 3: Desktop)',
    css_class VARCHAR(255) NOT NULL DEFAULT '' COMMENT 'CSS Class tùy chỉnh',
    total_click INT(11) NOT NULL DEFAULT '0' COMMENT 'Tổng lượt click',
    total_view INT(11) NOT NULL DEFAULT '0' COMMENT 'Tổng lượt xem',
    total_closed INT(11) NOT NULL DEFAULT '0' COMMENT 'Tổng lượt đóng',
    created_time INT(11) NOT NULL DEFAULT '0' COMMENT '',
    updated_time INT(11) NOT NULL DEFAULT '0' COMMENT '',
    created_by INT(11) NOT NULL DEFAULT '0' COMMENT 'ID Người tạo',
    PRIMARY KEY (id),
    KEY total_click (total_click),
    KEY total_view (total_view),
    KEY total_closed (total_closed),
    KEY priority (priority),
    KEY display_object (display_object),
    KEY display_layout (display_layout),
    KEY display_device (display_device),
    KEY updated_time (updated_time)
) ENGINE=InnoDB COMMENT 'Bảng lưu thông tin chi tiết các popup';";

$sql_create_module[] = "CREATE TABLE " . $db_config['prefix'] . "_" . $module_data . "_config (
    id int(11) unsigned NOT NULL AUTO_INCREMENT  COMMENT 'ID popup',
    config_name VARCHAR(255) NOT NULL DEFAULT '' COMMENT 'Tên cấu hình',
    config_value VARCHAR(255) NOT NULL DEFAULT '' COMMENT 'Giá trị cấu hình',
    PRIMARY KEY (id)
) ENGINE=InnoDB COMMENT 'Bảng cấu hình module';";

$sql_create_module[] = "CREATE TABLE " . $db_config['prefix'] . "_" . $module_data . "_logs (
    id int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
    popup_id int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'ID popup',
    userid int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'ID user',
    act VARCHAR(10) NOT NULL DEFAULT '' COMMENT 'Hành động: view/click/close',
    device TINYINT(4) NOT NULL DEFAULT '0' COMMENT 'Thiết bị: 1-Desktop, 2-Mobile, 3-Tablet',
    log_time INT(11) NOT NULL DEFAULT '0' COMMENT 'Thời gian',
    PRIMARY KEY (id),
    KEY popup_id (popup_id),
    KEY userid (userid),
    KEY act (act),
    KEY log_time (log_time)
) ENGINE=InnoDB COMMENT 'Bảng lưu log hiển thị/click/đóng popup';";

$sql_create_module[] = "INSERT INTO " . $db_config['prefix'] . "_" . $module_data . "_config (config_name, config_value) VALUES ('display_layout', '1');";
$sql_create_module[] = "INSERT INTO " . $db_config['prefix'] . "_" . $module_data . "_config (config_name, config_value) VALUES ('popup_delay', '1');";
$sql_create_module[] = "INSERT INTO " . $db_config['prefix'] . "_" . $module_data . "_config (config_name, config_value) VALUES ('display_frequency', '0');";
$sql_create_module[] = "INSERT INTO " . $db_config['prefix'] . "_" . $module_data . "_config (config_name, config_value) VALUES ('display_device', '1');";
$sql_create_module[] = "INSERT INTO " . $db_config['prefix'] . "_" . $module_data . "_config (config_name, config_value) VALUES ('display_object', '0');";
$sql_create_module[] = "INSERT INTO " . $db_config['prefix'] . "_" . $module_data . "_config (config_name, config_value) VALUES ('close_on_outside_click', '1');";
$sql_create_module[] = "INSERT INTO " . $db_config['prefix'] . "_" . $module_data . "_config (config_name, config_value) VALUES ('default_priority', '1');";

$now = defined('NV_CURRENTTIME') ? NV_CURRENTTIME : time();
$sql_create_module[] = "INSERT INTO " . $db_config['prefix'] . "_" . $lang . "_" . $module_data . "_detail (`id`, `title`, `description`, `content`, `popup_type`, `priority`, `status`, `display_pages`, `is_all_page`, `display_object`, `display_layout`, `display_type`, `display_interval`, `max_show`, `start_time`, `end_time`, `url`, `type_open`, `display_device`, `css_class`, `created_time`, `updated_time`, `created_by`) VALUES
(1, 'Popup - Mỗi ngày 1 lần', 'Ví dụ: hiện rồi đóng, 1 ngày sau mới hiện lại', '<p>Test: once per day</p>', 'noti', 5, 1, '', 1, '0', 1, 2, 0, 0, " . ($now - 60) . ", 0, '', '_self', 1, 'nv-popups-demo-once-per-day', " . $now . ", " . $now . ", 1),
(2, 'Popup - Chỉ hiện 1 lần duy nhất', 'Ví dụ: muốn hiện đúng 1 lần rồi không hiện nữa', '<p>Test: max_show=1</p>', 'noti', 9, 1, '', 1, '0', 2, 4, 0, 1, " . ($now - 60) . ", 0, 'https://nukeviet.vn/', '_blank', 1, 'nv-popups-demo-once-only', " . $now . ", " . $now . ", 1),
(3, 'Popup - Chỉ hiện khi đã đăng nhập', 'Ví dụ: đăng nhập mới xem được', '<p>Test: user-only</p>', 'noti', 7, 0, '', 1, '1', 1, 1, 0, 0, " . ($now - 60) . ", 0, '', '_self', 1, 'nv-popups-demo-user-only', " . $now . ", " . $now . ", 1),
(4, 'Popup - Sau mỗi 30 phút', 'Ví dụ: 30 phút hiện lại 1 lần', '<p>Test: every 30 minutes</p>', 'noti', 6, 0, '', 1, '0', 1, 3, 30, 0, " . ($now - 60) . ", 0, '', '_self', 1, 'nv-popups-demo-every-30m', " . $now . ", " . $now . ", 1),
(5, 'Popup - Mãi mãi (khẩn cấp)', 'Ví dụ: Always - cả đăng nhập và chưa đăng nhập đều thấy', '<p><strong>Thông báo khẩn cấp</strong> (nội dung kiểu CKEditor)</p><p>Đây là đoạn mô tả dài để test layout, scroll và responsive. Nội dung có thể gồm <em>in nghiêng</em>, <u>gạch chân</u>, <a href=\"https://nukeviet.vn/\" target=\"_blank\" rel=\"noopener\">liên kết</a>, và xuống dòng.</p><figure><img src=\"/assets/images/logo.svg\" alt=\"Logo\" style=\"max-width: 100%; height: auto;\"></figure><p>Danh sách:</p><ul><li>Mục 1: có mô tả</li><li>Mục 2: có <strong>định dạng</strong></li><li>Mục 3: có link <a href=\"/\" target=\"_self\">trang chủ</a></li></ul><blockquote><p>\"Popup nội dung dài giúp test hiển thị.\"</p></blockquote><p>Kết thúc: Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>', 'prom', 8, 1, '', 1, '0', 1, 4, 0, 0, " . ($now - 60) . ", 0, '', '_self', 1, 'nv-popups-demo-always', " . $now . ", " . $now . ", 1),
(6, 'Popup - Hết hạn', 'Test: đã hết hạn', '<p>Không được trả về</p>', 'noti', 10, 0, '', 1, '0', 1, 2, 0, 0, " . ($now - 86400 * 2) . ", " . ($now - 60) . ", '', '_self', 1, 'nv-popups-demo-expired', " . $now . ", " . ($now - 40) . ", 1),
(7, 'Popup - Chưa tới giờ', 'Test: chưa tới thời điểm', '<p>Không được trả về</p>', 'noti', 10, 0, '', 1, '0', 1, 2, 0, 0, " . ($now + 3600) . ", 0, '', '_self', 1, 'nv-popups-demo-future', " . $now . ", " . ($now - 50) . ", 1),
(8, 'Popup - Bị đình chỉ', 'Test: status=2', '<p>Không được trả về</p>', 'prom', 10, 0, '', 1, '0', 1, 2, 0, 0, " . ($now - 60) . ", 0, '', '_self', 1, 'nv-popups-demo-off', " . $now . ", " . ($now - 60) . ", 1),
(9, 'Popup - Có danh sách trang', 'Test: News (main) + toàn bộ About', '<p>Test lọc trang (news chọn main; about tất cả)</p>', 'prom', 4, 0, '{\"news\":[\"main\"],\"about\":[\"*\"]}', 0, '0', 1, 4, 0, 0, " . ($now - 60) . ", 0, '', '_self', 1, 'nv-popups-demo-pages', " . $now . ", " . ($now - 70) . ", 1),
(10, 'Popup - Tin tức (chỉ user)', 'Ví dụ: chỉ hiện khi pid=2 (Module Tin tức/news) và đã đăng nhập (Always)', '<p>Test: chỉ hiện với user (đã đăng nhập) ở Module Tin tức (pid=2)</p>', 'prom', 3, 0, '2', 0, '1', 1, 4, 0, 0, 0, 0, '', '_self', 1, 'nv-popups-demo-page-2', " . $now . ", " . $now . ", 1),
(11, 'Popup - Chỉ khách (ẩn khi login)', 'Ví dụ: chưa đăng nhập thì thấy, đăng nhập thì không thấy', '<p>Test: guest-only</p>', 'prom', 2, 0, '', 1, '2', 1, 4, 0, 0, " . ($now - 60) . ", 0, '', '_self', 1, 'nv-popups-demo-guest-only', " . $now . ", " . $now . ", 1),
(12, 'Popup - Chỉ user (1 lần)', 'Ví dụ: đăng nhập thì thấy 1 lần duy nhất rồi không hiện nữa', '<p>Test: user-only + max_show=1</p>', 'prom', 2, 0, '', 1, '1', 1, 4, 0, 1, " . ($now - 60) . ", 0, '', '_self', 1, 'nv-popups-demo-user-only-2', " . $now . ", " . $now . ", 1),
(13, 'Popup - About (mỗi 2 phút)', 'Test: display_type=3, display_interval=2, chỉ ở About', '<p>Test: every 2 minutes (About)</p>', 'prom', 5, 0, '{\"about\":[\"*\"]}', 0, '0', 1, 3, 2, 0, " . ($now - 60) . ", 0, '', '_self', 1, 'nv-popups-demo-about-2m', " . $now . ", " . $now . ", 1),
(14, 'Popup - News main (mỗi ngày 1 lần)', 'Test: display_type=2, chỉ ở News main', '<p>Test: once per day (News main)</p>', 'prom', 5, 0, '{\"news\":[\"main\"]}', 0, '0', 1, 2, 0, 0, " . ($now - 60) . ", 0, '', '_self', 1, 'nv-popups-demo-news-main-daily', " . $now . ", " . $now . ", 1),
(15, 'Popup - About (1 lần tối đa)', 'Test: display_type=4 + max_show=1, chỉ ở About', '<p>Test: always + max_show=1 (About)</p>', 'prom', 5, 0, '{\"about\":[\"*\"]}', 0, '0', 1, 4, 0, 1, " . ($now - 60) . ", 0, '', '_self', 1, 'nv-popups-demo-about-max1', " . $now . ", " . $now . ", 1);";

// Hook: Nạp tài nguyên Popups trên toàn site
$sql_create_module[] = "DELETE FROM " . $db_config['prefix'] . "_plugins WHERE plugin_lang='all' AND plugin_file='popups_site.php' AND plugin_area='change_site_buffer' AND plugin_module_name='' AND plugin_module_file='popups' AND hook_module=''";
$sql_create_module[] = "INSERT INTO " . $db_config['prefix'] . "_plugins (plugin_lang, plugin_file, plugin_area, plugin_module_name, plugin_module_file, hook_module, weight) VALUES ('all', 'popups_site.php', 'change_site_buffer', '', 'popups', '', 10);";
