<?php

/**
 * NukeViet Content Management System
 * @version 5.x
 * @author VINADES.,JSC <contact@vinades.vn>
 * @copyright (C) 2009-2025 VINADES.,JSC. All rights reserved
 * @license GNU/GPL version 2 or any later version
 * @see https://github.com/nukeviet The NukeViet CMS GitHub project
 */

namespace Tests\Unit;

use Tests\Support\UnitTester;

/**
 * Kiểm tra block có function config hoặc config submit
 * mà trong tệp php không có hàm tương ứng
 */
class CheckBlockConfigTest extends \Codeception\Test\Unit
{

    protected UnitTester $tester;

    protected function _before()
    {
    }

    private function check(string $php_content, array $block_json, string $path): void
    {
        if (preg_match('/require[^\;]+menu_config\.php/i', $php_content)) {
            $additionFile = NV_ROOTDIR . '/modules/menu/menu_config.php';
            $this->assertFileExists($additionFile, 'File not found: ' . str_replace(NV_ROOTDIR . '/', '', $additionFile));

            $php_content .= file_get_contents($additionFile);
        }

        if (!empty($block_json['datafunction'])) {
            $this->assertStringContainsString($block_json['datafunction'], $php_content, 'Block config function not found: ' . $path);
        }
        if (!empty($block_json['submitfunction'])) {
            $this->assertStringContainsString($block_json['submitfunction'], $php_content, 'Block config submit function not found: ' . $path);
        }
    }

    /**
     * Check config các block module
     *
     * @group install
     * @group all
     * @group block
     */
    public function testBlockModuleValid()
    {
        $modules = scandir(NV_ROOTDIR . '/modules');

        foreach ($modules as $module) {
            if ($module == '.' or $module == '..') {
                continue;
            }
            if (!is_dir(NV_ROOTDIR . '/modules/' . $module . '/blocks')) {
                continue;
            }
            $blocks = scandir(NV_ROOTDIR . '/modules/' . $module . '/blocks');
            foreach ($blocks as $block) {
                if (!preg_match('/^(global|module)\.(.*?).php$/', $block)) {
                    continue;
                }
                $block_php = NV_ROOTDIR . '/modules/' . $module . '/blocks/' . $block;
                $block_json = preg_replace('/\.php$/', '.json', $block_php);
                if (!is_file($block_json)) {
                    continue;
                }
                $content_php = file_get_contents($block_php);
                $content_json = file_get_contents($block_json);

                $config = json_decode($content_json, true);
                $this->assertIsArray($config, 'Json file config is not valid: ' . str_replace(NV_ROOTDIR . '/', '', $block_json));
                $this->assertNotEmpty($config, 'Json file config is empty: ' . str_replace(NV_ROOTDIR . '/', '', $block_json));

                $this->check($content_php, $config, str_replace(NV_ROOTDIR . '/', '', $block_php));
            }
        }
    }

    /**
     * Check config các block giao diện
     *
     * @group install
     * @group all
     * @group block
     */
    public function testBlockThemeValid()
    {
        $themes = scandir(NV_ROOTDIR . '/themes');
        foreach ($themes as $theme) {
            if ($theme == '.' or $theme == '..') {
                continue;
            }
            if (!is_dir(NV_ROOTDIR . '/themes/' . $theme . '/blocks')) {
                continue;
            }
            $blocks = scandir(NV_ROOTDIR . '/themes/' . $theme . '/blocks');
            foreach ($blocks as $block) {
                if (!preg_match('/^(global|module)\.(.*?).php$/', $block)) {
                    continue;
                }
                $block_php = NV_ROOTDIR . '/themes/' . $theme . '/blocks/' . $block;
                $block_json = preg_replace('/\.php$/', '.json', $block_php);
                if (!is_file($block_json)) {
                    continue;
                }
                $content_php = file_get_contents($block_php);
                $content_json = file_get_contents($block_json);

                $config = json_decode($content_json, true);
                $this->assertIsArray($config, 'Json file config is not valid: ' . str_replace(NV_ROOTDIR . '/', '', $block_json));
                $this->assertNotEmpty($config, 'Json file config is empty: ' . str_replace(NV_ROOTDIR . '/', '', $block_json));

                $this->check($content_php, $config, str_replace(NV_ROOTDIR . '/', '', $block_php));
            }
        }
    }

    /**
     * Check config các block giao diện
     *
     * @group install
     * @group all
     * @group block
     */
    public function testBlockThemeModuleValid()
    {
        $themes = scandir(NV_ROOTDIR . '/themes');
        foreach ($themes as $theme) {
            if ($theme == '.' or $theme == '..') {
                continue;
            }
            if (!is_dir(NV_ROOTDIR . '/themes/' . $theme . '/modules')) {
                continue;
            }
            $modules = scandir(NV_ROOTDIR . '/themes/' . $theme . '/modules');
            foreach ($modules as $module) {
                if ($module == '.' or $module == '..') {
                    continue;
                }
                if (!is_dir(NV_ROOTDIR . '/themes/' . $theme . '/modules/' . $module)) {
                    continue;
                }
                $blocks = scandir(NV_ROOTDIR . '/themes/' . $theme . '/modules/' . $module);
                foreach ($blocks as $block) {
                    if (!preg_match('/^(global|module)\.(.*?).php$/', $block)) {
                        continue;
                    }
                    $block_php = NV_ROOTDIR . '/themes/' . $theme . '/modules/' . $module . '/' . $block;
                    $block_json = preg_replace('/\.php$/', '.json', $block_php);
                    if (!is_file($block_json)) {
                        continue;
                    }
                    $content_php = file_get_contents($block_php);
                    $content_json = file_get_contents($block_json);

                    $config = json_decode($content_json, true);
                    $this->assertIsArray($config, 'Json file config is not valid: ' . str_replace(NV_ROOTDIR . '/', '', $block_json));
                    $this->assertNotEmpty($config, 'Json file config is empty: ' . str_replace(NV_ROOTDIR . '/', '', $block_json));

                    $this->check($content_php, $config, str_replace(NV_ROOTDIR . '/', '', $block_php));
                }
            }
        }
    }
}
