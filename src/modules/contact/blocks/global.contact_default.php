<?php

/**
 * NukeViet Content Management System
 * @version 5.x
 * @author VINADES.,JSC <contact@vinades.vn>
 * @copyright (C) 2009-2025 VINADES.,JSC. All rights reserved
 * @license GNU/GPL version 2 or any later version
 * @see https://github.com/nukeviet The NukeViet CMS GitHub project
 */

if (!defined('NV_MAINFILE')) {
    exit('Stop!!!');
}

if (!nv_function_exists('nv_contact_default_info')) {
    /**
     * @param string $module
     * @param array  $data_block
     * @return string
     */
    function nv_block_config_contact_default($module, $data_block)
    {
        global $site_mods, $nv_Cache, $nv_Lang, $global_config;

        $data_block['shows'] = empty($data_block['shows']) ? [] : (is_string($data_block['shows']) ? explode(',', $data_block['shows']) : $data_block['shows']);

        $block_theme = get_tpl_dir([$global_config['module_theme'], $global_config['site_theme']], NV_DEFAULT_SITE_THEME, '/modules/' . $site_mods[$module]['module_theme'] . '/block.contact_default.config.tpl');
        $tpl = new \NukeViet\Template\NVSmarty();
        $tpl->setTemplateDir(NV_ROOTDIR . '/themes/' . $block_theme . '/modules/' . $site_mods[$module]['module_theme']);
        $tpl->assign('LANG', $nv_Lang);
        $tpl->assign('TEMPLATE', $block_theme);
        $tpl->assign('CONFIG', $data_block);
        $tpl->assign('SHOWS', [
            'phone' => $nv_Lang->getModule('phone'),
            'fax' => $nv_Lang->getModule('fax'),
            'email' => $nv_Lang->getModule('email'),
            'other' => $nv_Lang->getModule('otherContacts'),
        ]);

        $departments = $nv_Cache->db('SELECT * FROM ' . NV_PREFIXLANG . '_' . $site_mods[$module]['module_data'] . '_department ORDER BY weight', 'id', $module);
        $tpl->assign('DEPARTMENTS', $departments);

        return $tpl->fetch('block.contact_default.config.tpl');
    }

    /**
     * @param string $module
     * @return array
     */
    function nv_block_config_contact_default_submit($module)
    {
        global $nv_Request;
        $return = [];
        $return['error'] = [];
        $return['config'] = [];
        $return['config']['departmentid'] = $nv_Request->get_int('config_departmentid', 'post', 0);
        $return['config']['shows'] = $nv_Request->get_typed_array('config_shows', 'post', 'title', []);
        $return['config']['other_limit'] = $nv_Request->get_absint('config_other_limit', 'post', 0);
        $return['config']['show_clock'] = $nv_Request->get_bool('config_show_clock', 'post', false);

        return $return;
    }

    /**
     * @param array $block_config
     * @return string
     */
    function nv_contact_default_info($block_config)
    {
        global $nv_Cache, $site_mods, $global_config, $nv_Lang;

        $module = $block_config['module'];
        if (!isset($site_mods[$module])) {
            return '';
        }
        $block_theme = get_tpl_dir([$global_config['module_theme'], $global_config['site_theme']], 'default', '/modules/' . $site_mods[$module]['module_theme'] . '/block.contact_default.tpl');
        $department = $nv_Cache->db('SELECT * FROM ' . NV_PREFIXLANG . '_' . $site_mods[$module]['module_data'] . '_department WHERE id=' . $block_config['departmentid'] . ' AND act=1', 'id', $module);
        if (empty($department)) {
            return '';
        }
        $department = $department[$block_config['departmentid']];

        $nv_Lang->loadModule($site_mods[$module]['module_file'], loadtmp: true);

        $tpl = new \NukeViet\Template\NVSmarty();
        $tpl->setTemplateDir(NV_ROOTDIR . '/themes/' . $block_theme . '/modules/' . $site_mods[$module]['module_theme']);
        $tpl->registerPlugin('modifier', 'ddatetime', 'nv_datetime_format');
        $tpl->assign('LANG', $nv_Lang);
        $tpl->assign('TEMPLATE', $block_theme);
        $tpl->assign('BCONFIG', $block_config);
        $tpl->assign('DATETIME_FORMAT', nv_region_config('date_short') . ' ' . nv_region_config('time_short'));

        $icons = [];
        if (in_array('phone', $block_config['shows'], true)) {
            $department['phone'] = nv_parse_phone($department['phone']);
            foreach ($department['phone'] as $num) {
                $icons['phone']['title'] = $nv_Lang->getModule('phone');
                $icons['phone']['value'] = $num[0];
                if (count($num) == 2) {
                    $icons['phone']['link'] = 'tel:' . $num[1];
                }
                break;
            }
        }
        if (in_array('fax', $block_config['shows'], true) and !empty($department['fax'])) {
            $department['fax'] = nv_parse_phone($department['fax']);
            foreach ($department['fax'] as $num) {
                $icons['fax']['title'] = $nv_Lang->getModule('fax');
                $icons['fax']['value'] = $num[0];
                if (count($num) == 2) {
                    $icons['fax']['link'] = 'tel:' . $num[1];
                }
                break;
            }
        }
        if (in_array('email', $block_config['shows'], true) and !empty($department['email'])) {
            $emails = array_map('trim', explode(',', $department['email']));
            if (!empty($emails)) {
                $icons['email']['title'] = $nv_Lang->getModule('email');
                $icons['email']['value'] = $emails[0];
                $icons['email']['link'] = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&amp;' . NV_NAME_VARIABLE . '=contact&amp;' . NV_OP_VARIABLE . '=' . $department['alias'];
            }
        }
        if (in_array('other', $block_config['shows'], true) and !empty($department['others'])) {
            $others = json_decode($department['others'], true);
            $num = 0;
            if (!empty($others)) {
                foreach ($others as $key => $value) {
                    if (!empty($value)) {
                        $accepted = false;
                        $key = nv_strtolower($key);

                        if (strtolower($key) == 'skype') {
                            $ss = array_map('trim', explode(',', $value));
                            $icons[$key]['value'] = $ss[0];
                            $icons[$key]['link'] = 'skype:' . $ss[0] . '?call';
                            $accepted = true;
                        } elseif (strtolower($key) == 'viber') {
                            $ss = array_map('trim', explode(',', $value));
                            $icons[$key]['value'] = $ss[0];
                            $icons[$key]['link'] = 'viber://pa?chatURI=' . $ss[0];
                            $accepted = true;
                        } elseif (strtolower($key) == 'whatsapp') {
                            $ss = array_map('trim', explode(',', $value));
                            $icons[$key]['value'] = $ss[0];
                            $icons[$key]['link'] = 'https://wa.me/' . $ss[0];
                            $accepted = true;
                        } elseif (strtolower($key) == 'zalo') {
                            $ss = array_map('trim', explode(',', $value));
                            $icons[$key]['value'] = $ss[0];
                            $icons[$key]['link'] = 'https://zalo.me/' . $ss[0];
                            $accepted = true;
                        } else {
                            $icons[$key] = $value;
                            $accepted = true;
                        }
                        if ($accepted) {
                            $num++;
                            $icons[$key]['title'] = nv_ucfirst($key);
                        }
                        if ($num >= $block_config['other_limit']) {
                            break;
                        }
                    }
                }
            }
        }
        if (empty($icons)) {
            return '';
        }
        $tpl->assign('ICONS', $icons);

        $nv_Lang->changeLang();
        return $tpl->fetch('block.contact_default.tpl');
    }
}

if (defined('NV_SYSTEM')) {
    $content = nv_contact_default_info($block_config);
}
