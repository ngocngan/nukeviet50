<?php
/**
 * NukeViet Content Management System
 * @version 5.x
 * @author VINADES.,JSC <contact@vinades.vn>
 * @copyright (C) 2009-2026 VINADES.,JSC. All rights reserved
 * @license GNU/GPL version 2 or any later version
 * @see https://github.com/nukeviet The NukeViet CMS GitHub project
 */

if (!defined('NV_MAINFILE')) {
    exit('Stop!!!');
}

$priority = isset($priority) ? $priority : 10;
nv_add_hook('', 'change_site_buffer', $priority, function (&$args, $from_data, $receive_data) {
    $return = $args[1] ?? [];
    $contents = $return[0] ?? '';
    $headers = $return[1] ?? [];

    if (defined('NV_ADMIN')) {
        return null;
    }

    global $global_config, $db, $db_config, $home, $module_name, $op, $nv_Request;
    $themes = [];
    if (!empty($global_config['current_theme_type']) && $global_config['current_theme_type'] === 'm' && !empty($global_config['mobile_theme']) && !str_starts_with($global_config['mobile_theme'], ':')) {
        $themes[] = $global_config['mobile_theme'];
    }
    if (!empty($global_config['site_theme'])) {
        $themes[] = $global_config['site_theme'];
    }
    if (!empty($global_config['module_theme'])) {
        $themes[] = $global_config['module_theme'];
    }
    $themes[] = NV_DEFAULT_SITE_THEME;
    $themes[] = 'default';
    $themes = array_values(array_unique($themes));

    $css = '';
    foreach ($themes as $theme) {
        if (theme_file_exists('/' . $theme . '/css/popups.css')) {
            $css = NV_STATIC_URL . 'themes/' . $theme . '/css/popups.css';
            break;
        }
    }

    $js = '';
    foreach ($themes as $theme) {
        if (theme_file_exists('/' . $theme . '/js/popups.js')) {
            $js = NV_STATIC_URL . 'themes/' . $theme . '/js/popups.js';
            break;
        }
    }

    $pageId = 0;
    try {
        $keys = [];
        if (!empty($home)) {
            $keys[] = 'home';
        }
        if (!empty($module_name)) {
            if (!empty($op) && $op !== 'main') {
                $keys[] = $module_name . '/' . $op;
            }
            $keys[] = $module_name;
        }
        $keys = array_values(array_unique(array_filter($keys, static function ($v) {
            return $v !== '';
        })));
        if (!empty($keys)) {
            $sth = $db->prepare('SELECT id FROM ' . $db_config['prefix'] . '_' . NV_LANG_DATA . '_popups_page WHERE status=1 AND module_name=:m LIMIT 1');
            foreach ($keys as $k) {
                $sth->bindParam(':m', $k, PDO::PARAM_STR);
                $sth->execute();
                $tmp = (int) $sth->fetchColumn();
                if ($tmp > 0) {
                    $pageId = $tmp;
                    break;
                }
            }
        }
    } catch (Throwable $e) {
        $pageId = 0;
        trigger_error(print_r($e, true));
    }
    if ($pageId <= 0 && !empty($home)) {
        $pageId = 1;
    }

    $itemId = 0;
    if (!empty($module_name) && $module_name === 'news') {
        $tmp = 0;
        if (isset($GLOBALS['id'])) {
            $tmp = (int) $GLOBALS['id'];
        }
        if ($tmp <= 0 && isset($nv_Request)) {
            $tmp = (int) $nv_Request->get_int('id', 'get', 0);
        }
        if ($tmp <= 0 && isset($nv_Request)) {
            $tmp = (int) $nv_Request->get_int('newsid', 'get', 0);
        }
        if ($tmp > 0) {
            $itemId = $tmp;
        }
    }

    $adminMeta = defined('NV_IS_ADMIN') ? '<meta name="nv-popups-admin" content="1">' : '';

    if (strpos($contents, 'name="nv-popups"') === false) {
        $meta = '<meta name="nv-popups" content="1"><meta name="nv-popups-pageid" content="' . $pageId . '"><meta name="nv-popups-module" content="' . ($module_name ?? '') . '"><meta name="nv-popups-op" content="' . ($op ?? '') . '">' . $adminMeta;
        if (stripos($contents, '</head>') !== false) {
            $contents = preg_replace('/(<\\/head>)/i', $meta . '\\1', $contents, 1);
        } elseif (preg_match('/<body[^>]*>/i', $contents)) {
            $contents = preg_replace('/(<body[^>]*>)/i', '$1' . $meta, $contents, 1);
        } else {
            $contents = $meta . $contents;
        }
    } elseif (strpos($contents, 'name="nv-popups-pageid"') === false) {
        $meta2 = '<meta name="nv-popups-pageid" content="' . $pageId . '"><meta name="nv-popups-module" content="' . ($module_name ?? '') . '"><meta name="nv-popups-op" content="' . ($op ?? '') . '">' . $adminMeta;
        if (stripos($contents, 'name="nv-popups"') !== false) {
            $contents = preg_replace('/(<meta\\s+name="nv-popups"[^>]*>)/i', '$1' . $meta2, $contents, 1);
        } elseif (stripos($contents, '</head>') !== false) {
            $contents = preg_replace('/(<\\/head>)/i', $meta2 . '\\1', $contents, 1);
        } else {
            $contents = $meta2 . $contents;
        }
    } elseif (!empty($adminMeta) && strpos($contents, 'name="nv-popups-admin"') === false) {
        if (stripos($contents, 'name="nv-popups-pageid"') !== false) {
            $contents = preg_replace('/(<meta\\s+name="nv-popups-pageid"[^>]*>)/i', '$1' . $adminMeta, $contents, 1);
        } elseif (stripos($contents, 'name="nv-popups"') !== false) {
            $contents = preg_replace('/(<meta\\s+name="nv-popups"[^>]*>)/i', '$1' . $adminMeta, $contents, 1);
        } elseif (stripos($contents, '</head>') !== false) {
            $contents = preg_replace('/(<\\/head>)/i', $adminMeta . '\\1', $contents, 1);
        } else {
            $contents = $adminMeta . $contents;
        }
    }
    if (strpos($contents, 'name="nv-popups-module"') === false || strpos($contents, 'name="nv-popups-op"') === false) {
        $metaMO = '<meta name="nv-popups-module" content="' . ($module_name ?? '') . '"><meta name="nv-popups-op" content="' . ($op ?? '') . '">';
        if (stripos($contents, 'name="nv-popups-pageid"') !== false) {
            $contents = preg_replace('/(<meta\\s+name="nv-popups-pageid"[^>]*>)/i', '$1' . $metaMO, $contents, 1);
        } elseif (stripos($contents, 'name="nv-popups"') !== false) {
            $contents = preg_replace('/(<meta\\s+name="nv-popups"[^>]*>)/i', '$1' . $metaMO, $contents, 1);
        } elseif (stripos($contents, '</head>') !== false) {
            $contents = preg_replace('/(<\\/head>)/i', $metaMO . '\\1', $contents, 1);
        } else {
            $contents = $metaMO . $contents;
        }
    }
    if ($itemId > 0 && strpos($contents, 'name="nv-popups-itemid"') === false) {
        $metaItem = '<meta name="nv-popups-itemid" content="' . $itemId . '">';
        if (stripos($contents, 'name="nv-popups-op"') !== false) {
            $contents = preg_replace('/(<meta\\s+name="nv-popups-op"[^>]*>)/i', '$1' . $metaItem, $contents, 1);
        } elseif (stripos($contents, 'name="nv-popups-module"') !== false) {
            $contents = preg_replace('/(<meta\\s+name="nv-popups-module"[^>]*>)/i', '$1' . $metaItem, $contents, 1);
        } elseif (stripos($contents, 'name="nv-popups-pageid"') !== false) {
            $contents = preg_replace('/(<meta\\s+name="nv-popups-pageid"[^>]*>)/i', '$1' . $metaItem, $contents, 1);
        } elseif (stripos($contents, 'name="nv-popups"') !== false) {
            $contents = preg_replace('/(<meta\\s+name="nv-popups"[^>]*>)/i', '$1' . $metaItem, $contents, 1);
        } elseif (stripos($contents, '</head>') !== false) {
            $contents = preg_replace('/(<\\/head>)/i', $metaItem . '\\1', $contents, 1);
        } else {
            $contents = $metaItem . $contents;
        }
    }

    if (!empty($css) && strpos($contents, $css) === false) {
        if (stripos($contents, '</head>') !== false) {
            $contents = preg_replace('/(<\\/head>)/i', '<link rel="stylesheet" type="text/css" href="' . $css . '" data-nv-popups="1">' . '\\1', $contents, 1);
        } elseif (preg_match('/<body[^>]*>/i', $contents)) {
            $contents = preg_replace('/(<body[^>]*>)/i', '$1<link rel="stylesheet" type="text/css" href="' . $css . '" data-nv-popups="1">', $contents, 1);
        } else {
            $contents = '<link rel="stylesheet" type="text/css" href="' . $css . '" data-nv-popups="1">' . $contents;
        }
    }
    if (!empty($js) && strpos($contents, $js) === false) {
        if (stripos($contents, '</body>') !== false) {
            $contents = preg_replace('/(<\\/body>)/i', '<script src="' . $js . '" data-nv-popups="1"></script>' . '\\1', $contents, 1);
        } else {
            $contents .= '<script src="' . $js . '" data-nv-popups="1"></script>';
        }
    }

    $args[1] = [$contents, $headers];
    return $args[1];
}, 'popups', $pid ?? 0);
