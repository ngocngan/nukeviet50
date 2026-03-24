<?php

/**
 * @Project NUKEVIET 5.x
 * @Author VINADES.,JSC (contact@vinades.vn)
 * @Copyright (C) 2016 VINADES.,JSC. All rights reserved
 * @License: Not free read more http://nukeviet.vn/vi/store/modules/nvtools/
 * @Createdate Tue, 02 Mar 2026 09:11:42 GMT
 */

if (!defined('NV_IS_FILE_MODULES'))
    die('Stop!!!');

$sql_drop_module = array();
$sql_drop_module[] = "DROP TABLE IF EXISTS " . $db_config['prefix'] . "_" . $module_data . "_config;";
$sql_drop_module[] = "DROP TABLE IF EXISTS " . $db_config['prefix'] . "_" . $lang . "_" . $module_data . "_detail;";
$sql_drop_module[] = "DROP TABLE IF EXISTS " . $db_config['prefix'] . "_" . $lang . "_" . $module_data . "_page;";
$sql_drop_module[] = "DROP TABLE IF EXISTS " . $db_config['prefix'] . "_" . $lang . "_" . $module_data . "_statics;";
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
    KEY total_closed (total_closed)
) ENGINE=MyISAM COMMENT 'Bảng lưu thông tin chi tiết các popup';";

$sql_create_module[] = "CREATE TABLE " . $db_config['prefix'] . "_" . $lang . "_" . $module_data . "_page (
    id int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL DEFAULT '',
    module_name VARCHAR(255) NOT NULL DEFAULT '',
    status TINYINT(4) NOT NULL DEFAULT '1',
    PRIMARY KEY (`id`)
) ENGINE=MyISAM COMMENT 'Bảng lưu danh sách các trang hiện có';";

$sql_create_module[] = "CREATE TABLE " . $db_config['prefix'] . "_" . $module_data . "_config (
    id int(11) unsigned NOT NULL AUTO_INCREMENT  COMMENT 'ID popup',
    config_name VARCHAR(255) NOT NULL DEFAULT '' COMMENT 'Tên cấu hình',
    config_value VARCHAR(255) NOT NULL DEFAULT '' COMMENT 'Giá trị cấu hình',
    PRIMARY KEY (id)
) ENGINE=MyISAM COMMENT 'Bảng lưu dữ liệu thống kê';";

$sql_create_module[] = "CREATE TABLE " . $db_config['prefix'] . "_" . $lang . "_" . $module_data . "_statics (
    id int(11) unsigned NOT NULL AUTO_INCREMENT  COMMENT 'ID popup',
    config_name VARCHAR(255) NOT NULL DEFAULT '' COMMENT 'Tên cấu hình',
    config_value VARCHAR(255) NOT NULL DEFAULT '' COMMENT 'Giá trị cấu hình',
    PRIMARY KEY (id)
) ENGINE=MyISAM COMMENT 'Bảng lưu dữ liệu thống kê';";

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
) ENGINE=MyISAM COMMENT 'Bảng lưu log hiển thị/click/đóng popup';";
 
$sql_create_module[] = "INSERT INTO " . $db_config['prefix'] . "_" . $module_data . "_config (config_name, config_value) VALUES ('display_layout', '1');";
$sql_create_module[] = "INSERT INTO " . $db_config['prefix'] . "_" . $module_data . "_config (config_name, config_value) VALUES ('popup_delay', '1');";
$sql_create_module[] = "INSERT INTO " . $db_config['prefix'] . "_" . $module_data . "_config (config_name, config_value) VALUES ('display_frequency', '0');";
$sql_create_module[] = "INSERT INTO " . $db_config['prefix'] . "_" . $module_data . "_config (config_name, config_value) VALUES ('display_device', '1');";
$sql_create_module[] = "INSERT INTO " . $db_config['prefix'] . "_" . $module_data . "_config (config_name, config_value) VALUES ('display_object', '0');";
$sql_create_module[] = "INSERT INTO " . $db_config['prefix'] . "_" . $module_data . "_config (config_name, config_value) VALUES ('close_on_outside_click', '1');";
$sql_create_module[] = "INSERT INTO " . $db_config['prefix'] . "_" . $module_data . "_config (config_name, config_value) VALUES ('default_priority', '1');";

