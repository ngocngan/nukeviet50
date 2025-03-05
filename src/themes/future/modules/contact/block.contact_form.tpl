<form method="post" action="{$smarty.const.NV_BASE_SITEURL}index.php?{$smarty.const.NV_LANG_VARIABLE}={$smarty.const.NV_LANG_DATA}&amp;{$smarty.const.NV_NAME_VARIABLE}={$CONFIG.module}" data-toggle="contactRequestform" data-precheck="contactRequestform_precheck" novalidate
    {if $MODULE_CAPTCHA eq 'recaptcha' and $GCONFIG.recaptcha_ver eq 3} data-recaptcha3="1"
    {elseif $MODULE_CAPTCHA eq 'recaptcha' and $GCONFIG.recaptcha_ver eq 2} data-recaptcha2="1"
    {elseif $MODULE_CAPTCHA eq 'turnstile'} data-turnstile="1"
    {elseif $MODULE_CAPTCHA eq 'captcha'} data-captcha="fcode"{/if}
>
    <div class="card bg-body-tertiary">
        <div class="card-body">
            <div class="fs-5 fw-medium mb-2">{$LANG->getModule('requestform_title')}</div>
            <p>{$LANG->getModule('requestform_help')}</p>
            <input class="form-control form-control-required mb-2" type="text" name="sender_name" placeholder="{$LANG->getModule('fullname')}" aria-label="{$LANG->getModule('fullname')}">
            <input class="form-control form-control-required mb-3" type="email" name="sender_email" placeholder="{$LANG->getModule('email')}" aria-label="{$LANG->getModule('email')}">
            <div class="d-grid">
                <button type="submit" class="btn btn-primary">{$LANG->getModule('sendcontact')}</button>
                <input type="hidden" name="checkss" value="{$smarty.const.NV_CHECK_SESSION}">
            </div>
        </div>
    </div>
</form>
