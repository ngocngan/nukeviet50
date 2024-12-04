    <div id="timeoutsess" class="text-bg-warning timeoutsess">
        <div class="p-2 text-center">
            {$LANG->getGlobal('timeoutsess_nouser')}, <a data-toggle="timeoutsesscancel" href="#">{$LANG->getGlobal('timeoutsess_click')}</a>. {$LANG->getGlobal('timeoutsess_timeout')}: <span id="secField"> 60 </span> {$LANG->getGlobal('sec')}
        </div>
    </div>
    <div id="openidResult" class="nv-alert" style="display:none"></div>
    <div id="openidBt" data-result="" data-redirect=""></div>
    {if $smarty.const.SSO_REGISTER_DOMAIN}
    <script type="text/javascript">
    function nvgSSOReciver(event) {
        if (event.origin !== '{$smarty.const.SSO_REGISTER_DOMAIN}') {
            return false;
        }
        if (
            event.data !== null && typeof event.data == 'object' && event.data.code == 'oauthback' &&
            typeof event.data.redirect != 'undefined' && typeof event.data.status != 'undefined' && typeof event.data.mess != 'undefined'
        ) {
            $('#openidResult').data('redirect', event.data.redirect);
            $('#openidResult').data('result', event.data.status);
            $('#openidResult').html(event.data.mess + (event.data.status == 'success' ? ' <span class="load-bar"></span>' : ''));
            $('#openidResult').addClass('nv-info ' + event.data.status);
            $('#openidBt').trigger('click');
        } else if (event.data == 'nv.reload') {
            location.reload();
        }
    }
    window.addEventListener('message', nvgSSOReciver, false);
    </script>
    {/if}
    <script src="{$smarty.const.NV_STATIC_URL}themes/{$GCONFIG.module_theme}/js/bootstrap.bundle.min.js"></script>
</body>
</html>
