<script type="text/javascript" src="{$smarty.const.ASSETS_STATIC_URL}/js/codemirror/css.bundle.js"></script>
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
                        color
                    </div>
                </div>
                <div class="tab-pane fade{$TAB eq 'variables' ? ' show active' : ''}" id="tab-variables" role="tabpanel" aria-labelledby="link-variables" tabindex="0">
                    <div class="form-contents">
                        variables
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
