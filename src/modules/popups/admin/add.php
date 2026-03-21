<?php

/**
 * @Project NUKEVIET 5.x
 * @Author VINADES.,JSC <contact@vinades.vn>
 * @Copyright (C) 2020 VINADES.,JSC. All rights reserved
 * @License: Not free read more http://nukeviet.vn/vi/store/modules/nvtools/
 * @Createdate Tue, 02 Mar 2026 09:11:42 GMT
 */

if (!defined('NV_IS_FILE_ADMIN')) {
    exit('Stop!!!');
}

$page_title = $nv_Lang->getModule('add_new_popup');
$id_array = [];
$id = $nv_Request->get_string('id', 'get,post', '');
$error = '';
// Lấy các trang cho hiển thị popup
$sql_1 ="SELECT * FROM " . $db_config['prefix'] . "_" . NV_LANG_DATA . "_" . $module_data . "_page WHERE status = 1";
$_list_page = $db->query($sql_1);
$_arr_page['-1'] = $nv_Lang->getModule('all_page');
while ($row = $_list_page->fetch()) {
    $_arr_page[$row['id']] = $row['name'];
}

if ($nv_Request->isset_request('save', 'post')) {
    $title = nv_htmlspecialchars(strip_tags($nv_Request->get_string('title', 'post', '')));
    $description = nv_htmlspecialchars(strip_tags($nv_Request->get_string('description', 'post', '')));
    $is_all_page = $nv_Request->get_int('is_all_page', 'post', 0);
    $_page_id = $nv_Request->get_array('list_page', 'post', []);
    $pageid = implode(',', $_page_id);
    $type_popup = $nv_Request->get_int('type_popup', 'post', 0);
    $popup_delay = $nv_Request->get_int('popup_delay', 'post', 0);
    $display_frequency = $nv_Request->get_int('display_frequency', 'post', 0);
    $display_object = $nv_Request->get_int('display_object', 'post', 0);
    $display_layout = $nv_Request->get_int('display_layout', 'post', 0);
    $status = $nv_Request->get_int('status', 'post', 0);
    $priority = $nv_Request->get_int('priority', 'post', 0);
    $display_device = $nv_Request->get_int('display_device', 'post', 0);
    $url_click = $nv_Request->get_string('url_click', 'post', '');
    $type_open = $nv_Request->get_string('type_open', 'post', '');
    $start_date = $nv_Request->get_string('start_time', 'post', '');
    $end_date = $nv_Request->get_string('end_time', 'post', '');
    $hour_start_time = $nv_Request->get_int('start_date_h', 'post', 0);
    $minute_start_time = $nv_Request->get_int('start_date_m', 'post', 0);
    $hour_end_time = $nv_Request->get_int('end_date_h', 'post', 0);    
    $minute_end_time = $nv_Request->get_int('end_date_m', 'post', 0);
    $css_class = $nv_Request->get_string('css_class', 'post', '');
    $content = $nv_Request->get_editor('content', '', NV_ALLOWED_HTML_TAGS);
    $assign_user_id = $admin_info['userid'];    
    if (!empty($start_date) and !preg_match('/^([0-9]{1,2})\/([0-9]{1,2})\/([0-9]{4})$/', $start_date)) {
        $start_date = '';
    }
    if (!empty($end_date) and !preg_match('/^([0-9]{1,2})\/([0-9]{1,2})\/([0-9]{4})$/', $end_date)) {
        $end_date = '';
    }
    if ($hour_start_time < 0 or $hour_start_time > 23) {
        $hour_start_time = 0;
    }
    if ($hour_end_time < 0 or $hour_end_time > 23) {
        $hour_end_time = 0;
    }
    if ($minute_start_time < 0 or $minute_start_time > 59) {
        $minute_start_time = 0;
    }
    if ($minute_end_time < 0 or $minute_end_time > 59) {
        $minute_end_time = 0;
    }
    $click_url_allow = !empty($url_click) ? nv_is_url($url_click, true) : true;

    if (empty($title)) {
        $error = $nv_Lang->getModule('title_empty');
    } elseif (empty($pageid) and empty($is_all_page)) {
        $error = $nv_Lang->getModule('page_show_not_selected');
    } elseif (empty($priority)) {
        $error = $nv_Lang->getModule('priority_not_selected');
    } else {
        if (empty($start_date)) {
            $starttime = NV_CURRENTTIME;
        } else {
            unset($m);
            preg_match('/^([0-9]{1,2})\/([0-9]{1,2})\/([0-9]{4})$/', $start_date, $m);
            $starttime = mktime($hour_start_time, $minute_start_time, 0, $m[2], $m[1], $m[3]);
        }

        if (preg_match('/^([0-9]{1,2})\/([0-9]{1,2})\/([0-9]{4})$/', $end_date, $m)) {
            $endtime = mktime($hour_end_time, $minute_end_time, 59, $m[2], $m[1], $m[3]);
            if ($endtime <= $starttime) {
                $endtime = $starttime;
            }
        } else {
            $endtime = 0;
        }
        if ($endtime != 0 and $endtime <= $starttime) {
            $endtime = $starttime;
        }
    }

    if (empty($error)) {
        if (empty($id)) {
            $sth = $db->prepare("INSERT INTO " . $db_config['prefix'] . "_" . NV_LANG_DATA . "_" . $module_data . "_detail (
                title, description, content, popup_type, priority, status, list_id_page, is_all_page, display_object, display_layout, 
                start_time, end_time, url, type_open, display_device, css_class, created_time, created_by
            ) VALUES (
                :title, :description, :content, :popup_type, :priority, :status, :list_id_page, :is_all_page, :display_object, :display_layout,
                :start_time, :end_time, :url, :type_open, :display_device, :css_class, :created_time, :created_by
            )");
            $sth->bindValue(':created_time', NV_CURRENTTIME, PDO::PARAM_INT);
        
        } else {
            $sth = $db->prepare("UPDATE " . $db_config['prefix'] . "_" . NV_LANG_DATA . "_" . $module_data . "_detail SET
                title=:title, description=:description, content=:content, popup_type=:popup_type, priority=:priority, status=:status, list_id_page=:list_id_page, is_all_page=:is_all_page, display_object=:display_object, 
                display_layout=:display_layout, start_time=:start_time, end_time=:end_time, url=:url, type_open=:type_open, display_device=:display_device, css_class=:css_class, updated_time=:updated_time, created_by=:created_by
                WHERE id = " . $id);
            $sth->bindValue(':updated_time', NV_CURRENTTIME, PDO::PARAM_INT);        
        }
        $sth->bindParam(':title', $title, PDO::PARAM_INT);
        $sth->bindParam(':description', $description, PDO::PARAM_STR);
        $sth->bindParam(':content', $content, PDO::PARAM_STR);
        $sth->bindParam(':popup_type', $type_popup, PDO::PARAM_STR);
        $sth->bindParam(':priority', $priority, PDO::PARAM_INT);
        $sth->bindParam(':status', $status, PDO::PARAM_INT);
        $sth->bindParam(':list_id_page', $pageid, PDO::PARAM_STR);
        $sth->bindParam(':is_all_page', $is_all_page, PDO::PARAM_STR);
        $sth->bindParam(':display_object', $display_object, PDO::PARAM_INT);
        $sth->bindParam(':display_layout', $display_layout, PDO::PARAM_INT);
        $sth->bindParam(':start_time', $starttime, PDO::PARAM_STR);
        $sth->bindParam(':end_time', $endtime, PDO::PARAM_STR);
        $sth->bindParam(':url', $url_click, PDO::PARAM_STR);
        $sth->bindParam(':type_open', $type_open, PDO::PARAM_STR);
        $sth->bindParam(':display_device', $display_device, PDO::PARAM_STR);
        $sth->bindParam(':css_class', $css_class, PDO::PARAM_STR);
        $sth->bindParam(':created_by', $assign_user_id, PDO::PARAM_STR);
        $sth->execute();
    }
    $nv_Cache->delMod($module_name);
}
$array_data = [];
if (!empty($id)) {
    $sql = "SELECT * FROM " . $db_config['prefix'] . "_" . NV_LANG_DATA . "_" . $module_data . "_detail WHERE id= " . $id;
    $array_data = $db->query($sql)->fetch();
}
if (empty($array_data)) {
    $array_data['status'] = $array_data['display_device'] = $array_data['display_object'] = $array_data['is_all_page'] = 0;
    $array_data['display_layout'] = $array_data['type_open'] = $array_data['start_hour'] = $array_data['start_minute'] = 0;
    $array_data['end_hour'] = $array_data['end_minute'] = 0;
    $array_data['start_time'] = $array_data['end_time'] = $array_data['content'] = $array_data['description'] = $array_data['title'] = '';
    $array_data['priority'] = $array_data['url'] = $array_data['css_class'] = '';
    $array_data['list_page'] = [];
} else {
    if (!empty($array_data['start_time'])) {
        $array_data['start_hour'] = nv_date('G', $array_data['start_time']);
        $array_data['start_minute'] = (int) (nv_date('i', $array_data['start_time']));
    } else {
        $array_data['start_hour'] = 0;
        $array_data['start_minute'] = 0;
    }

    if (!empty($array_data['end_time'])) {
        $array_data['end_hour'] = nv_date('G', $array_data['end_time']);
        $array_data['end_minute'] = (int) (nv_date('i', $array_data['end_time']));
    } else {
        $array_data['end_hour'] = 23;
        $array_data['end_minute'] = 59;
    }
    $array_data['list_page'] = explode(',', $array_data['list_id_page']);
    $array_data['start_time'] = nv_date('d/m/Y', $array_data['start_time']);
    $array_data['end_time'] = nv_date('d/m/Y', $array_data['end_time']);
}
if (defined('NV_EDITOR')) {
    require_once NV_ROOTDIR . '/' . NV_EDITORSDIR . '/' . NV_EDITOR . '/nv.php';
}
$array_data['content'] = htmlspecialchars(nv_editor_br2nl($array_data['content']));
if (defined('NV_EDITOR') and nv_function_exists('nv_aleditor')) {
    $has_editor = true;
    $array_data['content'] = nv_aleditor('content', '100%', '250px', $array_data['content'], 'Basic');
} else {
    $has_editor = false;
}

$stpl = new \NukeViet\Template\NVSmarty();
$stpl->setTemplateDir(get_module_tpl_dir('add.tpl'));
$stpl->assign('LANG', $nv_Lang);
$stpl->assign('NV_LANG_VARIABLE', NV_LANG_VARIABLE);
$stpl->assign('NV_LANG_DATA', NV_LANG_DATA);
$stpl->assign('DATA', $array_data);
$stpl->assign('ARR_PAGE', $_arr_page);
$stpl->assign('HAS_EDITOR', $has_editor);
$stpl->assign('ERROR', $error);
if (!empty($id)) {
    $stpl->assign('FORM_ACTION', NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&amp;' . NV_NAME_VARIABLE . '=' . $module_name . '&amp;' . NV_OP_VARIABLE . '=' . $op . '&amp;id=' . $id);
} else {
    $stpl->assign('FORM_ACTION', NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&amp;' . NV_NAME_VARIABLE . '=' . $module_name . '&amp;' . NV_OP_VARIABLE . '=' . $op);
}
$stpl->assign('STATUS', $_arr_status);
$stpl->assign('LAYOUT', $arr_layout);
$stpl->assign('DEVICE', $arr_device);
$stpl->assign('OBJECT', $arr_object);
$stpl->assign('WINDOW_CLICK', $arr_window_click);
$stpl->assign('TYPE_POPUP', $arr_type_popup);

$contents = $stpl->fetch('add.tpl');

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
