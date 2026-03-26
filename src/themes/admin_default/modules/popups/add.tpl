<script type="text/javascript" src="{ASSETS_STATIC_URL}/js/jquery/jquery.validate.min.js"></script>
<script type="text/javascript" src="{ASSETS_LANG_STATIC_URL}/js/language/jquery.validator-{NV_LANG_INTERFACE}.js"></script>
<link rel="stylesheet" href="{ASSETS_STATIC_URL}/js/select2/select2.min.css">
<script type="text/javascript" src="{ASSETS_STATIC_URL}/js/select2/select2.min.js"></script>
<link type="text/css" href="{ASSETS_STATIC_URL}/js/jquery-ui/jquery-ui.min.css" rel="stylesheet" />
<script type="text/javascript" src="{ASSETS_STATIC_URL}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="{ASSETS_LANG_STATIC_URL}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>
{if $ERROR}
<div class="alert alert-danger">{$ERROR}</div>
{/if}
<div id="contentmod">              
    <form id="form_add_new_popup" method="post" enctype="multipart/form-data" action="{$FORM_ACTION}" novalidate="novalidate">
        <input type="hidden" value="1" name="save" id="save">
        <div class="table-responsive">
            <table class="table table-striped table-bordered table-hover">
                <colgroup><col class="w400">
                <col class="w20">
                <col>
                </colgroup><tbody>
                    <tr>
                        <td>{$LANG->getModule('title')}:</td>
                        <td><sup class="required">∗</sup></td>
                        <td><input class="w400 required form-control" name="title" type="text" value="{$DATA.title}" maxlength="255"></td>
                    </tr>
                    <tr>
                        <td>{$LANG->getModule('description')}:</td>
                        <td></td>
                        <td>
                            <input class="w400 form-control" name="description" type="text" value="{$DATA.description}" maxlength="255">
                        </td>
                    </tr>
                    <tr>
                        <td>{$LANG->getModule('show_all_page')}:</td>
                        <td>&nbsp;</td>
                        <td>
                            <label class="margin-right"><input name="is_all_page" type="checkbox" value="1" {if $DATA.is_all_page == 1} checked=checked {/if}></label>
                        </td>
                    </tr>
                    <tr>
                        <td>{$LANG->getModule('show_page')}:</td>
                        <td><sup class="required{if $DATA.is_all_page == 1} hidden {/if}" id="required_page">∗</sup></td>
                        <td>
                            <div class="popup-tree">
                            {foreach from=$MODULES key=module item=funcs}
                                <div class="module-item">
                                    <div class="module-header">
                                        <span class="toggle"><i class="fa fa-angle-right toggle fa-lg"></i></span>
                                        <label>
                                            <input type="checkbox" class="module-checkbox" data-module="{$module}">
                                            <span class="module-title">{$funcs.title}</span>
                                        </label>
                                    </div>
                                    <div class="func-list">
                                        {foreach from=$funcs.list_func item=func}
                                            <label>
                                                <input type="checkbox" class="func-checkbox" data-module="{$module}" value="{$func.alias}">
                                                {$func.title}
                                            </label>
                                        {/foreach}
                                    </div>
                                </div>
                            {/foreach}
                            </div>
                            <input type="hidden" name="display_pages" id="display_pages" value='{$DATA.display_pages}'>
                        </td>
                    </tr>
                    <tr>
                        <td>{$LANG->getModule('priority')}:</td>
                        <td><sup class="required">∗</sup></td>
                        <td>
                            <input class="w400 required form-control" name="priority" type="number" value="{$DATA.priority}" min="1">
                            <span class="help-block help-block-bottom">{$LANG->getModule('note_priority')}</span>
                        </td>
                    </tr>
                    <tr>
                        <td>{$LANG->getModule('type_popup')}:</td>
                        <td></td>
                        <td>
                            <select name="type_popup" class="form-control w400 valid" aria-invalid="false">
                                {foreach from=$TYPE_POPUP key=key item=row}
                                <option value="{$key}" {if $key == $DATA.popup_type} selected="selected" {/if}>{$row}</option>
                                {/foreach}
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>{$LANG->getModule('display_type')}:</td>
                        <td></td>
                        <td>
                            <select name="display_type" class="form-control w400 valid" aria-invalid="false">
                                {foreach from=$DISPLAY_TYPE key=key item=row}
                                <option value="{$key}" {if $key == $DATA.display_type} selected="selected" {/if}>{$row}</option>
                                {/foreach}
                            </select>
                        </td>
                    </tr>
                    <tr id="tr_display_interval" class="{if $DATA.display_type != 3} hidden {/if}">
                        <td>{$LANG->getModule('display_interval')}:</td>
                        <td><sup class="required">∗</sup></td>
                        <td>
                            <input class="w400 required form-control" name="display_interval" type="number" value="{$DATA.display_interval}" min="0">
                        </td>
                    </tr>
                    <tr>
                        <td>{$LANG->getModule('max_show')}:</td>
                        <td><sup class="required">∗</sup></td>
                        <td>
                            <input class="w400 required form-control" name="max_show" type="number" value="{$DATA.max_show}" min="0">
                            <span class="help-block help-block-bottom">{$LANG->getModule('max_show_note')}</span>
                        </td>
                    </tr>
                    <tr>
                        <td>{$LANG->getModule('display_layout')}:</td>
                        <td></td>
                        <td>
                            <select name="display_layout" class="form-control gselect2 w400 valid" aria-invalid="false">
                                {foreach from=$LAYOUT key=id item=row}
                                <option value="{$id}" {if $id == $DATA.display_layout} selected="selected" {/if}>{$row}</option>
                                {/foreach}
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>{$LANG->getModule('status')}:</td>
                        <td></td>
                        <td>
                            <select name="status" class="form-control gselect2 w400 valid" aria-invalid="false">
                                {foreach from=$STATUS key=id item=row}
                                <option value="{$id}" {if $id == $DATA.status} selected="selected" {/if}>{$row}</option>
                                {/foreach}
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>{$LANG->getModule('display_object')}:</td>
                        <td></td>
                        <td>
                            <select name="display_object" class="form-control w400 valid" aria-invalid="false">
                                {foreach from=$OBJECT key=id item=row}
                                <option value="{$id}" {if $id == $DATA.display_object} selected="selected" {/if}>{$row}</option>
                                {/foreach}
                            </select>
                        </td>
                    </tr>                    
                    <tr>
                        <td>{$LANG->getModule('display_device')}:</td>
                        <td></td>
                        <td>
                            <select name="display_device" class="form-control w400 valid" aria-invalid="false">
                                {foreach from=$DEVICE key=id item=row}
                                <option value="{$id}" {if $id == $DATA.display_device} selected="selected" {/if}>{$row}</option>
                                {/foreach}
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>{$LANG->getModule('url_click')}:</td>
                        <td>&nbsp;</td>
                        <td>
                            <input class="form-control w400" name="url_click" type="text" value="{$DATA.url}" maxlength="255">
                            <span class="help-block help-block-bottom">{$LANG->getModule('note_url_click')}</span>
                        </td>
                    </tr>
                    <tr>
                        <td>{$LANG->getModule('window_click')}:</td>
                        <td>&nbsp;</td>
                        <td>
                            <select name="type_open" class="form-control w400">
                                {foreach from=$WINDOW_CLICK key=id item=row}
                                <option value="{$id}" {if $id == $DATA.type_open} selected="selected" {/if}>{$row}</option>
                                {/foreach}
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>{$LANG->getModule('css_class')}:</td>
                        <td></td>
                        <td>
                            <input class="w400 form-control" name="css_class" type="text" value="{$DATA.css_class}">
                        </td>
                    </tr>
                    <tr>
                        <td>{$LANG->getModule('start_time')}:</td>
                        <td>&nbsp;</td>
                        <td>
                            <div class="clearfix">
                                <div class="input-group pull-left">
                                    <input name="start_time" id="start_time" value="{$DATA.start_time}" class="form-control w200" type="text" />
                                    <span class="input-group-btn pull-left">
                                        <button class="btn btn-default start-date-btn" type="button" id="start-date-btn"> <em class="fa fa-calendar fa-fix">&nbsp;</em></button>
                                    </span>
                                </div>
                                <select class="form-control pull-left margin-left w60" name="start_date_h" id="start_date_h">
                                    {for $value=0 to 23}
                                    <option value="{$value}"{if $value == $DATA.start_hour} selected="selected" {/if}>{if $value < 10} 0{$value}{else}{$value}{/if}</option>
                                    {/for}
                                </select>
                                <select class="form-control pull-left margin-left w60" name="start_date_m" id="start_date_m">
                                    {for $value=0 to 59}
                                    <option value="{$value}"{if $value == $DATA.start_minute} selected="selected" {/if}>{if $value < 10} 0{$value}{else}{$value}{/if}</option>
                                    {/for}
                                </select>
                            </div>
                            <span class="help-block help-block-bottom">{$LANG->getModule('note_start_time')}</span>
                        </td>
                    </tr>
                    <tr>
                        <td>{$LANG->getModule('end_time')}:</td>
                        <td>&nbsp;</td>
                        <td>
                            <div class="clearfix" id="exp_date_manual">
                                <div class="clearfix">
                                    <div class="input-group pull-left">
                                        <input name="end_time" id="end_time" value="{$DATA.end_time}" class="form-control w200" type="text" />
                                        <span class="input-group-btn pull-left">
                                            <button class="btn btn-default end-date-btn" type="button" id="end-date-btn"> <em class="fa fa-calendar fa-fix">&nbsp;</em></button>
                                        </span>
                                    </div>
                                    <select class="form-control pull-left margin-left w60" name="end_date_h" id="end_date_h">
                                        {for $value=0 to 23}
                                        <option value="{$value}"{if $value == $DATA.end_hour} selected="selected" {/if}>{if $value < 10} 0{$value}{else}{$value}{/if}</option>
                                        {/for}
                                    </select>
                                    <select class="form-control pull-left margin-left w60" name="end_date_m" id="end_date_m">
                                        {for $value=0 to 59}
                                        <option value="{$value}"{if $value == $DATA.end_minute} selected="selected" {/if}>{if $value < 10} 0{$value}{else}{$value}{/if}</option>
                                        {/for}
                                    </select>
                                </div>
                            </div>
                            <span class="help-block help-block-bottom">{$LANG->getModule('note_end_time')}</span>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <p class="m-bottom">{$LANG->getModule('content')}:</p>
                            <div class="position-relative">
                                <div data-toggle="container-content_popup_html">
                                    {if $HAS_EDITOR}
                                    {$DATA.content}
                                    {else}
                                    <textarea class="form-control required" id="content_popup_html" name="content" rows="15">{$DATA.content}</textarea>
                                    {/if}
                                </div>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="text-center">
            <input type="hidden" name="checkss" value="{$CHECKSS}">
            <input type="submit" value="{$LANG->getModule('save')}" class="btn btn-primary">
        </div>
        <div id="demo"></div>
    </form>
