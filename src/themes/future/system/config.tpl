<script type="text/javascript" src="{$smarty.const.ASSETS_STATIC_URL}/js/codemirror/css.bundle.js"></script>
<script src="{$smarty.const.ASSETS_STATIC_URL}/js/colpick/colpick.js"></script>
<link rel="stylesheet" href="{$smarty.const.ASSETS_STATIC_URL}/js/colpick/colpick.css">
<form method="post" action="{$smarty.const.NV_BASE_ADMINURL}index.php?{$smarty.const.NV_LANG_VARIABLE}={$smarty.const.NV_LANG_DATA}&amp;{$smarty.const.NV_NAME_VARIABLE}={$MODULE_NAME}&amp;{$smarty.const.NV_OP_VARIABLE}={$OP}" novalidate>
    <div class="card">
        <div class="card-header card-header-tabs">
            <ul class="nav nav-tabs nav-justified" id="tab-region">
                <li class="nav-item">
                    <a class="nav-link text-truncate{$TAB eq 'color' ? ' active' : ''}" data-bs-toggle="tab" id="link-color" data-tab="color" data-bs-target="#tab-color" aria-current="{$TAB eq 'color' ? 'true' : 'false'}" role="tab" aria-controls="tab-color" aria-selected="{$TAB eq 'color' ? 'true' : 'false'}" href="#" data-location="{$smarty.const.NV_BASE_ADMINURL}index.php?{$smarty.const.NV_LANG_VARIABLE}={$smarty.const.NV_LANG_DATA}&amp;{$smarty.const.NV_NAME_VARIABLE}={$MODULE_NAME}&amp;{$smarty.const.NV_OP_VARIABLE}={$OP}&amp;tab=color">{$LANG->getModule('tconf_color_mode')}</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-truncate{$TAB eq 'variables' ? ' active' : ''}" data-bs-toggle="tab" id="link-variables" data-tab="variables" data-bs-target="#tab-variables" aria-current="{$TAB eq 'variables' ? 'true' : 'false'}" role="tab" aria-controls="tab-variables" aria-selected="{$TAB eq 'variables' ? 'true' : 'false'}" href="#" data-location="{$smarty.const.NV_BASE_ADMINURL}index.php?{$smarty.const.NV_LANG_VARIABLE}={$smarty.const.NV_LANG_DATA}&amp;{$smarty.const.NV_NAME_VARIABLE}={$MODULE_NAME}&amp;{$smarty.const.NV_OP_VARIABLE}={$OP}&amp;tab=variables">{$LANG->getModule('tconf_customize_variables')}</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-truncate{$TAB eq 'css' ? ' active' : ''}" data-bs-toggle="tab" id="link-css" data-tab="css" data-bs-target="#tab-css" aria-current="{$TAB eq 'css' ? 'true' : 'false'}" role="tab" aria-controls="tab-css" aria-selected="{$TAB eq 'css' ? 'true' : 'false'}" href="#" data-location="{$smarty.const.NV_BASE_ADMINURL}index.php?{$smarty.const.NV_LANG_VARIABLE}={$smarty.const.NV_LANG_DATA}&amp;{$smarty.const.NV_NAME_VARIABLE}={$MODULE_NAME}&amp;{$smarty.const.NV_OP_VARIABLE}={$OP}&amp;tab=css">{$LANG->getModule('tconf_css')}</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-truncate{$TAB eq 'gfonts' ? ' active' : ''}" data-bs-toggle="tab" id="link-gfonts" data-tab="gfonts" data-bs-target="#tab-gfonts" aria-current="{$TAB eq 'gfonts' ? 'true' : 'false'}" role="tab" aria-controls="tab-gfonts" aria-selected="{$TAB eq 'gfonts' ? 'true' : 'false'}" href="#" data-location="{$smarty.const.NV_BASE_ADMINURL}index.php?{$smarty.const.NV_LANG_VARIABLE}={$smarty.const.NV_LANG_DATA}&amp;{$smarty.const.NV_NAME_VARIABLE}={$MODULE_NAME}&amp;{$smarty.const.NV_OP_VARIABLE}={$OP}&amp;tab=gfonts">{$LANG->getModule('tconf_gfonts')}</a>
                </li>
            </ul>
        </div>
        <div class="card-body">
            <div class="tab-content">
                <div class="tab-pane fade{$TAB eq 'color' ? ' show active' : ''}" id="tab-color" role="tabpanel" aria-labelledby="link-color" tabindex="0">
                    <div class="form-contents">
                        <div class="mb-3">
                            <div class="hstack gap-2">
                                <div>
                                    <input type="radio" class="btn-check" name="color_mode" id="color_mode_light" autocomplete="off" checked>
                                    <label class="btn btn-outline-primary" for="color_mode_light"><i class="fa-solid fa-sun"></i> {$LANG->getModule('tconf_cm_light')}</label>
                                </div>
                                <div>
                                    <input type="radio" class="btn-check" name="color_mode" id="color_mode_dark" autocomplete="off">
                                    <label class="btn btn-outline-dark" for="color_mode_dark"><i class="fa-solid fa-moon"></i> {$LANG->getModule('tconf_cm_dark')}</label>
                                </div>
                                <div>
                                    <input type="radio" class="btn-check" name="color_mode" id="color_mode_auto" autocomplete="off">
                                    <label class="btn btn-outline-success" for="color_mode_auto"><i class="fa-solid fa-wand-magic-sparkles"></i> {$LANG->getModule('tconf_cm_auto')}</label>
                                </div>
                            </div>
                        </div>
                        <div class="fs-5 fw-medium mb-2">{$LANG->getModule('tconf_light_theme')}</div>
                        <div class="row g-3">
                            <div class="col-6 col-sm-4 col-lg-3 col-xl-2 col-xxl-1">
                                <input type="radio" class="btn-check" name="light_theme" id="light_theme_default" autocomplete="off" checked>
                                <label class="btn d-grid btn-outline-primary" for="light_theme_default">
                                    <img src="{$smarty.const.NV_BASE_SITEURL}themes/{$TEMPLATE}/default.jpg" class="img-fluid mb-2 mx-auto" alt="{$TEMPLATE}">
                                    <span>{$LANG->getModule('tconf_default')}</span>
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="tab-pane fade{$TAB eq 'variables' ? ' show active' : ''}" id="tab-variables" role="tabpanel" aria-labelledby="link-variables" tabindex="0">
                    <div class="form-contents vstack gap-3">
                        {foreach from=$VARIABLES key=confcat item=vals}
                        <div class="config-sections">
                            <div class="fw-medium fs-5 mb-1"><i class="fa-solid fa-palette"></i> {$LANG->getModule("tconf_var_`$confcat`")}</div>
                            <div class="row g-2">
                                {foreach from=$vals key=ckey item=cvonf}
                                <div class="col-12 col-sm-6 col-lg-4 col-xl-3 col-xxl-2">
                                    <label class="form-label fw-medium" for="{$confcat}_{$ckey}">{$LANG->getModule("tconf_vari_`$ckey`")}:</label>
                                    {if $cvonf.type eq 'color'}
                                    {* Chọn màu sắc *}
                                    <div class="input-group">
                                        <input type="text" name="{$confcat}_{$ckey}" id="{$confcat}_{$ckey}" value="" class="form-control" data-toggle="colpick">
                                        <div class="input-group-text" id="{$confcat}_{$ckey}_preview">&nbsp; &nbsp;</div>
                                    </div>
                                    {elseif $cvonf.type eq 'text'}
                                    {* Nhập text *}
                                    <input type="text" name="{$confcat}_{$ckey}" id="{$confcat}_{$ckey}" value="" class="form-control" maxlength="250">
                                    {elseif $cvonf.type eq 'number'}
                                    {* Nhập số *}
                                    <input type="number" step=".1" name="{$confcat}_{$ckey}" id="{$confcat}_{$ckey}" value="" class="form-control" maxlength="250">
                                    {elseif $cvonf.type eq 'size'}
                                    {* Nhập kích thước *}
                                    <div class="input-group">
                                        <input type="text" name="{$confcat}_{$ckey}" id="{$confcat}_{$ckey}" value="" class="form-control" data-toggle="colpick">
                                        <select class="form-select fw-75 flex-grow-0 flex-shrink-0" name="unit_{$confcat}_{$ckey}" aria-label="{$LANG->getModule('tconf_unit')} {$LANG->getModule("tconf_vari_`$ckey`")}">
                                            <option value="rem">rem</option>
                                            <option value="px">px</option>
                                        </select>
                                    </div>
                                    {/if}
                                </div>
                                {/foreach}
                            </div>
                        </div>
                        {/foreach}
                    </div>
                </div>
                <div class="tab-pane fade{$TAB eq 'css' ? ' show active' : ''}" id="tab-css" role="tabpanel" aria-labelledby="link-css" tabindex="0">
                    <div class="form-contents">
                        <div data-toggle="tconf-css"></div>
                        <textarea name="css" class="d-none" data-toggle="tconf-css-textarea"></textarea>
                        <div class="text-center mt-3">
                            <button type="submit" class="btn btn-primary">{$LANG->getGlobal('save')}</button>
                        </div>
                    </div>
                </div>
                <div class="tab-pane fade{$TAB eq 'gfonts' ? ' show active' : ''}" id="tab-gfonts" role="tabpanel" aria-labelledby="link-gfonts" tabindex="0">
                    <div class="form-contents">
                        gfonts
                    </div>
                </div>
            </div>
        </div>
    </div>
</form>
