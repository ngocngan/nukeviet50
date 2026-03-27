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
$id = $nv_Request->get_int('id', 'get,post', 0);
$error = '';
// Lấy các trang cho hiển thị popup
$_arr_modules = [];
foreach ($site_mods as $mod => $info) {
    if (!empty($info['funcs'])) {
        $list_func = [];
        foreach ($info['funcs'] as $_func) {
            if (!empty($_func['func_id'])) {
                $list_func[] = [
                    'alias' => $_func['func_name'],
                    'title' => empty($_func['func_site_title']) ? $_func['func_custom_name'] : $_func['func_site_title']
                ];
            }
        }
        if (!empty($list_func)) {
            $_arr_modules[$mod]['title'] = empty($info['site_title']) ? $info['custom_title'] : $info['site_title'];
            $_arr_modules[$mod]['list_func'] = $list_func;
        }
    }
}

if ($nv_Request->isset_request('save', 'post')) {
    $respon = [
        'status' => 'error',
        'mess' => '',
    ];
    $checkss = $nv_Request->get_title('checkss', 'post,get', '');
    if (!csrf_check($checkss, $csrf_key)) {
        nv_jsonOutput([
            'status' => 'error',
            'mess' => $nv_Lang->getModule('error_checkss')
        ]);
    }
    $title = $nv_Request->get_title('title', 'post', '');
    $description = $nv_Request->get_title('description', 'post', '');
    $is_all_page = $nv_Request->get_int('is_all_page', 'post', 0);
    $display_pages = $nv_Request->get_string('display_pages', 'post', '{}');
    $display_pages = html_entity_decode($display_pages);
    $page_json = json_decode($display_pages, true);
    if (json_last_error() === JSON_ERROR_NONE && is_array($page_json)) {
        array_walk_recursive($page_json, function(&$item) {
            $item = nv_htmlspecialchars(strip_tags($item));
        });
        $display_pages = json_encode($page_json);
    } else {
        $display_pages = '{}';
    }
    $type_popup = $nv_Request->get_title('type_popup', 'post', '');
    $popup_delay = $nv_Request->get_int('popup_delay', 'post', 0);
    $display_frequency = $nv_Request->get_int('display_frequency', 'post', 0);
    $display_object = $nv_Request->get_int('display_object', 'post', 0);
    $display_layout = $nv_Request->get_int('display_layout', 'post', 0);
    $status = $nv_Request->get_int('status', 'post', 0);
    $priority = $nv_Request->get_int('priority', 'post', 0);
    $display_device = $nv_Request->get_int('display_device', 'post', 0);
    $url_click = $nv_Request->get_title('url_click', 'post', '');
    $type_open = $nv_Request->get_title('type_open', 'post', '');
    $start_date = $nv_Request->get_title('start_time', 'post', '');
    $end_date = $nv_Request->get_title('end_time', 'post', '');
    $hour_start_time = $nv_Request->get_int('start_date_h', 'post', 0);
    $minute_start_time = $nv_Request->get_int('start_date_m', 'post', 0);
    $hour_end_time = $nv_Request->get_int('end_date_h', 'post', 0);    
    $minute_end_time = $nv_Request->get_int('end_date_m', 'post', 0);
    $css_class = $nv_Request->get_title('css_class', 'post', '');
    $content = $nv_Request->get_editor('content', '', NV_ALLOWED_HTML_TAGS);
    $assign_user_id = $admin_info['userid'];
    $display_type = $nv_Request->get_int('display_type', 'post', 0);
    $display_interval = $nv_Request->get_int('display_interval', 'post', 0);
    $max_show = $nv_Request->get_int('max_show', 'post', 0);
    $time_cr = NV_CURRENTTIME;
    if ($display_type != 3) {
        $display_interval = 0;
    }
    if (!empty($start_date) and !preg_match('/^([0-9]{1,2})\-([0-9]{1,2})\-([0-9]{4})$/', $start_date)) {
        $start_date = '';
    }
    if (!empty($end_date) and !preg_match('/^([0-9]{1,2})\-([0-9]{1,2})\-([0-9]{4})$/', $end_date)) {
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
        $respon['input'] = 'title';
        $respon['mess'] = $nv_Lang->getModule('title_empty');
        nv_jsonOutput($respon);
    } elseif ($display_pages == '{}' and empty($is_all_page)) {
        $error = $nv_Lang->getModule('page_show_not_selected');
        $respon['input'] = 'display_pages';
        $respon['mess'] = $nv_Lang->getModule('page_show_not_selected');
        nv_jsonOutput($respon);
    } elseif (empty($priority)) {
        $error = $nv_Lang->getModule('priority_not_selected');
        $respon['input'] = 'priority';
        $respon['mess'] = $nv_Lang->getModule('priority_not_selected');
        nv_jsonOutput($respon);
    } else {
        if (empty($start_date)) {
            $starttime = $time_cr;
        } else {
            unset($m);
            preg_match('/^([0-9]{1,2})\-([0-9]{1,2})\-([0-9]{4})$/', $start_date, $m);
            $starttime = mktime($hour_start_time, $minute_start_time, 0, $m[2], $m[1], $m[3]);
        }

        if (preg_match('/^([0-9]{1,2})\-([0-9]{1,2})\-([0-9]{4})$/', $end_date, $m)) {
            $endtime = mktime($hour_end_time, $minute_end_time, 59, $m[2], $m[1], $m[3]);
            if ($endtime <= $starttime) {
                $endtime = $starttime;
            }
        } else {
            $endtime = 0;
        }
        if ($endtime != 0 and $endtime <= $starttime) {
            $respon['input'] = 'end_time';
            $respon['mess'] = $nv_Lang->getModule('error_rang_time');
            nv_jsonOutput($respon);
        }
        if ($endtime != 0 and $endtime < $time_cr) {
            $respon['input'] = 'end_time';
            $respon['mess'] = $nv_Lang->getModule('error_end_time');
            nv_jsonOutput($respon);
        }
    }

    if (empty($error)) {
        if (empty($id)) {
            $sth = $db->prepare("INSERT INTO " . $db_config['prefix'] . "_" . NV_LANG_DATA . "_" . $module_data . "_detail (
                title, description, content, popup_type, priority, status, display_pages, is_all_page, display_object, display_layout, display_type, display_interval, max_show,
                start_time, end_time, url, type_open, display_device, css_class, created_time, created_by
            ) VALUES (
                :title, :description, :content, :popup_type, :priority, :status, :display_pages, :is_all_page, :display_object, :display_layout, :display_type, :display_interval, :max_show,
                :start_time, :end_time, :url, :type_open, :display_device, :css_class, :created_time, :created_by
            )");
            $sth->bindValue(':created_time', NV_CURRENTTIME, PDO::PARAM_INT);
        
        } else {
            $sth = $db->prepare("UPDATE " . $db_config['prefix'] . "_" . NV_LANG_DATA . "_" . $module_data . "_detail SET
                title=:title, description=:description, content=:content, popup_type=:popup_type, priority=:priority, status=:status, display_pages=:display_pages, is_all_page=:is_all_page, display_object=:display_object, display_layout=:display_layout, 
                display_type=:display_type, display_interval=:display_interval, max_show=:max_show, start_time=:start_time, end_time=:end_time, url=:url, type_open=:type_open, display_device=:display_device, css_class=:css_class, updated_time=:updated_time, created_by=:created_by
                WHERE id = " . $id);
            $sth->bindValue(':updated_time', NV_CURRENTTIME, PDO::PARAM_INT);        
        }
        $sth->bindParam(':title', $title, PDO::PARAM_STR);
        $sth->bindParam(':description', $description, PDO::PARAM_STR);
        $sth->bindParam(':content', $content, PDO::PARAM_STR);
        $sth->bindParam(':popup_type', $type_popup, PDO::PARAM_STR);
        $sth->bindParam(':priority', $priority, PDO::PARAM_INT);
        $sth->bindParam(':status', $status, PDO::PARAM_INT);
        $sth->bindParam(':display_pages', $display_pages, PDO::PARAM_STR);
        $sth->bindParam(':is_all_page', $is_all_page, PDO::PARAM_INT);
        $sth->bindParam(':display_object', $display_object, PDO::PARAM_INT);
        $sth->bindParam(':display_layout', $display_layout, PDO::PARAM_INT);
        $sth->bindParam(':display_type', $display_type, PDO::PARAM_INT);
        $sth->bindParam(':display_interval', $display_interval, PDO::PARAM_INT);
        $sth->bindParam(':max_show', $max_show, PDO::PARAM_INT);
        $sth->bindParam(':start_time', $starttime, PDO::PARAM_INT);
        $sth->bindParam(':end_time', $endtime, PDO::PARAM_INT);
        $sth->bindParam(':url', $url_click, PDO::PARAM_STR);
        $sth->bindParam(':type_open', $type_open, PDO::PARAM_STR);
        $sth->bindParam(':display_device', $display_device, PDO::PARAM_INT);
        $sth->bindParam(':css_class', $css_class, PDO::PARAM_STR);
        $sth->bindParam(':created_by', $assign_user_id, PDO::PARAM_STR);
        $sth->execute();
        if (empty($id)) {
            $id = $db->lastInsertId();
        }
        $nv_Cache->delMod($module_name);
        $redirect = NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=detail&id=' . $id;
        $respon['status'] = 'ok';
        $respon['redirect'] = $redirect;
        nv_jsonOutput($respon);
    }  
}

$array_data = [];
if (!empty($id)) {
    $sql = "SELECT * FROM " . $db_config['prefix'] . "_" . NV_LANG_DATA . "_" . $module_data . "_detail WHERE id= " . $id;
    $array_data = $db->query($sql)->fetch();
}

if (empty($array_data)) {
    $array_data['status'] = $array_data['display_device'] = $array_data['display_object'] = 0;
    $array_data['display_layout'] = $array_data['type_open'] = $array_data['start_hour'] = $array_data['start_minute'] = 0;
    $array_data['end_hour'] = $array_data['end_minute'] = $array_data['display_type'] = $array_data['display_interval'] = $array_data['max_show']= 0;
    $array_data['start_time'] = $array_data['end_time'] = $array_data['content'] = $array_data['description'] = $array_data['title'] = '';
    $array_data['priority'] = $array_data['url'] = $array_data['css_class'] = $array_data['popup_type'] = $array_data['display_pages'] = '';
    $array_data['is_all_page'] = 0;
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
$stpl->assign('HAS_EDITOR', $has_editor);
$stpl->assign('ERROR', $error);
$stpl->assign('CHECKSS', csrf_create($csrf_key));
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
$stpl->assign('MODULES', $_arr_modules);
$stpl->assign('DISPLAY_TYPE', array (
    4 => $nv_Lang->getModule('display_type_4'),
    1 => $nv_Lang->getModule('display_type_1'),
    2 => $nv_Lang->getModule('display_type_2'),
    3 => $nv_Lang->getModule('display_type_3')
));
$contents = $stpl->fetch('add.tpl');

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
