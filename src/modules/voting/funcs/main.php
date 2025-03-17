<?php

/**
 * NukeViet Content Management System
 * @version 5.x
 * @author VINADES.,JSC <contact@vinades.vn>
 * @copyright (C) 2009-2025 VINADES.,JSC. All rights reserved
 * @license GNU/GPL version 2 or any later version
 * @see https://github.com/nukeviet The NukeViet CMS GitHub project
 */

if (!defined('NV_IS_MOD_VOTING')) {
    exit('Stop!!!');
}

$page_url = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name;
$vid = $nv_Request->get_int('vid', 'get,post', 0);

//  Danh sách bình chọn
if (empty($vid)) {
    $canonicalUrl = getCanonicalUrl($page_url, true, true);

    $page_title = $module_info['site_title'];
    $key_words = $module_info['keywords'];

    $sql = 'SELECT vid, question, link, acceptcm, active_captcha, groups_view, publ_time, exp_time FROM ' . NV_PREFIXLANG . '_' . $module_data . ' WHERE act=1 ORDER BY publ_time DESC';
    $list = $nv_Cache->db($sql, 'vid', 'voting');

    $allowed = [];
    $is_update = [];

    if (!empty($list)) {
        $a = 0;
        foreach ($list as $row) {
            if ($row['exp_time'] > 0 and $row['exp_time'] < NV_CURRENTTIME) {
                $is_update[] = $row['vid'];
            } elseif ($row['publ_time'] <= NV_CURRENTTIME and nv_user_in_groups($row['groups_view'])) {
                $allowed[$a] = $row;
                ++$a;
            }
        }
    }

    if (!empty($is_update)) {
        $is_update = implode(',', $is_update);

        $sql = 'UPDATE ' . NV_PREFIXLANG . '_' . $module_data . ' SET act=0 WHERE vid IN (' . $is_update . ')';
        $db->query($sql);

        $nv_Cache->delMod($module_name);
    }

    if (!empty($allowed)) {
        $xtpl = new XTemplate('main.tpl', get_module_tpl_dir('main.tpl'));
        $xtpl->assign('LANG', \NukeViet\Core\Language::$lang_module);

        foreach ($allowed as $current_voting) {
            $voting_array = [
                'checkss' => md5($current_voting['vid'] . NV_CHECK_SESSION),
                'accept' => (int) $current_voting['acceptcm'],
                'active_captcha' => (int) $current_voting['active_captcha'],
                'errsm' => (int) $current_voting['acceptcm'] > 1 ? $nv_Lang->getModule('voting_warning_all', (int) $current_voting['acceptcm']) : $nv_Lang->getModule('voting_warning_accept1'),
                'vid' => $current_voting['vid'],
                'question' => (empty($current_voting['link'])) ? $current_voting['question'] : '<a target="_blank" href="' . $current_voting['link'] . '">' . $current_voting['question'] . '</a>',
                'action' => NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&amp;' . NV_NAME_VARIABLE . '=' . $module_name,
                'langresult' => $nv_Lang->getModule('voting_result'),
                'langsubmit' => $nv_Lang->getModule('voting_hits'),
                'publtime' => nv_datetime_format($current_voting['publ_time'], 1, 0)
            ];
            $xtpl->assign('VOTING', $voting_array);

            $sql = 'SELECT id, vid, title, url FROM ' . NV_PREFIXLANG . '_' . $site_mods['voting']['module_data'] . '_rows WHERE vid = ' . $current_voting['vid'] . ' ORDER BY id ASC';
            $list = $nv_Cache->db($sql, '', $module_name);

            foreach ($list as $row) {
                if (!empty($row['url'])) {
                    $row['title'] = '<a target="_blank" href="' . $row['url'] . '">' . $row['title'] . '</a>';
                }
                $xtpl->assign('RESULT', $row);
                if ((int) $current_voting['acceptcm'] > 1) {
                    $xtpl->parse('main.loop.resultn');
                } else {
                    $xtpl->parse('main.loop.result1');
                }
            }

            if ($voting_array['active_captcha']) {
                if ($module_captcha == 'recaptcha' and $global_config['recaptcha_ver'] == 3) {
                    $xtpl->parse('main.loop.recaptcha3');
                } elseif (($module_captcha == 'recaptcha' and $global_config['recaptcha_ver'] == 2) or $module_captcha == 'captcha') {
                    if ($module_captcha == 'recaptcha' and $global_config['recaptcha_ver'] == 2) {
                        $xtpl->assign('RECAPTCHA_ELEMENT', 'recaptcha' . nv_genpass(8));
                        $xtpl->assign('N_CAPTCHA', $nv_Lang->getGlobal('securitycode1'));
                        $xtpl->parse('main.loop.has_captcha.recaptcha');
                    } else {
                        $xtpl->assign('N_CAPTCHA', $nv_Lang->getGlobal('securitycode'));
                        $xtpl->parse('main.loop.has_captcha.basic');
                    }
                    $xtpl->parse('main.loop.has_captcha');
                }
            }

            $xtpl->parse('main.loop');
        }

        $xtpl->parse('main');
        $contents = $xtpl->text('main');
    }

    include NV_ROOTDIR . '/includes/header.php';
    echo nv_site_theme($contents);
    include NV_ROOTDIR . '/includes/footer.php';
}

