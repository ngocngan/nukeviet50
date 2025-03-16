<form method="get" action="{$smarty.const.NV_BASE_SITEURL}index.php?{$smarty.const.NV_LANG_VARIABLE}={$smarty.const.NV_LANG_DATA}&amp;{$smarty.const.NV_NAME_VARIABLE}={$MODULE}" data-toggle="ajax-form" data-precheck="nv_precheck_form" novalidate>
    <div class="fw-medium mb-2">
        {$VOTING.question}
    </div>
    {foreach from=$ITEMS item=item}
    {if $VOTING.accept gt 1}
    <div class="form-check">
        <input class="form-check-input" data-valid data-min="1" data-max="{$VOTING.accept ?: 1}" data-error-mess="{$VOTING.errsm}" data-error-type="feedback" type="checkbox" name="option[]" value="{$item.id}" id="b{$CONFIG.bid}votingI{$item.id}">
        <label class="form-check-label" for="b{$CONFIG.bid}votingI{$item.id}">{$item.title}</label>
    </div>
    {else}
    <div class="form-check">
        <input class="form-check-input" data-valid data-error-mess="{$VOTING.errsm}" data-error-type="feedback" type="radio" name="option" value="{$item.id}" id="b{$CONFIG.bid}votingI{$item.id}">
        <label class="form-check-label" for="b{$CONFIG.bid}votingI{$item.id}">{$item.title}</label>
    </div>
    {/if}
    {/foreach}
    <div class="mt-2">
        <button type="submit" class="btn btn-success">{$LANG->getModule('voting_hits')}</button>
        <button type="button" class="btn btn-primary">{$LANG->getModule('voting_result')}</button>
    </div>
    <input type="hidden" name="vid" value="{$VOTING.vid}">
    <input type="hidden" name="checkss" value="{$VOTING.checkss}">
</form>

{*
<!-- BEGIN: main -->
<script src="{NV_STATIC_URL}themes/{TEMPLATE}/js/voting.js"></script>

<form action="{NV_BASE_SITEURL}" method="get" data-id="{VOTING.vid}" data-accept="{VOTING.accept}" data-errmsg="{VOTING.errsm}" data-checkss="{VOTING.checkss}" data-toggle="votingSend"<!-- BEGIN: has_captcha --><!-- BEGIN: basic --> data-captcha="captcha"<!-- END: basic --><!-- BEGIN: recaptcha --> data-recaptcha2="1"<!-- END: recaptcha --><!-- END: has_captcha --><!-- BEGIN: recaptcha3 --> data-recaptcha3="1"<!-- END: recaptcha3 --><!-- BEGIN: turnstile --> data-turnstile="1"<!-- END: turnstile -->>
    <div class="h4 margin-bottom"><strong>{VOTING.question}</strong></div>
    <div>
        <!-- BEGIN: resultn -->
        <div class="checkbox">
            <label><input type="checkbox" name="option[]" value="{RESULT.id}" data-toggle="votingAcceptNumber"> {RESULT.title}</label>
        </div>
        <!-- END: resultn -->
        <!-- BEGIN: result1 -->
        <div class="radio">
            <label><input type="radio" name="option" value="{RESULT.id}"> {RESULT.title}</label>
        </div>
        <!-- END: result1 -->
        <div class="clearfix">
            <input class="btn btn-success btn-sm" type="submit" value="{VOTING.langsubmit}"/>
            <input class="btn btn-primary btn-sm" type="button" value="{VOTING.langresult}" data-toggle="votingResult"/>
        </div>
    </div>
</form>
<!-- END: main -->
*}
