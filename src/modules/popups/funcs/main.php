<?php

/**
 * NukeViet Content Management System
 * @version 5.x
 * @author VINADES.,JSC <contact@vinades.vn>
 * @copyright (C) 2009-2026 VINADES.,JSC. All rights reserved
 * @license GNU/GPL version 2 or any later version
 * @see https://github.com/nukeviet The NukeViet CMS GitHub project
 */

if (!defined('NV_IS_MOD_POPUPS')) {
    exit('Stop!!!');
}

if ($nv_Request->isset_request('act', 'post')) {
    global $client_info, $user_info;

    $id = $nv_Request->get_int('id', 'post', 0);
    $act = $nv_Request->get_title('act', 'post', '');
    if ($id <= 0 || !in_array($act, ['view', 'click', 'close'], true)) {
        nv_jsonOutput(['status' => 'error']);
    }
    try {
        $device = !empty($client_info['is_tablet']) ? 3 : (!empty($client_info['is_mobile']) ? 2 : 1);
        $userid = defined('NV_IS_USER') ? (int) ($user_info['userid'] ?? 0) : 0;
        $sthLog = $db->prepare('INSERT INTO ' . $db_config['prefix'] . '_popups_logs (popup_id, userid, act, device, log_time) VALUES (:popup_id, :userid, :act, :device, :log_time)');
        $sthLog->bindParam(':popup_id', $id, PDO::PARAM_INT);
        $sthLog->bindParam(':userid', $userid, PDO::PARAM_INT);
        $sthLog->bindParam(':act', $act, PDO::PARAM_STR);
        $sthLog->bindParam(':device', $device, PDO::PARAM_INT);
        $sthLog->bindValue(':log_time', NV_CURRENTTIME, PDO::PARAM_INT);
        $sthLog->execute();
    } catch (Throwable $e) {
        trigger_error(print_r($e, true));
    }
    $column = $act === 'view' ? 'total_view' : ($act === 'click' ? 'total_click' : 'total_closed');
    $sth = $db->prepare('UPDATE ' . $db_config['prefix'] . '_' . NV_LANG_DATA . '_popups_detail SET ' . $column . '=' . $column . ' + 1 WHERE id=:id');
    $sth->bindParam(':id', $id, PDO::PARAM_INT);
    $sth->execute();
    nv_jsonOutput(['status' => 'OK']);
}

