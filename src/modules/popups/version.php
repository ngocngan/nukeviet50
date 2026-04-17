<?php

/**
 * @Project Module Nukeviet 5.x
 * @Author Webvang.vn (hoang.nguyen@webvang.vn)
 * @copyright 2014 J&A.,JSC. All rights reserved
 * @License GNU/GPL version 2 or any later version
 * @Createdate Tue, 02 Mar 2026 09:11:42 GMT
 */

if (!defined('NV_ADMIN') or !defined('NV_MAINFILE')) {
    exit('Stop!!!');
}

$module_version = array(
    'name' => 'popups',
    'modfuncs' => 'main',
    'is_sysmod' => 0,
    'virtual' => 1,
    'version' => '1.0.00',
    'date' => 'Sat, 02 Mar 2026 00:00:00 GMT',
    'author' => 'ngocngan@vinades.vn',
    'note' => 'Module quản lý popup',
    'uploads_dir' => [
        $module_upload
    ],
    'icon' => '',
);
