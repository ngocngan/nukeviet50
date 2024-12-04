{if $OUTDATED_BROWSER}
<div class="offcanvas offcanvas-top show text-bg-warning" tabindex="-1" aria-label="{$LANG->getGlobal('chromeframe_title')}" data-bs-backdrop="static">
    <div class="offcanvas-body">
        {$LANG->getGlobal('chromeframe')}
    </div>
</div>
{/if}
{if $COOKIE_NOTICE}
<div class="cookie-notice">
    <button type="button" class="btn-close" aria-label="{$LANG->getGlobal('close')}" data-toggle="cookie_notice_hide"></button>
    {$LANG->getGlobal('cookie_notice', "{$smarty.const.NV_BASE_SITEURL}index.php?{$smarty.const.NV_LANG_VARIABLE}={$smarty.const.NV_LANG_DATA}&amp;{$smarty.const.NV_NAME_VARIABLE}=siteterms&amp;{$smarty.const.NV_OP_VARIABLE}=privacy{$GCONFIG.rewrite_exturl}")}
</div>
{/if}
