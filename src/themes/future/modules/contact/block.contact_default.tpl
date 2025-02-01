<ul class="d-flex align-items-center list-unstyled mb-0 contact-icons">
    {if not empty($BCONFIG.show_clock)}
    <li class="digital-clock" data-format="{$DATETIME_FORMAT}" id="site-digital-clock">
        {$smarty.const.NV_CURRENTTIME|ddatetime}
    </li>
    {/if}
    {foreach from=$ICONS key=key item=value}
    <li>
        <i class="icon-{$key}" title="{$value.title}" aria-label="{$value.title}"></i> {if not empty($value.link)}<a href="{$value.link}" title="{$value.title}">{$value.value}</a>{else}{$value.value}{/if}
    </li>
    {/foreach}
</ul>