</div>
<script>
    $(document).ready(function() {
        $(".gselect2").select2();
        $('#form_add_new_popup').validate();
        $('select[name="display_type"]').change(function(){
            if ($(this).val() != 3) {
                $("#tr_display_interval").addClass('hidden');
            } else {
                $("#tr_display_interval").removeClass('hidden');
            }
        });
        $('input[name="is_all_page"]').change(function(){
            if ($(this).is(':checked')) {
                $("#required_page").addClass('hidden');
            } else {
                $("#required_page").removeClass('hidden');
            }
        });
        $("#start_time, #end_time").datepicker({
            dateFormat : "dd/mm/yy",
            changeMonth : true,
            changeYear : true,
            showOtherMonths : true,
            showOn: 'focus'
        });
        $('#start-date-btn').click(function(){
            $("#start_time").datepicker('show');
        });
        $('#end-date-btn').click(function(){
            $("#end_time").datepicker('show');
        });

        // Toggle collapse
        $('.module-header').click(function(e) {
            if ($(e.target).is('input')) return;
            let $item = $(this).closest('.module-item');
            $item.toggleClass('open');
            $(this).find('.toggle')
                .html($item.hasClass('open') ? '<i class="fa fa-angle-down toggle fa-lg"></i>' : '<i class="fa fa-angle-right toggle fa-lg"></i>');
        });

        // Check module thì check all func
        $('.module-checkbox').change(function() {
            let module = $(this).data('module');
            $('.func-checkbox[data-module="' + module + '"]').prop('checked', $(this).is(':checked'));
            buildData();
        });

        // Check func thì chỉ cần build lại data
        $('.func-checkbox').change(function() {
            buildData();
        });

        let val = $('#display_pages').val();
        if (val) {
            let data = JSON.parse(val);
            $.each(data, function(module, funcs) {
                funcs.forEach(function(fun) {
                    $('.func-checkbox[data-module="' + module + '"][value="' + fun + '"]').prop('checked', true);
                });
                $('.module-checkbox[data-module="' + module + '"]').prop('checked', true);
            });
        }

        function buildData() {
            let data = {};
            $('.module-checkbox').each(function() {
                let module = $(this).data('module');
                let funcs = $('.func-checkbox[data-module="' + module + '"]:checked');
                if (funcs.length === 0) return;
                data[module] = [];
                funcs.each(function() {
                    data[module].push($(this).val());
                });
            });
            $('#display_pages').val(JSON.stringify(data));
        }
    });
</script>
