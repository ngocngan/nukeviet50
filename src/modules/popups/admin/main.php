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

$page_title = $nv_Lang->getModule('title_popup');
$page = $nv_Request->get_page('page', 'get', 1);
$array_data = $array_search = [];
$array_search['status'] = $nv_Request->get_int('status', 'get', -1);
$array_search['keyword'] = $nv_Request->get_title('q', 'get', '');
$array_search['type_popup'] = $nv_Request->get_title('type_popup', 'get', '');
$array_search['display_layout'] = $nv_Request->get_int('display_layout', 'get', 0);
$array_search['start_time'] = $nv_Request->get_title('start_time', 'get', '');
$array_search['end_time'] = $nv_Request->get_title('end_time', 'get', '');
$array_search['t_start_time'] = nv_d2u_get($array_search['start_time']);
$array_search['t_end_time'] = nv_d2u_get($array_search['end_time'], 23, 59, 59);
$per_page = 15;

$checkss = $nv_Request->get_title('checkss', 'post');
if ($admin_info['level'] <= 2 and $nv_Request->isset_request('delete', 'post')) {
    $id = $nv_Request->get_int('id', 'post', 0);
    $listid = $nv_Request->get_title('listid', 'post', '');
    $id_array = array_map('intval', explode(',', $listid));
    $id_array = array_filter($id_array);
    $_listid = '';
    if (!empty($id_array)) {
        $_listid = implode(',', $id_array);
    }
    if (!csrf_check($checkss, $csrf_key)) {
        nv_jsonOutput([
            'status' => 'error',
            'mess' => $nv_Lang->getModule('error_checkss')
        ]);
    }
    if (!empty($id) || !empty($_listid)) {
        if (!empty($_listid)) {
            $exc = $db->exec("DELETE FROM " . $db_config['prefix'] . "_" . NV_LANG_DATA . "_" . $module_data . "_detail WHERE id IN (" . $_listid . ")");
        } else {
            $exc = $db->exec("DELETE FROM " . $db_config['prefix'] . "_" . NV_LANG_DATA . "_" . $module_data . "_detail WHERE id = " . $id);
        }

        if ($exc) {
            $nv_Cache->delMod($module_name);
            nv_jsonOutput([
                'status' => 'success',
                'mess' => $nv_Lang->getModule('save_success')
            ]);
        }
    }
    nv_jsonOutput([
        'status' => 'error',
        'mess' => $nv_Lang->getModule('error_mess')
    ]);
}

if ($nv_Request->isset_request('change_status', 'post')) {
    $id = $nv_Request->get_int('id', 'post', 0);
    $listid = $nv_Request->get_title('listid', 'post', '');
    $id_array = array_map('intval', explode(',', $listid));
    $id_array = array_filter($id_array);
    $_listid = '';
    if (!empty($id_array)) {
        $_listid = implode(',', $id_array);
    }
    $action = $nv_Request->get_title('action', 'post', '');
    $status = $nv_Request->get_int('status', 'post', 0);
    if (!csrf_check($checkss, $csrf_key)) {
        nv_jsonOutput([
            'status' => 'error',
            'mess' => $nv_Lang->getModule('error_checkss')
        ]);
    }
    if (!empty($id) || !empty($_listid)) {
        $where = !empty($_listid) ? " WHERE id IN (" . $_listid . ")" : " WHERE id = " . $id;
        $status_map = [
            'active' => 1,
            'wait' => 0,
            'stop' => 2
        ];
        $status = $status_map[$action] ?? $status;
        $exc = $db->exec("UPDATE " . $db_config['prefix'] . "_" . NV_LANG_DATA . "_" . $module_data . "_detail SET status = " . $status . ", updated_time = " . NV_CURRENTTIME . $where);
        if ($exc) {
            $nv_Cache->delMod($module_name);
            nv_jsonOutput([
                'status' => 'success',
                'mess' => $nv_Lang->getModule('save_success')
            ]);
        }
    }
    nv_jsonOutput([
        'status' => 'error',
        'mess' => $nv_Lang->getModule('error_mess')
    ]);
}

$base_url = NV_BASE_ADMINURL . "index.php?" . NV_LANG_VARIABLE . "=" . NV_LANG_DATA . "&amp;" . NV_NAME_VARIABLE . "=" . $module_name . "&" . NV_OP_VARIABLE . "=" . $op;
$_where = [];

if (!empty($array_search['keyword'])) {
    $base_url .= '&amp;q=' . $array_search['keyword'];
    $_where[] = "(title LIKE " . $db->quote("%" . $array_search['keyword'] . "%") . " OR description LIKE " . $db->quote("%" . $array_search['keyword'] . "%") . ")";
}
if ($array_search['status'] >= 0) {
    $base_url .= '&amp;status=' . $array_search['status'];
    $_where[] = "status=" . $array_search['status'];
}
if (!empty($array_search['type_popup'])) {
    $base_url .= '&amp;type_popup=' . $array_search['type_popup'];
    $_where[] = "popup_type=" . $db->quote($array_search['type_popup']);
}
if (!empty($array_search['display_layout'])) {
    $base_url .= '&amp;display_layout=' . $array_search['display_layout'];
    $_where[] = "display_layout=" . $array_search['display_layout'];
}

