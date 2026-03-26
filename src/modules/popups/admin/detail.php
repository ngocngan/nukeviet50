<?php

/**
 * @Project NUKEVIET 5.x
 * @Author VINADES.,JSC <contact@vinades.vn>
 * @Copyright (C) 2020 VINADES.,JSC. All rights reserved
 * @License: Not free read more http://nukeviet.vn/vi/store/modules/nvtools/
 * @Createdate Tue, 02 Mar 2026 09:11:42 GMT
 */

if (!defined('NV_IS_FILE_ADMIN')) {
    die('Stop!!!');
}

$id = $nv_Request->get_int('id', 'get, post', 0);
$page_title = $nv_Lang->getModule('detail_popup');
$sql = "SELECT * FROM " . $db_config['prefix'] . "_" . NV_LANG_DATA . "_" . $module_data . "_detail WHERE id=" . $id;
$detail = $db->query($sql)->fetch();
$array_data = [];
if (empty($detail)) {
    nv_redirect_location(NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name);
}
$nv_checkss = md5(NV_CHECK_SESSION . '_' . $module_name . '_' . $op . '_' . $admin_info['userid']);
$checkss = $nv_Request->get_title('checkss', 'post,get', '');

if ($nv_Request->isset_request('change_status', 'post, get') and hash_equals($nv_checkss, $checkss)) {
    $id = $nv_Request->get_int('id', 'post,get', 0);    
    if (!empty($id)) {        
        if ($nv_Request->isset_request('status', 'post, get')) {
            $status = $nv_Request->get_int('status', 'post', 0);
            $row = $db->query("SELECT id FROM " . $db_config['prefix'] . "_" . NV_LANG_DATA . "_" . $module_data . "_detail WHERE id=" . $id)->fetchColumn();
            if (empty($row)) {
                nv_htmlOutput('NO|ID_' . $id);
            }
            $exc = $db->exec("UPDATE " . $db_config['prefix'] . "_" . NV_LANG_DATA . "_" . $module_data . "_detail SET status = " . $status . ", updated_time = " . NV_CURRENTTIME . "  WHERE id = " . $id);
            if ($exc) {
                nv_htmlOutput('OK');
            }
            nv_htmlOutput('ERROR');
        } else {        
            $row = $db->query("SELECT id, status, start_time, end_time FROM " . $db_config['prefix'] . "_" . NV_LANG_DATA . "_" . $module_data . "_detail WHERE id=" . $id)->fetch();
            if (empty($row)) {
                nv_htmlOutput('NO|ID_' . $id);
            }
            if ($row['status'] == 1) {
                $status = 3;
            } else if ($row['status'] == 3) {
                $status = 1;
            }
            $exc = $db->exec("UPDATE " . $db_config['prefix'] . "_" . NV_LANG_DATA . "_" . $module_data . "_detail SET status = " . $status . " WHERE id = " . $id);
            if ($exc) {
                $nv_Cache->delMod($module_name);
                nv_htmlOutput('OK');            
            }
        }
    }
    nv_htmlOutput('ERROR');
}

$detail['start_time'] = nv_date('H:i d/m/Y', $detail['start_time']);
$detail['end_time'] = nv_date('H:i d/m/Y', $detail['end_time']);
$detail['created_time'] = nv_date('H:i d/m/Y', $detail['created_time']);
$detail['label_status'] = $detail['status'] == 1 ? 'success' : ($detail['status'] == 2 ? 'danger' : 'warning');
$detail['status_txt'] = $nv_Lang->getModule('status_' . $detail['status']);

$array_data['data'][] = ['id', $detail['id']];
$array_data['data'][] = [$nv_Lang->getModule('title'), $detail['title']];
$array_data['data'][] = [$nv_Lang->getModule('description'), $detail['description']];
$array_data['data'][] = [$nv_Lang->getModule('show_page'), $detail['is_all_page']];
$array_data['data'][] = [$nv_Lang->getModule('type_popup'), $detail['popup_type']];
$array_data['data'][] = [$nv_Lang->getModule('display_layout'), $arr_layout[$detail['display_layout']] ?? ''];
$array_data['data'][] = [$nv_Lang->getModule('display_object'), $arr_object[$detail['display_object']] ?? ''];
$array_data['data'][] = [$nv_Lang->getModule('display_device'), $arr_device[$detail['display_device']] ?? ''];
$array_data['data'][] = [$nv_Lang->getModule('priority'), $detail['priority']];
$array_data['data'][] = [$nv_Lang->getModule('start_time'), $detail['start_time']];
$array_data['data'][] = [$nv_Lang->getModule('end_time'), $detail['end_time']];
$array_data['data'][] = [$nv_Lang->getModule('status'), $_arr_status[$detail['status']]];
$array_data['data'][] = [$nv_Lang->getModule('url_click'), $detail['url']];
$array_data['data'][] = [$nv_Lang->getModule('window_click'), $arr_window_click[$detail['type_open']] ?? ''];
$array_data['data'][] = [$nv_Lang->getModule('total_view'), $detail['total_view']];
$array_data['data'][] = [$nv_Lang->getModule('total_click'), $detail['total_click']];
$array_data['data'][] = [$nv_Lang->getModule('total_closed'), $detail['total_closed']];
$array_data['data'][] = [$nv_Lang->getModule('created_date'), $detail['created_time']];
$array_data['link_edit'] = NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&amp;' . NV_NAME_VARIABLE . '=' . $module_name . '&amp;' . NV_OP_VARIABLE . '=add&amp;id=' . $detail['id'];
$array_data['link_preview'] = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&amp;' . NV_NAME_VARIABLE . '=' . $module_name . '&amp;' . NV_OP_VARIABLE . '=main&amp;preview=' . $detail['id'];

$base_url = NV_BASE_ADMINURL . "index.php?" . NV_LANG_VARIABLE . "=" . NV_LANG_DATA . "&amp;" . NV_NAME_VARIABLE . "=" . $module_name . "&" . NV_OP_VARIABLE . "=" . $op;

$stpl = new \NukeViet\Template\NVSmarty();
$stpl->setTemplateDir(get_module_tpl_dir('detail.tpl'));
$stpl->assign('LANG', $nv_Lang);
$stpl->assign('NV_LANG_VARIABLE', NV_LANG_VARIABLE);
$stpl->assign('NV_LANG_DATA', NV_LANG_DATA);
$stpl->assign('NV_BASE_ADMINURL', NV_BASE_ADMINURL);
$stpl->assign('NV_NAME_VARIABLE', NV_NAME_VARIABLE);
$stpl->assign('NV_OP_VARIABLE', NV_OP_VARIABLE);
$stpl->assign('DATA', $array_data);
$stpl->assign('DETAIL', $detail);
$stpl->assign('CHECKSS', $nv_checkss);
$contents = $stpl->fetch('detail.tpl');

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