// Chi tiết + bình chọn
$sql = 'SELECT vid, question, acceptcm, active_captcha, groups_view, publ_time, exp_time, vote_one FROM ' . NV_PREFIXLANG . '_' . $module_data;
if (!defined('NV_IS_MODADMIN')) {
    $sql .= ' WHERE act=1';
}
$list = $nv_Cache->db($sql, 'vid', 'voting');
if (empty($list) or !isset($list[$vid])) {
    nv_redirect_location(nv_url_rewrite($page_url, true));
}

$row = $list[$vid];
if (((int) $row['exp_time'] < 0 or ((int) $row['exp_time'] > 0 and $row['exp_time'] < NV_CURRENTTIME)) and !defined('NV_IS_MODADMIN')) {
    nv_redirect_location(nv_url_rewrite($page_url, true));
}

if (!nv_user_in_groups($row['groups_view'])) {
    nv_redirect_location(nv_url_rewrite($page_url, true));
}

if ($row['groups_view'] == '5' or $row['groups_view'] == '6') {
    $row['vote_one'] = '0';
}

if (empty($row['vote_one'])) {
    $difftimeout = !empty($module_config[$module_name]['difftimeout']) ? $module_config[$module_name]['difftimeout'] : 3600;
    $dir = NV_ROOTDIR . '/' . NV_LOGS_DIR . '/voting_logs';
    $log_fileext = preg_match('/[a-z]+/i', NV_LOGS_EXT) ? NV_LOGS_EXT : 'log';
    $pattern = '/^(.*)\.' . $log_fileext . '$/i';
    $logs = nv_scandir($dir, $pattern);

    if (!empty($logs)) {
        foreach ($logs as $file) {
            $vtime = filemtime($dir . '/' . $file);

            if (!$vtime or $vtime <= NV_CURRENTTIME - $difftimeout) {
                @unlink($dir . '/' . $file);
            }
        }
    }
}

$note = '';
$is_error = false;

