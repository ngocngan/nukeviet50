<script src="{$smarty.const.ASSETS_STATIC_URL}/js/flatpickr/flatpickr.min.js"></script>
<script src="{$smarty.const.ASSETS_STATIC_URL}/js/language/flatpickr-{$smarty.const.NV_LANG_INTERFACE}.js"></script>

{if $ERROR}
<div class="alert alert-danger">{$ERROR}</div>
{/if}
<form id="form_add_new_popup" method="post" class="ajax-submit" action="{$FORM_ACTION}" novalidate>
    <div class="row g-3">
        <div class="col-lg-8 col-xxl-9">
            <div class="card mb-3">
                <div class="card-body">
                    <div class="mb-3">
                        <label for="idtitle" class="form-label">{$LANG->getModule('title')} <span class="text-danger">(*)</span>:</label>
                        <div class="position-relative">
                            <input type="text" class="form-control required" id="idtitle" name="title" value="{$DATA.title}" maxlength="255">
                            <div class="invalid-tooltip"></div>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="iddescription" class="form-label">{$LANG->getModule('description')}:</label>
                        <div class="position-relative">
                            <input type="text" class="form-control" id="iddescription" name="description" value="{$DATA.description}" maxlength="255">
                        </div>
                    </div>
                    <div class="row g-3">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="start_time" class="form-label d-block">{$LANG->getModule('start_time')}:</label>
                                <div class="d-flex align-items-center">                                    
                                    <div class="input-group me-2">
                                        <input name="start_time" id="start_time" value="{$DATA.start_time}" class="form-control" type="text" readonly />
                                        <div class="input-group-append">
                                            <button class="btn btn-secondary start-date-btn" type="button" id="start-date-btn">
                                                <i class="fa fa-calendar"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="me-1">
                                        <select class="form-select w70" name="start_date_h" id="start_date_h">
                                            {for $value=0 to 23}
                                            <option value="{$value}"{if $value == $DATA.start_hour} selected="selected" {/if}>{if $value < 10}0{$value}{else}{$value}{/if}</option>
                                            {/for}
                                        </select>
                                    </div>
                                    <div class="me-1 mx-1 text-bold">:</div>
                                    <div class="me-2 mx-1">
                                        <select class="form-select w70" name="start_date_m" id="start_date_m">
                                            {for $value=0 to 59}
                                            <option value="{$value}"{if $value == $DATA.start_minute} selected="selected" {/if}>{if $value < 10}0{$value}{else}{$value}{/if}</option>
                                            {/for}
                                        </select>
                                    </div>
                                    <small class="text-muted text-nowrap">{$LANG->getModule('hour_minute')}</small>
                                </div>
                                <div class="form-text mt-1 text-muted small">{$LANG->getModule('note_start_time')}</div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="end_time" class="form-label d-block">{$LANG->getModule('end_time')}:</label>
                                <div class="d-flex align-items-center">                                    
                                    <div class="input-group me-2">
                                        <input name="end_time" id="end_time" value="{$DATA.end_time}" class="form-control" type="text" readonly />
                                        <div class="input-group-append">
                                            <button class="btn btn-secondary end-date-btn" type="button" id="end-date-btn">
                                                <i class="fa fa-calendar"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="me-1">
                                        <select class="form-select w70" name="end_date_h" id="end_date_h">
                                            {for $value=0 to 23}
                                            <option value="{$value}"{if $value == $DATA.end_hour} selected="selected" {/if}>{if $value < 10}0{$value}{else}{$value}{/if}</option>
                                            {/for}
                                        </select>
                                    </div>
                                    <div class="me-1 mx-1 text-bold">:</div>
                                    <div class="me-2 mx-1">
                                        <select class="form-select w70" name="end_date_m" id="end_date_m">
                                            {for $value=0 to 59}
                                            <option value="{$value}"{if $value == $DATA.end_minute} selected="selected" {/if}>{if $value < 10}0{$value}{else}{$value}{/if}</option>
                                            {/for}
                                        </select>
                                    </div>
                                    <small class="text-muted text-nowrap">{$LANG->getModule('hour_minute')}</small>
                                </div>
                                <div class="form-text mt-1 text-muted small">{$LANG->getModule('note_end_time')}</div>
                            </div>
                        </div>
                    </div>
                    <div class="row g-3">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="idurl_click" class="form-label">{$LANG->getModule('url_click')}:</label>
                                <div class="position-relative">
                                    <input type="text" class="form-control" id="idurl_click" name="url_click" value="{$DATA.url}" maxlength="255">
                                </div>
                                <div class="form-text mt-1 text-muted small">{$LANG->getModule('note_url_click')}</div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="idtype_open" class="form-label">{$LANG->getModule('window_click')}:</label>
                                <div class="position-relative">
                                    <select name="type_open" class="form-control" id="idtype_open">
                                        {foreach from=$WINDOW_CLICK key=id item=row}
                                        <option value="{$id}" {if $id == $DATA.type_open} selected="selected" {/if}>{$row}</option>
                                        {/foreach}
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="idcss_class" class="form-label">{$LANG->getModule('css_class')}:</label>
                        <div class="position-relative">
                            <input type="text" class="form-control" id="idcss_class" name="css_class" value="{$DATA.css_class}" maxlength="255">
                        </div>
                    </div>
                    <div class="mb-3 d-flex">
                        <label for="lb_is_all_page" class="form-label mb-0 me-2">
                            {$LANG->getModule('show_all_page')} 
                            <span class="text-danger">(*)</span>:
                        </label>
                        <div class="form-check form-switch mb-0">
                            <input class="form-check-input" type="checkbox" role="switch" name="is_all_page" {if $DATA.is_all_page == 1} checked="checked" {/if} value="1" id="lb_is_all_page" style="cursor: pointer;">
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="idshow_page" class="form-label">{$LANG->getModule('show_page')} <span class="text-danger {if $DATA.is_all_page == 1} hidden d-none {/if}" id="required_page">(*)</span>:</label>
                        <div class="position-relative">
                            <div class="popup-tree">
                            {foreach from=$MODULES key=module item=funcs}
                                <div class="module-item">
                                    <div class="module-header">
                                        <span class="toggle"><i class="fa fa-angle-right toggle fa-lg"></i></span>
                                        <label>
                                            <input type="checkbox" class="module-checkbox form-check-input m-0 me-1" data-module="{$module}">
                                            <span class="module-title">{$funcs.title}</span>
                                        </label>
                                    </div>
                                    <div class="func-list">
                                        {foreach from=$funcs.list_func item=func}
                                            <label>
                                                <input type="checkbox" class="func-checkbox form-check-input m-0 me-1" data-module="{$module}" value="{$func.alias}">
                                                {$func.title}
                                            </label>
                                        {/foreach}
                                    </div>
                                </div>
                            {/foreach}
                            </div>
                            <input type="hidden" name="display_pages" id="display_pages" value='{$DATA.display_pages}'>
                        </div>
                    </div>                    
                    <div class="mb-3">
                        <label for="content_popup_html" class="form-label">{$LANG->getModule('content')} <span class="text-danger">(*)</span>:</label>
                        <div class="position-relative">
                            <div data-toggle="container-content_popup_html">
                                {if $HAS_EDITOR}
                                {$DATA.content}
                                {else}
                                <textarea class="form-control required" id="content_popup_html" name="content" rows="15">{$DATA.content}</textarea>
                                {/if}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-4 col-xxl-3">
            <div class="card mb-3">
                <div class="card-header fw-medium fs-5">
                    {$LANG->getModule('display_settings')}
                </div>
                <div class="card-body">
                    <div class="mb-3">
                        <label for="idstatus" class="form-label">{$LANG->getModule('status')}:</label>
                        <div class="position-relative">
                            <select name="status" class="form-control" id="idstatus">
                                {foreach from=$STATUS key=id item=row}
                                <option value="{$id}" {if $id == $DATA.status} selected="selected" {/if}>{$row}</option>
                                {/foreach}
                            </select>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="idpriority" class="form-label">{$LANG->getModule('priority')} <span class="text-danger">(*)</span>:</label>
                        <div class="position-relative">
                            <input class="required form-control" name="priority" id="idpriority" type="number" value="{$DATA.priority}" min="1">
                            <div class="invalid-tooltip"></div>
                        </div>
                        <div class="form-text">{$LANG->getModule('note_priority')}</div>
                    </div>
                    <div class="mb-3">
                        <label for="idtype_popup" class="form-label">{$LANG->getModule('type_popup')}:</label>
                        <div class="position-relative">
                            <select name="type_popup" class="form-control">
                                {foreach from=$TYPE_POPUP key=key item=row}
                                <option value="{$key}" {if $key == $DATA.popup_type} selected="selected" {/if}>{$row}</option>
                                {/foreach}
                            </select>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="iddisplay_layout" class="form-label">{$LANG->getModule('display_layout')}:</label>
                        <div class="position-relative">
                            <select name="display_layout" class="form-control" id="iddisplay_layout">
                                {foreach from=$LAYOUT key=id item=row}
                                <option value="{$id}" {if $id == $DATA.display_layout} selected="selected" {/if}>{$row}</option>
                                {/foreach}
                            </select>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="iddisplay_object" class="form-label">{$LANG->getModule('display_object')}:</label>
                        <div class="position-relative">
                            <select name="display_object" class="form-control" id="iddisplay_object">
                                {foreach from=$OBJECT key=id item=row}
                                <option value="{$id}" {if $id == $DATA.display_object} selected="selected" {/if}>{$row}</option>
                                {/foreach}
                            </select>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="iddisplay_device" class="form-label">{$LANG->getModule('display_device')}:</label>
                        <div class="position-relative">
                            <select name="display_device" class="form-control" id="iddisplay_device">
                                {foreach from=$DEVICE key=id item=row}
                                <option value="{$id}" {if $id == $DATA.display_device} selected="selected" {/if}>{$row}</option>
                                {/foreach}
                            </select>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card mb-3">
                <div class="card-header fw-medium fs-5">
                    {$LANG->getModule('display_type')}
                </div>
                <div class="card-body">
                    <div class="mb-3">
                        <label for="iddisplay_type" class="form-label">{$LANG->getModule('typedisplay')}:</label>
                        <div class="position-relative">
                            <select name="display_type" class="form-control" id="iddisplay_type">
                                {foreach from=$DISPLAY_TYPE key=key item=row}
                                <option value="{$key}" {if $key == $DATA.display_type} selected="selected" {/if}>{$row}</option>
                                {/foreach}
                            </select>
                        </div>
                    </div>
                    <div id="id_display_interval" class="mb-3{if $DATA.display_type != 3} hidden d-none {/if}">
                        <label for="iddisplay_interval" class="form-label">{$LANG->getModule('display_interval')}:</label>
                        <div class="position-relative">
                            <input class="form-control" name="display_interval" type="number" id="iddisplay_interval" value="{$DATA.display_interval}" min="0">
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="idmax_show" class="form-label">{$LANG->getModule('max_show')}:</label>
                        <div class="position-relative">
                            <input class="form-control" name="max_show" type="number" id="idmax_show" value="{$DATA.max_show}" min="0">
                        </div>
                        <div class="form-text">{$LANG->getModule('max_show_note')}</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="text-center">
        <input type="hidden" name="submit" value="1">
        <input type="hidden" value="1" name="save" id="save">
        <button type="submit" class="btn btn-primary">{$LANG->getModule('save')}</button>
    </div>
</form>
