{include file='header_only.tpl'}
{include file='header_extended.tpl'}

<!DOCTYPE html>
<html lang="{$LANG->getGlobal('Content_Language')}" xmlns="http://www.w3.org/1999/xhtml" prefix="og: http://ogp.me/ns#">

<head>
    <title>{$THEME_PAGE_TITLE}</title>
    {foreach from=$METATAGS item=meta}
    <meta {$meta.name}="{$meta.value}" content="{$meta.content}">
    {/foreach}
    <link rel="shortcut icon" href="{$SITE_FAVICON}">
    {foreach from=$HTML_LINKS item=links}
    <link{foreach from=$links key=key item=value} {$key}{if not empty($value)}="{$value}"{/if}{/foreach}>
    {/foreach}
    {foreach from=$HTML_JS item=js}
    <script{if $js.ext} src="{$js.content}"{/if}>{if not $js.ext}{$smarty.const.PHP_EOL}{$js.content}{$smarty.const.PHP_EOL}{/if}</script>
    {/foreach}
</head>

<body>
    <h1>Hello, world!</h1>

    {if $CLIENT_INFO.browser.key eq 'explorer'}
    --------------
    {/if}


    <script src="{$smarty.const.NV_STATIC_URL}themes/{$GCONFIG.module_theme}/js/bootstrap.bundle.min.js"></script>
</body>

</html>

{include file='footer_extended.tpl'}
{include file='footer_only.tpl'}
