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

global $module_name, $site_mods, $global_config, $nv_Lang;

$content = '';
if ($module_name != $block_config['module'] and defined('NV_SYSTEM')) {

    addition_module_assets($block_config['module'], 'both');
    return '';

    $fname_default = $site_mods[$block_config['module']]['module_file'];

    $block_theme = get_tpl_dir([$global_config['module_theme'], $global_config['site_theme']], NV_DEFAULT_SITE_THEME, '/modules/' . $site_mods[$block_config['module']]['module_theme'] . '/block.contact_form.tpl');

    $blockJsTheme = get_tpl_dir([$global_config['module_theme'], $global_config['site_theme']], '', '/js/' . $fname_theme . '.js');
    $blockJsDefault = get_tpl_dir([$global_config['module_theme'], $global_config['site_theme']], NV_DEFAULT_SITE_THEME, '/js/' . $fname_default . '.js');

    $blockCssTheme = get_tpl_dir([$global_config['module_theme'], $global_config['site_theme']], '', '/js/' . $fname_theme . '.css');
    $blockCssDefault = get_tpl_dir([$global_config['module_theme'], $global_config['site_theme']], NV_DEFAULT_SITE_THEME, '/css/' . $fname_default . '.css');

    /**
     * Load block css.
     * Xử lý độc lập cho module_theme và module_file
     *
     * name.rtl.css module_theme
     * name.css module_theme
     * name.rtl.css site_theme
     * name.css site_theme
     * name.rtl.css default
     * name.css default
     */

    $blockJs = theme_file_exists($block_theme . '/js/contact.js') ? $block_theme : 'default';
    $blockCss = theme_file_exists($block_theme . '/css/contact.css') ? $block_theme : 'default';

    $xtpl = new XTemplate('block.contact_form.tpl', NV_ROOTDIR . '/themes/' . $block_theme . '/modules/contact');
    $xtpl->assign('GLANG', \NukeViet\Core\Language::$lang_global);
    $xtpl->assign('JS', NV_STATIC_URL . 'themes/' . $blockJs . '/js/contact.js');
    $xtpl->assign('CSS', NV_STATIC_URL . 'themes/' . $blockJs . '/css/contact.css');
    $xtpl->assign('TEMPLATE', $block_theme);
    $xtpl->assign('MODULE', $block_config['module']);

    $xtpl->parse('main');
    $content = $xtpl->text('main');
}
