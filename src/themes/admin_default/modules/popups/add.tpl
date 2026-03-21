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
                            <div class="clearfix">
                                <select id="list_page_show" name="list_page[]" class="form-control gselect2 w400 pull-left" multiple="multiple">
                                    <option value="-1">{$LANG->getModule('all_page')}</option>
                                    {foreach from=$ARR_PAGE key=id item=row}
                                    <option value="{$id}" {if in_array($id, $DATA.list_page)} selected="selected" {/if}>{$row}</option>
                                    {/foreach}
                                </select>
                            </div>
                            <span class="help-block help-block-bottom">{$LANG->getModule('choose_all_ctrl')}</span>
                        </td>
                    </tr>
                    <tr>
                        <td>{$LANG->getModule('type_popup')}:</td>
                        <td></td>
                        <td>
                            <select name="type_popup" class="form-control w400 valid" aria-invalid="false">
                                {foreach from=$TYPE_POPUP key=key item=row}
                                <option value="{$key}" {if $key == $SEARCH.type_popup} selected="selected" {/if}>{$row}</option>
                                {/foreach}
                            </select>
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
                        <td>{$LANG->getModule('priority')}:</td>
                        <td><sup class="required">∗</sup></td>
                        <td>
                            <input class="w400 required form-control" name="priority" type="number" value="{$DATA.priority}" min="1">
                            <span class="help-block help-block-bottom">{$LANG->getModule('note_priority')}</span>
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
            <input type="submit" value="{$LANG->getModule('save')}" class="btn btn-primary">
        </div>
        <div id="demo"></div>
    </form>
</div>
<script>
    $(document).ready(function() {
        $(".gselect2").select2();
        $('#form_add_new_popup').validate();
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
    });
</script>