$now = defined('NV_CURRENTTIME') ? NV_CURRENTTIME : time();
$sql_create_module[] = "INSERT INTO " . $db_config['prefix'] . "_" . $lang . "_" . $module_data . "_detail (`id`, `title`, `description`, `content`, `popup_type`, `priority`, `status`, `list_id_page`, `is_all_page`, `display_object`, `display_layout`, `display_type`, `display_interval`, `max_show`, `start_time`, `end_time`, `url`, `type_open`, `display_device`, `css_class`, `created_time`, `updated_time`, `created_by`) VALUES
(1, 'Popup - Mỗi ngày 1 lần', 'Ví dụ: hiện rồi đóng, 1 ngày sau mới hiện lại', '<p>Test: once per day</p>', 'Test', 5, 1, '', 1, '0', 1, 2, 0, 0, " . ($now - 60) . ", 0, '', '_self', 1, 'nv-popups-demo-once-per-day', " . $now . ", " . $now . ", 1),
(2, 'Popup - Chỉ hiện 1 lần duy nhất', 'Ví dụ: muốn hiện đúng 1 lần rồi không hiện nữa', '<p>Test: max_show=1</p>', 'Test', 9, 1, '', 1, '0', 2, 4, 0, 1, " . ($now - 60) . ", 0, 'https://nukeviet.vn/', '_blank', 1, 'nv-popups-demo-once-only', " . $now . ", " . $now . ", 1),
(3, 'Popup - Chỉ hiện khi đã đăng nhập', 'Ví dụ: đăng nhập mới xem được', '<p>Test: user-only</p>', 'Test', 7, 1, '', 1, '1', 1, 1, 0, 0, " . ($now - 60) . ", 0, '', '_self', 1, 'nv-popups-demo-user-only', " . $now . ", " . $now . ", 1),
(4, 'Popup - Sau mỗi 30 phút', 'Ví dụ: 30 phút hiện lại 1 lần', '<p>Test: every 30 minutes</p>', 'Test', 6, 1, '', 1, '0', 1, 3, 30, 0, " . ($now - 60) . ", 0, '', '_self', 1, 'nv-popups-demo-every-30m', " . $now . ", " . $now . ", 1),
(5, 'Popup - Mãi mãi (khẩn cấp)', 'Ví dụ: Always - cả đăng nhập và chưa đăng nhập đều thấy', '<p><strong>Thông báo khẩn cấp</strong> (nội dung kiểu CKEditor)</p><p>Đây là đoạn mô tả dài để test layout, scroll và responsive. Nội dung có thể gồm <em>in nghiêng</em>, <u>gạch chân</u>, <a href=\"https://nukeviet.vn/\" target=\"_blank\" rel=\"noopener\">liên kết</a>, và xuống dòng.</p><figure><img src=\"/assets/images/logo.svg\" alt=\"Logo\" style=\"max-width: 100%; height: auto;\"></figure><p>Danh sách:</p><ul><li>Mục 1: có mô tả</li><li>Mục 2: có <strong>định dạng</strong></li><li>Mục 3: có link <a href=\"/\" target=\"_self\">trang chủ</a></li></ul><blockquote><p>\"Popup nội dung dài giúp test hiển thị.\"</p></blockquote><p>Kết thúc: Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>', 'Test', 8, 1, '', 1, '0', 1, 4, 0, 0, " . ($now - 60) . ", 0, '', '_self', 1, 'nv-popups-demo-always', " . $now . ", " . $now . ", 1),
(6, 'Popup - Hết hạn', 'Test: đã hết hạn', '<p>Không được trả về</p>', 'Test', 10, 1, '', 1, '0', 1, 2, 0, 0, " . ($now - 86400 * 2) . ", " . ($now - 60) . ", '', '_self', 1, 'nv-popups-demo-expired', " . $now . ", " . ($now - 40) . ", 1),
(7, 'Popup - Chưa tới giờ', 'Test: chưa tới thời điểm', '<p>Không được trả về</p>', 'Test', 10, 1, '', 1, '0', 1, 2, 0, 0, " . ($now + 3600) . ", 0, '', '_self', 1, 'nv-popups-demo-future', " . $now . ", " . ($now - 50) . ", 1),
(8, 'Popup - Ngừng hoạt động', 'Test: status=4', '<p>Không được trả về</p>', 'Test', 10, 4, '', 1, '0', 1, 2, 0, 0, " . ($now - 60) . ", 0, '', '_self', 1, 'nv-popups-demo-off', " . $now . ", " . ($now - 60) . ", 1),
(9, 'Popup - Có danh sách trang', 'Test: is_all_page=0, list_id_page=1,2 - popup ở trạng thái chờ duyệt', '<p>Test lọc trang (nếu bật)</p>', 'Test', 4, 0, '1,2', 0, '0', 1, 1, 0, 0, " . ($now - 60) . ", 0, '', '_self', 1, 'nv-popups-demo-pages', " . $now . ", " . ($now - 70) . ", 1),
(10, 'Popup - Tin tức (chỉ user)', 'Ví dụ: chỉ hiện khi pid=2 (Module Tin tức/news) và đã đăng nhập (Always)', '<p>Test: chỉ hiện với user (đã đăng nhập) ở Module Tin tức (pid=2)</p>', 'Test', 3, 1, '2', 0, '1', 1, 4, 0, 0, 0, 0, '', '_self', 1, 'nv-popups-demo-page-2', " . $now . ", " . $now . ", 1),
(11, 'Popup - Chỉ khách (ẩn khi login)', 'Ví dụ: chưa đăng nhập thì thấy, đăng nhập thì không thấy', '<p>Test: guest-only</p>', 'Test', 2, 1, '', 1, '2', 1, 4, 0, 0, " . ($now - 60) . ", 0, '', '_self', 1, 'nv-popups-demo-guest-only', " . $now . ", " . $now . ", 1),
(12, 'Popup - Chỉ user (1 lần)', 'Ví dụ: đăng nhập thì thấy 1 lần duy nhất rồi không hiện nữa', '<p>Test: user-only + max_show=1</p>', 'Test', 2, 1, '', 1, '1', 1, 4, 0, 1, " . ($now - 60) . ", 0, '', '_self', 1, 'nv-popups-demo-user-only-2', " . $now . ", " . $now . ", 1);";

