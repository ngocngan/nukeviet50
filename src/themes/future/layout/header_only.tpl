<!DOCTYPE html>
<html lang="{$LANG->getGlobal('Content_Language')}" xmlns="http://www.w3.org/1999/xhtml" prefix="og: http://ogp.me/ns#" data-theme="auto" data-bs-theme="auto" dir="ltr">

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

<body class="mname-{$MODULE_NAME} op-{$OP}{if $HOME} site-home{/if}">
