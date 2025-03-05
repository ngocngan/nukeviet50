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

global $module_name, $nv_Lang, $site_mods, $module_config, $global_config;

$content = '';
if ($module_name != $block_config['module'] and defined('NV_SYSTEM') and isset($site_mods[$block_config['module']])) {
    addition_module_assets($block_config['module'], 'both');
    [$block_theme, $dir] = get_block_tpl_dir('block.contact_form.tpl', $block_config['module'], true);

    $nv_Lang->loadModule($site_mods[$block_config['module']]['module_file'], false, true);

    $tpl = new \NukeViet\Template\NVSmarty();
    $tpl->setTemplateDir($dir);
    $tpl->assign('LANG', $nv_Lang);
    $tpl->assign('TEMPLATE', $block_theme);
    $tpl->assign('CONFIG', $block_config);

    $module_captcha = (!empty($module_config[$block_config['module']]['captcha_type']) ? $module_config[$block_config['module']]['captcha_type'] : '');
    if (!(empty($module_captcha) or in_array($module_captcha, ['captcha', 'recaptcha', 'turnstile'], true)) or ($module_captcha == 'recaptcha' and (empty($global_config['recaptcha_sitekey']) or empty($global_config['recaptcha_secretkey']))) or ($module_captcha == 'turnstile' and (empty($global_config['turnstile_sitekey']) or empty($global_config['turnstile_secretkey'])))) {
        $module_captcha = 'captcha';
    }
    $tpl->assign('MODULE_CAPTCHA', $module_captcha);
    $tpl->assign('GCONFIG', $global_config);

    $content = $tpl->fetch('block.contact_form.tpl');
    $nv_Lang->changeLang();
}
