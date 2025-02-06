<noscript>
    <div class="alert alert-danger" role="alert">{$LANG->getGlobal('nojs')}</div>
</noscript>
<header>
    <div class="site-header" data-toggle="site-header">
        <div class="site-header-contents">
            <div class="topbar border-bottom">
                <div class="container">
                    <div class="d-flex flex-column flex-lg-row align-items-center justify-content-between gap-2">
                        <div class="start-topbar">
                            [START_TOPBAR]
                        </div>
                        <div class="d-flex align-items-center">
                            <div class="end-topbar border-end pe-2">
                                [END_TOPBAR]
                            </div>
                            {if isset($SITE_MODS.seek)}
                            <div class="topbar-search border-end dropdown px-2">
                                <a class="search-icon d-flex align-items-center" href="#" role="button" data-bs-toggle="dropdown" data-bs-auto-close="outside" data-bs-offset="50,0" aria-expanded="false" aria-label="{$LANG->getGlobal('search_all')}">
                                    <span><i class="fa-solid fa-magnifying-glass"></i></span>
                                </a>
                                <div class="dropdown-menu dropdown-menu-end p-3">
                                    <form method="get" action="{$smarty.const.NV_BASE_SITEURL}index.php{if $GCONFIG.rewrite_enable}?{$smarty.const.NV_LANG_VARIABLE}={$smarty.const.NV_LANG_DATA}&amp;{$smarty.const.NV_NAME_VARIABLE}=seek{/if}" data-toggle="valid-dform" novalidate>
                                        {if not $GCONFIG.rewrite_enable}
                                        <input type="hidden" name="{$smarty.const.NV_LANG_VARIABLE}" value="{$smarty.const.NV_LANG_DATA}">
                                        <input type="hidden" name="{$smarty.const.NV_NAME_VARIABLE}" value="seek">
                                        {/if}
                                        <label for="site-search-ipt" class="fw-medium form-label">{$LANG->getGlobal('search_all')}:</label>
                                        <div class="input-group has-validation flex-nowrap">
                                            <input type="text" class="form-control fw-175" name="q" placeholder="{$LANG->getGlobal('keyword')}" id="site-search-ipt"
                                                minlength="{$smarty.const.NV_MIN_SEARCH_LENGTH}"
                                                maxlength="{$smarty.const.NV_MAX_SEARCH_LENGTH}"
                                                required data-error-mess="{$LANG->getGlobal('search_keyword_rule', $smarty.const.NV_MIN_SEARCH_LENGTH, $smarty.const.NV_MAX_SEARCH_LENGTH)}"
                                            >
                                            <div class="invalid-tooltip"></div>
                                            <button class="btn btn-secondary text-nowrap" type="submit" id="site-search-btn"><i class="fa-solid fa-magnifying-glass-arrow-right"></i> {$LANG->getGlobal('search')}</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                            {/if}
                            <div class="ps-2">
                                <button type="button" class="btn btn-primary btn-sm text-nowrap">Đăng nhập</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            {if isset($SITE_MODS.seek)}
            <div class="mobile-search mb-2">
                <div class="container">
                    <form method="get" action="{$smarty.const.NV_BASE_SITEURL}index.php{if $GCONFIG.rewrite_enable}?{$smarty.const.NV_LANG_VARIABLE}={$smarty.const.NV_LANG_DATA}&amp;{$smarty.const.NV_NAME_VARIABLE}=seek{/if}" data-toggle="valid-dform" novalidate>
                        {if not $GCONFIG.rewrite_enable}
                        <input type="hidden" name="{$smarty.const.NV_LANG_VARIABLE}" value="{$smarty.const.NV_LANG_DATA}">
                        <input type="hidden" name="{$smarty.const.NV_NAME_VARIABLE}" value="seek">
                        {/if}
                        <div class="position-relative">
                            <input type="text" class="form-control fw-175" name="q" placeholder="{$LANG->getGlobal('keyword')}" id="site-search-ipt"
                                minlength="{$smarty.const.NV_MIN_SEARCH_LENGTH}"
                                maxlength="{$smarty.const.NV_MAX_SEARCH_LENGTH}"
                                required data-error-mess="{$LANG->getGlobal('search_keyword_rule', $smarty.const.NV_MIN_SEARCH_LENGTH, $smarty.const.NV_MAX_SEARCH_LENGTH)}"
                            >
                            <div class="invalid-tooltip"></div>
                            <button class="btn btn-secondary text-nowrap" type="submit" id="site-search-btn"><i class="fa-solid fa-magnifying-glass-arrow-right"></i> {$LANG->getGlobal('search')}</button>
                        </div>
                    </form>
                </div>
            </div>
            {/if}
            <div class="logo-banner">
                <div class="container">
                    <div class="d-flex align-items-center justify-content-between gap-4 my-3">
                        <div class="logo flex-shrink-1 flex-lg-shrink-0 flex-grow-1 flex-lg-grow-0 text-center text-lg-start">
                            <a title="{$GCONFIG.site_name}" href="{$smarty.const.NV_BASE_SITEURL}index.php?{$smarty.const.NV_LANG_VARIABLE}={$smarty.const.NV_LANG_DATA}" aria-label="Logo {$GCONFIG.site_name}">
                                <img src="{$smarty.const.NV_BASE_SITEURL}{$GCONFIG.site_logo}" alt="{$GCONFIG.site_name}">
                            </a>
                            <h1 aria-hidden="true" class="visually-hidden">{$GCONFIG.site_name}</h1>
                            <h2 aria-hidden="true" class="visually-hidden">{$GCONFIG.site_description}</h2>
                        </div>
                        <div class="banner flex-shrink-1 d-none d-lg-block">
                            [HEADER_BANNER]
                        </div>
                    </div>
                </div>
            </div>
            <nav class="site-nav">
                <div class="container">
                    [MAIN_NAV]
                </div>
            </nav>
        </div>
    </div>
    <div class="site-header-mobile">
        <div class="container">
            <div class="d-flex align-items-center justify-content-between gap-3 py-3">
                <div class="logo flex-shrink-0">
                    <a title="{$GCONFIG.site_name}" href="{$smarty.const.NV_BASE_SITEURL}index.php?{$smarty.const.NV_LANG_VARIABLE}={$smarty.const.NV_LANG_DATA}" aria-label="Logo {$GCONFIG.site_name}">
                        <img src="{$smarty.const.NV_BASE_SITEURL}{$GCONFIG.site_logo}" alt="{$GCONFIG.site_name}">
                    </a>
                </div>
                <a href="#" role="button" class="p-2 toggle-main-nav" data-toggle="toggle-main-nav" aria-label="Toggle main navigation">
                    <i class="fa-solid fa-bars fa-2x"></i>
                </a>
            </div>
        </div>
    </div>
</header>
