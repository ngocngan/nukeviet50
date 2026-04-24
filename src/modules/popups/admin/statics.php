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

$page_title = $nv_Lang->getModule('statics');
$page = $nv_Request->get_page('page', 'get', 1);
$per_page = 15;
$array_data = $array_search = [];
$array_search['status'] = $nv_Request->get_int('status', 'get', -1);
$array_search['show_page'] = $nv_Request->get_title('show_page', 'get', 0);
$array_search['type_popup'] = $nv_Request->get_title('type_popup', 'get', '');
$array_search['display_layout'] = $nv_Request->get_int('display_layout', 'get', 0);
$array_search['display_object'] = $nv_Request->get_int('display_object', 'get', 0);
$array_search['start_time'] = $nv_Request->get_title('start_time', 'get', '');
$array_search['end_time'] = $nv_Request->get_title('end_time', 'get', '');
$array_search['t_start_time'] = nv_d2u_get($array_search['start_time']);
$array_search['t_end_time'] = nv_d2u_get($array_search['end_time'], 23, 59, 59);

if (!empty($array_search['t_start_time']) && !empty($array_search['t_end_time']) && $array_search['t_start_time'] > $array_search['t_end_time']) {
    $array_search['start_time'] = '';
    $array_search['t_start_time'] = 0;
}

$base_url = NV_BASE_ADMINURL . "index.php?" . NV_LANG_VARIABLE . "=" . NV_LANG_DATA . "&amp;" . NV_NAME_VARIABLE . "=" . $module_name . "&" . NV_OP_VARIABLE . "=" . $op;

$_where = [];
if ($array_search['status'] >= 0) {
    $base_url .= '&amp;status=' . $array_search['status'];
    $_where[] = "status=" . $array_search['status'];
}
if (!empty($array_search['type_popup'])) {
    $base_url .= '&amp;type_popup=' . urlencode($array_search['type_popup']);
    $_where[] = "popup_type=" . $db->quote($array_search['type_popup']);
}
if (!empty($array_search['display_layout'])) {
    $base_url .= '&amp;display_layout=' . $array_search['display_layout'];
    $_where[] = "display_layout=" . $array_search['display_layout'];
}
if (!empty($array_search['display_object'])) {
    $base_url .= '&amp;display_object=' . $array_search['display_object'];
    $_where[] = "display_object=" . $array_search['display_object'];
}
if (!empty($array_search['start_time'])) {
    $base_url .= '&amp;start_time=' . $array_search['start_time'];
    $_where[] = "start_time>=" . $array_search['t_start_time'];
}
if (!empty($array_search['end_time'])) {
    $base_url .= '&amp;end_time=' . $array_search['end_time'];
    $_where[] = "end_time<=" . $array_search['t_end_time'] . " AND end_time > 0";
}

$db->sqlreset()
    ->select('COUNT(*)')
    ->from($db_config['prefix'] . "_" . NV_LANG_DATA . "_" . $module_data . "_detail");
if (!empty($_where)) {
    $db->where(implode(' AND ', $_where));
    $where_statics = ' WHERE ' . implode(' AND ', $_where);
}

$sth = $db->prepare($db->sql());
$sth->execute();
$all_page = $sth->fetchColumn();

$db->select('*')
    ->order('updated_time DESC')
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
    $row['ctr_click_view'] = ($row['total_view'] > 0) ? round($row['total_click'] / $row['total_view'] * 100, 2) . '%' : '0%';
    $row['ctr_closed_view'] = ($row['total_view'] > 0) ? round($row['total_closed'] / $row['total_view'] * 100, 2) . '%' : '0%';
    $row['total_click'] = nv_number_format($row['total_click']);
    $row['total_closed'] = nv_number_format($row['total_closed']);
    $row['total_view'] = nv_number_format($row['total_view']);
    $row['link'] = NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&amp;' . NV_NAME_VARIABLE . '=' . $module_name . '&amp;' . NV_OP_VARIABLE . '=detail&amp;id=' . $row['id'];
    $array_data[] = $row;
}
$generate_page = nv_generate_page($base_url, $all_page, $per_page, $page);

$db->sqlreset()
    ->select('SUM(total_view) as total_view, SUM(total_click) as total_click, SUM(total_closed) as total_closed')
    ->from($db_config['prefix'] . "_" . NV_LANG_DATA . "_" . $module_data . "_detail");
if (!empty($_where)) {
    $db->where(implode(' AND ', $_where));
}
$sth = $db->prepare($db->sql());
$sth->execute();
$static = $sth->fetch();

$static['ctr_click_view'] = ($static['total_view'] > 0) ? round($static['total_click'] / $static['total_view'] * 100, 2) . '%' : '0%';
$static['ctr_closed_view'] = ($static['total_view'] > 0) ? round($static['total_closed'] / $static['total_view'] * 100, 2) . '%' : '0%';
$static['total_click'] = nv_number_format($static['total_click'] ?? 0);
$static['total_closed'] = nv_number_format($static['total_closed'] ?? 0);
$static['total_view'] = nv_number_format($static['total_view'] ?? 0);

$stpl = new \NukeViet\Template\NVSmarty();
$stpl->setTemplateDir(get_module_tpl_dir('statics.tpl'));
$stpl->assign('LANG', $nv_Lang);
$stpl->assign('NV_LANG_VARIABLE', NV_LANG_VARIABLE);
$stpl->assign('NV_LANG_DATA', NV_LANG_DATA);
$stpl->assign('NV_BASE_ADMINURL', NV_BASE_ADMINURL);
$stpl->assign('NV_NAME_VARIABLE', NV_NAME_VARIABLE);
$stpl->assign('NV_OP_VARIABLE', NV_OP_VARIABLE);
$stpl->assign('STATICS', $static);
$stpl->assign('DATA', $array_data);
$stpl->assign('GENERATE_PAGE', $generate_page);
$stpl->assign('SEARCH', $array_search);
$stpl->assign('STATUS', $_arr_status);
$stpl->assign('TYPE_POPUP', $arr_type_popup);
$stpl->assign('LAYOUT', $arr_layout);
$stpl->assign('OBJECT', $arr_object);
$contents = $stpl->fetch('statics.tpl');

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