// API: Lấy danh sách popup hợp lệ theo thời điểm hiện tại
if ($nv_Request->get_int('list', 'get', 0) === 1) {
    global $client_info, $user_info;

    $config = [];
    $result = $db->query('SELECT config_name, config_value FROM ' . $db_config['prefix'] . '_popups_config');
    while ($c = $result->fetch()) {
        $config[$c['config_name']] = $c['config_value'];
    }

    $now = NV_CURRENTTIME;
    $where = [];
    $where[] = 'status=1';
    $where[] = 'start_time<=' . $now;
    $where[] = '(end_time=0 OR end_time>=' . $now . ')';
    $defaultPriority = (int) ($config['default_priority'] ?? 1);
    $sql = 'SELECT id, title, description, content, popup_type, priority, display_layout, display_type, display_interval, max_show, url, type_open, css_class, display_device, display_object, is_all_page, list_id_page, updated_time FROM ' . $db_config['prefix'] . '_' . NV_LANG_DATA . '_popups_detail WHERE ' . implode(' AND ', $where) . ' ORDER BY (CASE WHEN priority=0 THEN ' . $defaultPriority . ' ELSE priority END) DESC, updated_time DESC';
    $popups = [];
    $closeText = $nv_Lang->getGlobal('close');
    $viewMoreText = $nv_Lang->getGlobal('view_more');
    $pid = $nv_Request->get_int('pid', 'get', 0);
    $previewId = $nv_Request->get_int('preview_id', 'get', 0);
    $userid = defined('NV_IS_USER') ? (int) ($user_info['userid'] ?? 0) : 0;
    $isPreview = false;
    $previewOnly = $nv_Request->get_int('preview_only', 'get', 0);
    if ($previewOnly < 1) {
        $previewOnly = $nv_Request->get_int('isonly', 'get', 0);
    }
    $previewRow = null;
    $previewEffectivePriority = 0;
    $previewUpdatedTime = 0;
    if ($previewId > 0) {
        $sthPreview = $db->prepare('SELECT id, title, description, content, popup_type, priority, display_layout, url, type_open, css_class, updated_time, created_by FROM ' . $db_config['prefix'] . '_' . NV_LANG_DATA . '_popups_detail WHERE id=:id LIMIT 1');
        $sthPreview->bindParam(':id', $previewId, PDO::PARAM_INT);
        $sthPreview->execute();
        $previewRow = $sthPreview->fetch();
        if (!empty($previewRow)) {
            $isPreview = defined('NV_IS_ADMIN') || ($userid > 0 && (int) $previewRow['created_by'] === $userid);
        }
        if ($isPreview) {
            $previewEffectivePriority = (int) $previewRow['priority'];
            if ($previewEffectivePriority <= 0) {
                $previewEffectivePriority = $defaultPriority;
            }
            $previewUpdatedTime = (int) $previewRow['updated_time'];
        } else {
            $previewRow = null;
        }
    }
    $res = $db->query($sql);
    while ($row = $res->fetch()) {
        $rowId = (int) $row['id'];
        if ($isPreview && $rowId === $previewId) {
            continue;
        }
        if ($isPreview && $previewOnly > 0) {
            continue;
        }
        if ($pid > 0 && (int) $row['is_all_page'] !== 1) {
            $ids = array_filter(array_map('trim', explode(',', (string) $row['list_id_page'])), static function ($v) {
                return $v !== '';
            });
            $ids = array_map('intval', $ids);
            if (empty($ids) || !in_array($pid, $ids, true)) {
                continue;
            }
        }
        $dev = (int) ($row['display_device'] ?: $config['display_device']);
        $obj = (string) ($row['display_object'] !== '' ? $row['display_object'] : $config['display_object']);
        $isDeviceOk = ($dev == 1) || ($client_info['is_mobile'] && $dev == 2) || ((!$client_info['is_mobile'] && !$client_info['is_tablet']) && $dev == 3);
        $isObjectOk = ($obj === '0') || ((defined('NV_IS_USER')) ? ($obj === '1') : ($obj === '2'));
        if (!$isDeviceOk || !$isObjectOk) {
            continue;
        }
        $priority = (int) $row['priority'];
        if ($priority <= 0) {
            $priority = $defaultPriority;
        }
        if ($isPreview) {
            if ($priority < $previewEffectivePriority) {
                continue;
            }
            if ($priority === $previewEffectivePriority && (int) $row['updated_time'] <= $previewUpdatedTime) {
                continue;
            }
        }
        $popups[] = [
            'id' => $rowId,
            'priority' => $priority,
            'updated_time' => (int) $row['updated_time'],
            'title' => $row['title'],
            'description' => $row['description'],
            'content' => $row['content'],
            'layout' => (int) ($row['display_layout'] ?: $config['display_layout']),
            'display_type' => (int) $row['display_type'],
            'display_interval' => (int) $row['display_interval'],
            'max_show' => (int) $row['max_show'],
            'url' => $row['url'],
            'target' => $row['type_open'],
            'css_class' => $row['css_class'],
            'delay' => $isPreview ? 0 : (int) $config['popup_delay'],
            'freq' => $isPreview ? 0 : (int) $config['display_frequency'],
            'close_outside' => (int) $config['close_on_outside_click'],
            'close_text' => $closeText,
            'view_more_text' => $viewMoreText,
            'track_url' => NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=main'
        ];
    }
    if ($isPreview && !empty($previewRow)) {
        $popups[] = [
            'id' => (int) $previewRow['id'],
            'priority' => $previewEffectivePriority,
            'updated_time' => $previewUpdatedTime,
            'title' => $previewRow['title'],
            'description' => $previewRow['description'],
            'content' => $previewRow['content'],
            'layout' => (int) ($previewRow['display_layout'] ?: $config['display_layout']),
            'display_type' => 4,
            'display_interval' => 0,
            'max_show' => 0,
            'url' => $previewRow['url'],
            'target' => $previewRow['type_open'],
            'css_class' => $previewRow['css_class'],
            'delay' => 0,
            'freq' => 0,
            'close_outside' => (int) $config['close_on_outside_click'],
            'close_text' => $closeText,
            'view_more_text' => $viewMoreText,
            'track_url' => NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=main'
        ];
    }
    nv_jsonOutput([
        'popups' => $popups,
        'preview_mode' => $isPreview ? 1 : 0
    ]);
}

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme('');
include NV_ROOTDIR . '/includes/footer.php';
