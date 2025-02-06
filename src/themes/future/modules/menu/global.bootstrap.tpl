{function writeTrees parentid=0 treestt=0}
{if $parentid < 5}
{for $stt=1 to 10}
<li data-toggle="item-lev-{$parentid + 1}"{if $stt == 4} class="active"{/if}>
    <div class="menu-item{if ($stt == 1 or $stt == 10) and $parentid < 4} has-submenu{/if}">
        <a class="item-link" href="#">
            <span class="item-icon d-none"><i class="fa-solid fa-house"></i></span>
            <span class="item-name">Menu level {$parentid + 1}.{$stt}</span>
        </a>
        {if ($stt == 1 or $stt == 10) and $parentid < 4}
        <span class="item-arrow" data-toggle="subtg" aria-label="Toggle submenu">
            <i class="fa-solid fa-caret-down"></i>
        </span>
        {/if}
    </div>
    {if ($stt == 1 or $stt == 10) and $parentid < 4}
    <ul data-toggle="submenu">
        {writeTrees parentid=$parentid + 1 treestt=$stt}
    </ul>
    {/if}
</li>
{/for}
{/if}
{/function}
<div class="main-nav" data-toggle="main-nav">
    <ul>
        <li class="main-nav-home" data-toggle="item-lev-1">
            <div class="menu-item">
                <a class="item-link" href="#" aria-label="Home">
                    <span class="item-icon">
                        <i class="fa-solid fa-house"></i>
                    </span>
                    <span class="item-name">{$LANG->getGlobal('Home')}</span>
                </a>
            </div>
        </li>
        {writeTrees}
        <li class="nav-expanded" data-toggle="item-expanded">
            <div class="menu-item">
                <a class="item-link" href="#" aria-label="Expanded">
                    <span class="item-icon">
                        <i class="fa-solid fa-bars"></i>
                    </span>
                </a>
            </div>
        </li>
    </ul>
    <div class="nav-loader">
        <div class="loader-mask h-100"></div>
        <div class="loader-icon h-100 px-2 d-flex justify-content-center align-items-center">
            <div class="spinner-grow spinner-grow-sm" role="status">
                <span class="visually-hidden">{$LANG->getGlobal('wait_page_load')}</span>
            </div>
        </div>
    </div>
</div>
