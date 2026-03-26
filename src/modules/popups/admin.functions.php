<?php

/**
 * @Project NUKEVIET 5.x
 * @Author VINADES.,JSC <contact@vinades.vn>
 * @Copyright (C) 2020 VINADES.,JSC. All rights reserved
 * @License: Not free read more http://nukeviet.vn/vi/store/modules/nvtools/
 * @Createdate Tue, 02 Mar 2026 09:11:42 GMT
 */

if (!defined('NV_ADMIN') or !defined('NV_MAINFILE') or !defined('NV_IS_MODADMIN')) {
    die('Stop!!!');
}

define('NV_IS_FILE_ADMIN', true);

$allow_func = ['main', 'config', 'add', 'detail', 'statics'];

$csrf_key = defined('NV_IS_USER') ? $user_info['userid'] . '_' . $module_name . '_' . $op : $module_name . '_' . $op;

$_arr_status = array (
    1 => $nv_Lang->getModule('status_1'),
    0 => $nv_Lang->getModule('status_0'),
    2 => $nv_Lang->getModule('status_2')
);
$arr_layout = array(    
    1 => $nv_Lang->getModule('display_layout_1'),
    2 => $nv_Lang->getModule('display_layout_2')
);
$arr_device = array(
    1 => $nv_Lang->getModule('display_device_1'),
    2 => $nv_Lang->getModule('display_device_2'),
    3 => $nv_Lang->getModule('display_device_3')
);
$arr_object = array(
    0 => $nv_Lang->getModule('all'),
    1 => $nv_Lang->getModule('display_object_1'),
    2 => $nv_Lang->getModule('display_object_2')
);
$arr_window_click = array(
    '_blank' => $nv_Lang->getModule('blank_click'),
    '_self' => $nv_Lang->getModule('self_click')
);
$arr_type_popup = array(    
    'noti' => $nv_Lang->getModule('notification'),
    'prom' => $nv_Lang->getModule('promotions')
);
