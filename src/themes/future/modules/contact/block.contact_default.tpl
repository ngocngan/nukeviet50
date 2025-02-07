<div class="h4 mt-3 d-lg-none">{$LANG->getGlobal('contactUs')}</div>
<ul class="d-flex flex-column flex-lg-row align-items-start align-items-lg-center list-unstyled mb-0 contact-icons">
    {if not empty($BCONFIG.show_clock)}
    <li class="digital-clock" data-format="{$DATETIME_FORMAT}" id="site-digital-clock">
        {$smarty.const.NV_CURRENTTIME|ddatetime}
    </li>
    {/if}
    {foreach from=$ICONS key=key item=value}
    <li class="d-flex align-items-center gap-1">
        <i class="icon-{$key} flex-shrink-0" title="{$value.title}" aria-label="{$value.title}"></i>
        {if not empty($value.link)}<a class="text-break" href="{$value.link}" title="{$value.title}">{$value.value}</a>{else}<span class="text-break">{$value.value}</span>{/if}
    </li>
    {/foreach}
</ul>
