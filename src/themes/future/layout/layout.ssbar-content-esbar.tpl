{include file='header_only.tpl'}
{include file='header_extended.tpl'}
<main class="main-content">
    <div class="container py-4">
        [THEME_ERROR_INFO]
        <div class="row">
            <div class="main-start">
                <div class="vstack vstack-blocks">
                    [START_SIDEBAR]
                </div>
            </div>
            <div class="main-content">
                {$MODULE_CONTENT}
            </div>
            <div class="main-end">
                <div class="vstack vstack-blocks">
                    [END_SIDEBAR]
                </div>
            </div>
        </div>
    </div>
</main>
{include file='footer_extended.tpl'}
{include file='footer_only.tpl'}
