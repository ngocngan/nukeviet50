<div class="site-user-button dropdown">
    {if $smarty.const.NV_IS_USER}
    {* Đã đăng nhập *}
    <a class="user-button" title="{$USER.full_name}" href="#" data-bs-toggle="dropdown" data-bs-auto-close="outside" data-bs-offset="8,0" aria-expanded="false">
        {if empty($USER.avata)}
        <span class="no-avatar d-flex align-items-center justify-content-center text-bg-primary rounded-circle w-100 h-100"><span>{$USER.chars}</span></span>
        {else}
        <img src="{$USER.avata}" alt="{$USER.full_name}">
        {/if}
    </a>
    <ul class="dropdown-menu dropdown-menu-end">
        <li><a class="dropdown-item" href="#">Action</a></li>
        <li><a class="dropdown-item" href="#">Another action</a></li>
        <li><a class="dropdown-item" href="#">Something else here</a></li>
    </ul>
    {elseif $smarty.const.NV_IS_USER_FORUM and $smarty.const.SSO_SERVER}
    {* Nút đăng nhập SSO *}
    <a href="{$LINK_LOGIN}" class="btn btn-primary btn-sm text-nowrap">{$LANG->getGlobal('signin')}</a>
    {else}
    {* Nút đăng nhập thành viên *}
    <button type="button" class="btn btn-primary btn-sm text-nowrap" title="{$LANG->getGlobal('signin')} - {$LANG->getGlobal('register')}" data-bs-toggle="dropdown" data-bs-auto-close="outside" data-bs-offset="8,0" aria-expanded="false">{$LANG->getGlobal('signin')}</a>
    <ul class="dropdown-menu dropdown-menu-end">
        <li><a class="dropdown-item" href="#">Action</a></li>
        <li><a class="dropdown-item" href="#">Another action</a></li>
        <li><a class="dropdown-item" href="#">Something else here</a></li>
    </ul>
    {/if}
</div>