// Gửi bình chọn
if ($nv_Request->isset_request('checkss', 'post')) {
    if ($nv_Request->get_title('checkss', 'post', '') !== md5($vid . NV_CHECK_SESSION)) {
        nv_jsonOutput([
            'status' => 'error',
            'mess' => 'Session error!'
        ]);
    }

    // Kiểm tra captcha nếu thăm dò có bật
    if ($row['active_captcha']) {
        unset($fcaptcha);

        if ($module_captcha == 'recaptcha') {
            // Xác định giá trị của captcha nhập vào nếu sử dụng reCaptcha
            $fcaptcha = $nv_Request->get_title('g-recaptcha-response', 'post', '');
        } elseif ($module_captcha == 'turnstile') {
            // Xác định giá trị của captcha nhập vào nếu sử dụng Turnstile
            $fcaptcha = $nv_Request->get_title('cf-turnstile-response', 'post', '');
        } elseif ($module_captcha == 'captcha') {
            // Xác định giá trị của captcha nhập vào nếu sử dụng captcha hình
            $fcaptcha = $nv_Request->get_title('fcode', 'post', '');
        }

        // Kiểm tra tính hợp lệ của captcha nhập vào, nếu không hợp lệ => thông báo lỗi
        if (isset($fcaptcha) and !nv_capcha_txt($fcaptcha, $module_captcha)) {
            nv_jsonOutput([
                'status' => 'error',
                'mess' => ($module_captcha == 'recaptcha') ? $nv_Lang->getGlobal('securitycodeincorrect1') : (($module_captcha == 'turnstile') ? $nv_Lang->getGlobal('securitycodeincorrect2') : $nv_Lang->getGlobal('securitycodeincorrect'))
            ]);
        }
    }

    if (is_array($_POST['option'] ?? '')) {
        $id_answers = $nv_Request->get_typed_array('option', 'post', 'int', []);
    } else {
        $id_answers = [$nv_Request->get_int('option', 'post', 0)];
    }
    $id_answers = array_filter(array_unique($id_answers));
    $num_answers = count($id_answers);
    $only_result = $nv_Request->get_bool('viewresult', 'post', false);

    $result_valid = true;
    if ($num_answers < 1 or $num_answers > $row['acceptcm']) {
        $result_valid = false;
        !$only_result && nv_jsonOutput([
            'status' => 'error',
            'input' => $row['acceptcm'] > 1 ? 'option[' : 'option',
            'mess' => ($row['acceptcm'] > 1) ? $nv_Lang->getModule('voting_warning_all', $row['acceptcm']) : $nv_Lang->getModule('voting_warning_accept1')
        ]);
    }

    if ($result_valid) {
        if (!empty($row['vote_one'])) {
            // Mỗi người chỉ bình chọn một lần
            $is_voted = false;
            $userlist = $db->query('SELECT voted FROM ' . NV_PREFIXLANG . '_' . $module_data . '_voted WHERE vid=' . $vid)->fetchColumn();
            if (!empty($userlist)) {
                if (preg_match('/\,\s*' . $user_info['userid'] . '\s*\,/', ',' . $userlist . ',')) {
                    $is_voted = true;
                }
            }

            if ($is_voted) {
                $note = $nv_Lang->getModule('limit_vote_msg');
                $is_error = true;
            } else {
                $sql = 'UPDATE ' . NV_PREFIXLANG . '_' . $module_data . '_rows SET hitstotal = hitstotal+1
                WHERE vid =' . $vid . ' AND id IN (' . implode(',', $id_answers) . ')';
                $db->query($sql);

                $userlist .= !empty($userlist) ? ',' . $user_info['userid'] : $user_info['userid'];
                $sql = 'INSERT INTO ' . NV_PREFIXLANG . '_' . $module_data . '_voted (vid, voted) VALUES (' . $vid . ", '" . $userlist . "') ON DUPLICATE KEY UPDATE voted = VALUES(voted)";
                $db->query($sql);

                $note = $nv_Lang->getModule('okmsg');
            }
        } else {
            // Bình chọn không cần tài khoản
            $logfile = 'vo' . $vid . '_' . md5(NV_LANG_DATA . $global_config['sitekey'] . $client_info['ip'] . $vid) . '.' . $log_fileext;
            if (file_exists($dir . '/' . $logfile)) {
                $timeout = filemtime($dir . '/' . $logfile);
                $timeout = ceil(($difftimeout - NV_CURRENTTIME + $timeout) / 60);
                $note = $nv_Lang->getModule('timeoutmsg', $timeout);
                $is_error = true;
            } else {
                $sql = 'UPDATE ' . NV_PREFIXLANG . '_' . $module_data . '_rows SET hitstotal = hitstotal+1
                WHERE vid =' . $vid . ' AND id IN (' . implode(',', $id_answers) . ')';
                $db->query($sql);

                file_put_contents($dir . '/' . $logfile, '', LOCK_EX);
                $note = $nv_Lang->getModule('okmsg');
            }
        }
    }
}

$sql = 'SELECT * FROM ' . NV_PREFIXLANG . '_' . $module_data . '_rows WHERE vid = ' . $vid . ' ORDER BY id ASC';
$result = $db->query($sql);

$totalvote = 0;
$vrow = [];

while ($row2 = $result->fetch()) {
    $totalvote += (int) $row2['hitstotal'];
    $vrow[] = $row2;
}

$pubtime = nv_datetime_format($row['publ_time']);
$lang = [
    'total' => $nv_Lang->getModule('voting_total'),
    'counter' => $nv_Lang->getModule('voting_counter'),
    'publtime' => $nv_Lang->getModule('voting_pubtime')
];
$voting = [
    'question' => $row['question'],
    'total' => $totalvote,
    'pubtime' => $pubtime,
    'row' => $vrow,
    'lang' => $lang,
    'note' => $note,
    'is_error' => $is_error
];

$contents = voting_result($voting);

$page_title = $row['question'];
$page_url .= '&amp;vid=' . $vid;
$canonicalUrl = getCanonicalUrl($page_url);

if ($nv_Request->get_int('nv_ajax_voting', 'post', 0)) {
    nv_jsonOutput([
        'status' => 'ok',
        'mess' => '',
        'html' => nv_url_rewrite($contents)
    ]);
}

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