// Hook: Nạp tài nguyên Popups trên toàn site
$sql_create_module[] = "DELETE FROM " . $db_config['prefix'] . "_plugins WHERE plugin_lang='all' AND plugin_file='popups_site.php' AND plugin_area='change_site_buffer' AND plugin_module_name='' AND plugin_module_file='popups' AND hook_module=''";
$sql_create_module[] = "INSERT INTO " . $db_config['prefix'] . "_plugins (plugin_lang, plugin_file, plugin_area, plugin_module_name, plugin_module_file, hook_module, weight) VALUES ('all', 'popups_site.php', 'change_site_buffer', '', 'popups', '', 10);";

$sql_create_module[] = "INSERT INTO " . $db_config['prefix'] . "_" . $lang . "_" . $module_data . "_page (`id`, `name`, `module_name`, `status`) VALUES
(1, 'Trang chủ', 'home', '1'),
(2, 'Module Tin tức', 'news', '1'),
(3, 'Trang danh sách KHLCNT', '', '1'),
(4, 'Trang chi tiết KHLCNT', '', '1'),
(5, 'Trang danh sách Dự án đầu tư phát triển', '', '1'),
(6, 'Trang chi tiết Dự án đầu tư phát triển', '', '1'),
(7, 'Trang Mời sơ tuyển/mời quan tâm cho nhà thầu', '', '1'),
(8, 'Trang chi tiết Mời sơ tuyển/mời quan tâm cho nhà thầu', '', '1'),
(9, 'Trang danh sách Kết quả sơ tuyển cho nhà thầu', '', '1'),
(10, 'Trang chi tiết Kết quả sơ tuyển cho nhà thầu', '', '1'),
(11, 'Trang danh sách TBMT', '', '1'),
(12, 'Trang chi tiết TBMT', '', '1'),
(13, 'Trang danh sách Kết quả lựa chọn nhà thầu', '', '1'),
(14, 'Trang chi tiết kết quả lựa chọn nhà thầu', '', '1'),
(15, 'Trang danh sách Kết quả mở thầu (qua mạng) ', '', '1'),
(16, 'Trang chi tiết Kết quả mở thầu (qua mạng)', '', '1'),
(17, 'Trang danh sách Dự án mới được công bố', '', '1'),
(18, 'Trang chi tiết Dự án mới được công bố', '', '1'),
(19, 'Trang danh sách Thông báo mời thầu đầu tư', '', '1'),
(20, 'Trang chi tiết Thông báo mời thầu đầu tư', '', '1'),
(21, 'Trang danh sách Mời sơ tuyển/mời quan tâm cho nhà đầu tư', '', '1'),
(22, 'Trang chi tiết Thông báo mời sơ tuyển/quan tâm', '', '1'),
(23, 'Trang danh sách KHLC nhà đầu tư', '', '1'),
(24, 'Trang chi tiết KHLC nhà đầu tư', '', '1'),
(25, 'Trang danh sách KQLC nhà đầu tư', '', '1'),
(26, 'Trang chi tiết KQLC nhà đầu tư', '', '1'),
(27, 'Trang danh sách Kết quả sơ tuyển nhà đầu tư', '', '1'),
(28, 'Trang chi tiết Kết quả sơ tuyển nhà đầu tư ', '', '1'),
(29, 'Trang danh sách bên mời thầu', '', '1'),
(30, 'Trang chi tiết bên mời thầu cụ thể', '', '1'),
(31, 'Trang danh sách nhà thầu', '', '1'),
(32, 'Trang chi tiết nhà thầu cụ thể', '', '1'),
(33, 'Trang danh sách Thông báo đấu giá', '', '1'),
(34, 'Trang chi tiết Thông báo đấu giá', '', '1'),
(35, 'Trang danh sách Thông báo chọn tổ chức đấu giá', '', '1'),
(36, 'Trang chi tiết Thông báo chọn tổ chức đấu giá', '', '1'),
(37, 'Trang danh sách Tổ chức đấu giá', '', '1'),
(38, 'Trang chi tiết Tổ chức đấu giá', '', '1');";