if (!empty($array_search['start_time'])) {
    $base_url .= '&amp;start_time=' . $array_search['start_time'];
    // Popup phải kết thúc sau khi thời gian tìm kiếm bắt đầu (hoặc là popup giới hạn thời gian hiển thị)
    $_where[] = "(end_time >= " . $array_search['t_start_time'] . " OR end_time = 0)";
}
if (!empty($array_search['end_time'])) {
    $base_url .= '&amp;end_time=' . $array_search['end_time'];
    // Popup phải bắt đầu trước khi thời gian tìm kiếm kết thúc
    $_where[] = "start_time <= " . $array_search['t_end_time'];
}

$db->sqlreset()
    ->select('COUNT(*)')
    ->from($db_config['prefix'] . "_" . NV_LANG_DATA . "_" . $module_data . "_detail");

if (!empty($_where)) {
    $db->where(implode(' AND ', $_where));
}

$sth = $db->prepare($db->sql());
$sth->execute();
$all_page = $sth->fetchColumn();

$db->select('*')
    ->order('created_time DESC')
    ->limit($per_page)
    ->offset(($page - 1) * $per_page);
$sth = $db->prepare($db->sql());
$sth->execute();
$stt = 1;
if ($page > 1) {
    $stt = ($page - 1) * $per_page + 1;
}
while ($row = $sth->fetch()) {
    $row['stt'] = $stt++;
    $row['start_time'] = nv_date("H:i d/m/Y", $row['start_time']);
    $row['end_time'] = !empty($row['end_time']) ? nv_date('H:i d/m/Y', $row['end_time']) : $nv_Lang->getModule('no_end_date');
    $row['label_status'] = $row['status'] == 1 ? 'success' : ($row['status'] == 2 ? 'danger' : 'warning');
    $row['status'] = $nv_Lang->getModule('status_' . $row['status']);
    $row['popup_type'] = isset($arr_type_popup[$row['popup_type']]) ? $arr_type_popup[$row['popup_type']] : '';
    $row['total_view'] = nv_number_format($row['total_view'] ?? 0);
    $row['total_click'] = nv_number_format($row['total_click'] ?? 0);
    $row['total_closed'] = nv_number_format($row['total_closed'] ?? 0);
    $row['total_click_view'] = nv_number_format($row['total_click']) . '/' . nv_number_format($row['total_view']);
    $row['display_layout'] = $nv_Lang->getModule('display_layout_' . $row['display_layout']);
    $row['link'] = NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&amp;' . NV_NAME_VARIABLE . '=' . $module_name . '&amp;' . NV_OP_VARIABLE . '=detail&amp;id=' . $row['id'];
    $row['link_edit'] = NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&amp;' . NV_NAME_VARIABLE . '=' . $module_name . '&amp;' . NV_OP_VARIABLE . '=add&amp;id=' . $row['id'];
    $row['link_preview'] = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&amp;preview_id=' . $row['id'] . '&preview_only=1';
    $array_data[] = $row;
}
$generate_page = nv_generate_page($base_url, $all_page, $per_page, $page);
$array_list_action = [
    'active' => $nv_Lang->getModule('status_1'),
    'stop' => $nv_Lang->getModule('status_2'),
    'wait' => $nv_Lang->getModule('status_0')
];
if ($admin_info['level'] <= 2) {
    $array_list_action['delete'] = $nv_Lang->getGlobal('delete');
}

$stpl = new \NukeViet\Template\NVSmarty();
$stpl->setTemplateDir(get_module_tpl_dir('main.tpl'));
$stpl->assign('LANG', $nv_Lang);
$stpl->assign('NV_LANG_VARIABLE', NV_LANG_VARIABLE);
$stpl->assign('NV_LANG_DATA', NV_LANG_DATA);
$stpl->assign('NV_BASE_ADMINURL', NV_BASE_ADMINURL);
$stpl->assign('NV_NAME_VARIABLE', NV_NAME_VARIABLE);
$stpl->assign('NV_OP_VARIABLE', NV_OP_VARIABLE);
$stpl->assign('CHECKSS', csrf_create($csrf_key));
$stpl->assign('DATA', $array_data);
$stpl->assign('GENERATE_PAGE', $generate_page);
$stpl->assign('SEARCH', $array_search);
$stpl->assign('STATUS', $_arr_status);
$stpl->assign('TYPE_POPUP', $arr_type_popup);
$stpl->assign('LAYOUT', $arr_layout);
$stpl->assign('ACTIONS', $array_list_action);
$stpl->assign('ADMIN_LEV', $admin_info['level']);
$contents = $stpl->fetch('main.tpl');

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
