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

global $module_name, $nv_Lang;

$content = '';
if ($module_name != $block_config['module'] and defined('NV_SYSTEM')) {
    addition_module_assets($block_config['module'], 'both');
    [$block_theme, $dir] = get_block_tpl_dir('block.contact_form.tpl', $block_config['module'], true);

    $tpl = new \NukeViet\Template\NVSmarty();
    $tpl->setTemplateDir($dir);
    $tpl->assign('LANG', $nv_Lang);
    $tpl->assign('TEMPLATE', $block_theme);
    $tpl->assign('CONFIG', $block_config);

    $content = $tpl->fetch('block.contact_form.tpl');
}
