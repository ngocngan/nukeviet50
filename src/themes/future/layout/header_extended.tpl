<noscript>
    <div class="alert alert-danger" role="alert">{$LANG->getGlobal('nojs')}</div>
</noscript>
<header>
    <div class="topbar border-bottom">
        <div class="container">
            <div class="d-flex align-items-center justify-content-between gap-2">
                <div class="start-topbar">
                    [START_TOPBAR]
                </div>
                <div class="d-flex">
                    <div class="end-topbar">
                        [END_TOPBAR]
                    </div>
                    <div class="topbar-search dropdown">
                        <a href="#" role="button" class="" data-bs-toggle="dropdown" aria-expanded="false" aria-label="Search">
                            <i class="fa-solid fa-magnifying-glass"></i>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li><a class="dropdown-item" href="#">Action</a></li>
                        </ul>
                    </div>
                    <div>
                        [USER_BUTTON]
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="logo-banner">
        <div class="container">
            <div class="d-flex align-items-center justify-content-between gap-4 my-3">
                <div class="logo">
                    <a title="{$GCONFIG.site_name}" href="{$smarty.const.NV_BASE_SITEURL}index.php?{$smarty.const.NV_LANG_VARIABLE}={$smarty.const.NV_LANG_DATA}">
                        <img src="{$smarty.const.NV_BASE_SITEURL}{$GCONFIG.site_logo}" alt="{$GCONFIG.site_name}">
                    </a>
                    <h1 aria-hidden="true">{$GCONFIG.site_name}</h1>
                    <h2 aria-hidden="true" class="visually-hidden">{$GCONFIG.site_description}</h2>
                </div>
                <div class="banner">
                    [HEADER_BANNER]
                </div>
            </div>
        </div>
    </div>
    <nav class="main-nav">
        <div class="container">
            main-nav
        </div>
    </nav>
</header>
