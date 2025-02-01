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

if (!nv_function_exists('nv_news_category')) {
    /**
     * nv_block_config_news_category()
     *
     * @param string $module
     * @param array  $data_block
     * @return string
     */
    function nv_block_config_news_category($module, $data_block)
    {
        global $nv_Cache, $site_mods, $nv_Lang;

        $html_input = '';
        $html = '<div class="row mb-3">';
        $html .= '<label class="col-sm-3 col-form-label text-sm-end text-truncate fw-medium">' . $nv_Lang->getModule('catid') . ':</label>';
        $html .= '<div class="col-sm-5"><select name="config_catid" class="form-select">';
        $html .= '<option value="0"> -- </option>';
        $sql = 'SELECT * FROM ' . NV_PREFIXLANG . '_' . $site_mods[$module]['module_data'] . '_cat ORDER BY sort ASC';
        $list = $nv_Cache->db($sql, '', $module);
        foreach ($list as $l) {
            if ($l['status'] == 1 or $l['status'] == 2) {
                $xtitle_i = '';

                if ($l['lev'] > 0) {
                    for ($i = 1; $i <= $l['lev']; ++$i) {
                        $xtitle_i .= '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
                    }
                }
                $html_input .= '<input type="hidden" id="config_catid_' . $l['catid'] . '" value="' . NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&amp;' . NV_NAME_VARIABLE . '=' . $module . '&amp;' . NV_OP_VARIABLE . '=' . $l['alias'] . '" />';
                $html .= '<option value="' . $l['catid'] . '" ' . (($data_block['catid'] == $l['catid']) ? ' selected="selected"' : '') . '>' . $xtitle_i . $l['title'] . '</option>';
            }
        }
        $html .= '</select>';
        $html .= $html_input;
        $html .= '<script type="text/javascript">';
        $html .= '    $("select[name=config_catid]").change(function() {';
        $html .= '        $("input[name=title]").val(trim($("select[name=config_catid] option:selected").text()));';
        $html .= '        $("input[name=link]").val($("#config_catid_" + $("select[name=config_catid]").val()).val());';
        $html .= '    });';
        $html .= '</script>';
        $html .= '</div></div>';
        $html .= '<div class="row mb-3">';
        $html .= '<label class="col-sm-3 col-form-label text-sm-end text-truncate fw-medium">' . $nv_Lang->getModule('title_length') . ':</label>';
        $html .= '<div class="col-sm-5">';
        $html .= "<select name=\"config_title_length\" class=\"form-select\">\n";
        $html .= '<option value="">' . $nv_Lang->getModule('title_length') . "</option>\n";
        for ($i = 0; $i < 100; ++$i) {
            $html .= '<option value="' . $i . '" ' . (($data_block['title_length'] == $i) ? ' selected="selected"' : '') . '>' . $i . "</option>\n";
        }
        $html .= "</select>\n";
        $html .= '</div>';
        $html .= '</div>';

        return $html;
    }

    /**
     * nv_block_config_news_category_submit()
     *
     * @param string $module
     * @return array
     */
    function nv_block_config_news_category_submit($module)
    {
        global $nv_Request;
        $return = [];
        $return['error'] = [];
        $return['config'] = [];
        $return['config']['catid'] = $nv_Request->get_int('config_catid', 'post', 0);
        $return['config']['title_length'] = $nv_Request->get_int('config_title_length', 'post', 0);

        return $return;
    }

    /**
     * nv_news_category_getdata()
     *
     * @param array $list
     * @param int   $parentid
     * @param array $block_config
     * @return array
     */
    function nv_news_category_getdata($list, $parentid, $block_config)
    {
        global $module_name, $catid;

        $menus = [];
        foreach ($list as $row) {
            if (in_array((int) $row['status'], [1, 2], true) and $row['parentid'] == $parentid) {
                $row['active'] = (bool) ($module_name == $block_config['module'] and !empty($catid) and $row['catid'] == $catid);
                $row['sub'] = nv_news_category_getdata($list, $row['catid'], $block_config);
                if (!$row['active'] and !empty($row['sub'])) {
                    foreach ($row['sub'] as $subrow) {
                        if ($subrow['active']) {
                            $row['active'] = true;
                            break;
                        }
                    }
                }
                if ($row['active']) {
                    $row['expanded'] = true;
                    $row['collapsed'] = false;
                } else {
                    $row['expanded'] = false;
                    $row['collapsed'] = true;
                }
                $menus[] = $row;
            }
        }

        return $menus;
    }

    /**
     * nv_news_category()
     *
     * @param array $block_config
     * @return string|void
     */
    function nv_news_category($block_config)
    {
        global $module_array_cat, $nv_Lang;

        $menulist = nv_news_category_getdata($module_array_cat, $block_config['catid'], $block_config);
        $block_theme = get_tpl_dir([$block_config['real_theme']], 'default', '/css/jquery.metisMenu.css');

        $stpl = new \NukeViet\Template\NVSmarty();
        $stpl->setTemplateDir($block_config['real_path'] . '/smarty');
        $stpl->assign('LANG', $nv_Lang);
        $stpl->assign('CONFIGS', $block_config);
        $stpl->assign('TEMPLATE', $block_theme);
        $stpl->assign('MENUID', $block_config['bid']);
        $stpl->assign('MENU', $menulist);

        return $stpl->fetch('block_category.tpl');
    }
}

if (defined('NV_SYSTEM')) {
    global $site_mods, $module_name, $global_array_cat, $module_array_cat, $nv_Cache, $catid;
    $module = $block_config['module'];
    if (isset($site_mods[$module])) {
        if ($module == $module_name) {
            $module_array_cat = $global_array_cat;
            unset($module_array_cat[0]);
        } else {
            $module_array_cat = [];
            $sql = 'SELECT catid, parentid, title, alias, viewcat, subcatid, numlinks, description, keywords, groups_view, status FROM ' . NV_PREFIXLANG . '_' . $site_mods[$module]['module_data'] . '_cat ORDER BY sort ASC';
            $list = $nv_Cache->db($sql, 'catid', $module);
            if (!empty($list)) {
                foreach ($list as $l) {
                    $module_array_cat[$l['catid']] = $l;
                    $module_array_cat[$l['catid']]['link'] = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&amp;' . NV_NAME_VARIABLE . '=' . $module . '&amp;' . NV_OP_VARIABLE . '=' . $l['alias'];
                }
            }
        }

        $content = nv_news_category($block_config);
    }
}
