{include file='header_only.tpl'}
{include file='header_extended.tpl'}
<div class="main-content">
    <div class="container py-4">
        [THEME_ERROR_INFO]
        <div class="row">
            <aside class="main-start">
                <div class="vstack vstack-blocks">
                    [START_SIDEBAR]
                </div>
            </aside>
            <main class="main-content">
                {$MODULE_CONTENT}
            </main>
            <aside class="main-end">
                <div class="vstack vstack-blocks">
                    [END_SIDEBAR]
                </div>
            </aside>
        </div>
    </div>
</div>
{include file='footer_extended.tpl'}
{include file='footer_only.tpl'}
