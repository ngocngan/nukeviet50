{if $ERROR}
<div class="alert alert-danger">{$ERROR}</div>
{/if}
<form action="" method="post" class="ajax-submit">
    <div class="card border-primary border-3 border-bottom-0 border-start-0 border-end-0">
        <div class="card-body pt-4">
            <div class="row mb-3">
                <label for="lb_display_layout" class="col-sm-3 col-form-label text-sm-end">{$LANG->getModule('display_layout')}</label>
                <div class="col-sm-8 col-lg-6 col-xxl-5">
                    <select class="form-control" name="display_layout" id="lb_display_layout">
                        {foreach from=$DISPLAY_LAYOUT key=key item=row}
                        <option value="{$key}" {if $key == $DATA.display_layout} selected="selected"{/if}>{$row}</option>
                        {/foreach}
                    </select>
                </div>
            </div>
            <div class="row mb-3">
                <label for="lb_popup_delay" class="col-sm-3 col-form-label text-sm-end">{$LANG->getModule('popup_delay')}</label>
                <div class="col-sm-8 col-lg-6 col-xxl-5">
                    <input type="number" value="{$DATA.popup_delay|escape:'html'}" class="form-control" id="lb_popup_delay" name="popup_delay">
                </div>
            </div>
            <div class="row mb-3">
                <label for="lb_display_frequency" class="col-sm-3 col-form-label text-sm-end">{$LANG->getModule('display_frequency')}</label>
                <div class="col-sm-8 col-lg-6 col-xxl-5">
                    <div class="input-group">
                        <input type="number" value="{$DATA.display_frequency|escape:'html'}" class="form-control" id="lb_display_frequency" name="display_frequency">
                    </div>
                    <div class="form-text">{$LANG->getModule('display_frequency_note')}</div>
                </div>
            </div>
            <div class="row mb-3">
                <label for="lb_display_object" class="col-sm-3 col-form-label text-sm-end">{$LANG->getModule('display_object')}</label>
                <div class="col-sm-8 col-lg-6 col-xxl-5">
                    <select name="display_object" id="lb_display_object" class="form-control">
                        {foreach from=$DISPLAY_OBJECT key=key item=row}
                        <option value="{$key}" {if $key == $DATA.display_object} selected="selected"{/if}>{$row}</option>
                        {/foreach}
                    </select>
                </div>
            </div>
            <div class="row mb-3">
                <label for="lb_display_device" class="col-sm-3 col-form-label text-sm-end">{$LANG->getModule('display_device')}</label>
                <div class="col-sm-8 col-lg-6 col-xxl-5">
                    <select name="display_device" class="form-control" id="lb_display_device">
                        {foreach from=$DISPLAY_DEVICE key=key item=row}
                            <option value="{$key}" {if $key  == $DATA.display_device} selected="selected"{/if}>{$row}</option>
                        {/foreach}
                    </select>
                </div>
            </div>
            <div class="row mb-3">
                <label for="close_on_outside_click" class="col-sm-3 col-form-label text-sm-end">{$LANG->getModule('close_on_outside_click')}</label>
                <div class="col-sm-8 col-lg-6 col-xxl-5">
                    <div class="form-check form-switch">
                        <input class="form-check-input" type="checkbox" role="switch" value="1" id="close_on_outside_click" name="close_on_outside_click" {$DATA.checked}>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-8 col-lg-6 col-xxl-5 offset-lg-3 offset-sm-5">
                    <input type="hidden" name="checkss" value="{$CHECKSS}">
                    <input type="hidden" name="submit" value="1">
                    <button type="submit" class="btn btn-primary">{$LANG->getModule('save')}</button>
                </div>
            </div>
        </div>
    </div>
</form>
