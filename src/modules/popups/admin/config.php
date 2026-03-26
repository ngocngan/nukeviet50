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

$page_title = $nv_Lang->getModule('config');
$submit = $nv_Request->get_title('submit', 'post');
if (!empty($submit)) {
    $data = [];
    $data['display_layout'] = $nv_Request->get_int('display_layout', 'post,get', 0);
    $data['popup_delay'] = $nv_Request->get_title('popup_delay', 'post,get', 0);
    $data['display_frequency'] = $nv_Request->get_int('display_frequency', 'post,get', 0);
    $data['display_device'] = $nv_Request->get_int('display_device', 'post,get', 0);
    $data['display_object'] = $nv_Request->get_int('display_object', 'post,get', 0);
    $data['close_on_outside_click'] = $nv_Request->get_int('close_on_outside_click', 'post,get', 0);

    $sth = $db->prepare("UPDATE " . $db_config['prefix'] . "_" . $module_data . "_config SET config_value = :config_value WHERE config_name = :config_name");
    foreach ($data as $config_name => $config_value) {
        $sth->bindParam(':config_name', $config_name, PDO::PARAM_STR);
        $sth->bindParam(':config_value', $config_value, PDO::PARAM_STR);
        $exc = $sth->execute();
    }
    $nv_Cache->delMod($module_name);    
}

$sql = "SELECT config_name, config_value FROM " . $db_config['prefix'] . "_" . $module_data . "_config";
$result = $db->query($sql);
$array_data = [];
$array_data['display_device'] = $array_data['display_layout'] = $array_data['display_object'] = 1;

while ($row = $result->fetch()) {
    $array_data[$row['config_name']] = $row['config_value'];        
}
(isset($array_data['close_on_outside_click']) and $array_data['close_on_outside_click'] == 1) && $array_data['checked'] = 'checked';

$stpl = new \NukeViet\Template\NVSmarty();
$stpl->setTemplateDir(get_module_tpl_dir('config.tpl'));
$stpl->assign('LANG', $nv_Lang);
$stpl->assign('NV_LANG_VARIABLE', NV_LANG_VARIABLE);
$stpl->assign('NV_LANG_DATA', NV_LANG_DATA);
$stpl->assign('NV_BASE_ADMINURL', NV_BASE_ADMINURL);
$stpl->assign('NV_NAME_VARIABLE', NV_NAME_VARIABLE);
$stpl->assign('NV_OP_VARIABLE', NV_OP_VARIABLE);
$stpl->assign('MODULE_NAME', $module_name);
$stpl->assign('DATA', $array_data);
$stpl->assign('OP', $op);

$display_device_arr = array(
    1 => $nv_Lang->getModule('display_device_1'),
    2 => $nv_Lang->getModule('display_device_2'),
    3 => $nv_Lang->getModule('display_device_3')
);
$display_layout_arr = array(
    1 => $nv_Lang->getModule('display_layout_1'),
    2 => $nv_Lang->getModule('display_layout_2')
);
$display_object_arr = array(
    0 => $nv_Lang->getModule('all'),
    1 => $nv_Lang->getModule('display_object_1'),
    2 => $nv_Lang->getModule('display_object_2')
);
$stpl->assign('DISPLAY_LAYOUT', $display_layout_arr);
$stpl->assign('DISPLAY_DEVICE', $display_device_arr);
$stpl->assign('DISPLAY_OBJECT', $display_object_arr);

$contents = $stpl->fetch('config.tpl');

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
