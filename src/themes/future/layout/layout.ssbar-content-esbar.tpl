{include file='header_only.tpl'}
{include file='header_extended.tpl'}

<div class="container-lg py-4">
    [THEME_ERROR_INFO]
    <div class="row">
        <div class="col-lg-3">
            <div class="vstack vstack-blocks">
                [START_SIDEBAR]
            </div>
        </div>
        <div class="col-lg-7">
            {$MODULE_CONTENT}
        </div>
        <div class="col-lg-2">
            <div class="vstack vstack-blocks">
                [END_SIDEBAR]
            </div>
        </div>
    </div>
</div>

{include file='footer_extended.tpl'}
{include file='footer_only.tpl'}
