<link type="text/css" href="{ASSETS_STATIC_URL}/js/jquery-ui/jquery-ui.min.css" rel="stylesheet" />
<script type="text/javascript" src="{ASSETS_STATIC_URL}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="{ASSETS_LANG_STATIC_URL}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>

<div class="well">
    <form action="" method="get" id="form_search_popup">
        <div class="row">
            <div class="col-xs-12 col-md-6 col-sm-6">
                <div class="form-group">
                    <label><strong>{$LANG->getModule('key_word')}:</strong></label>
                    <input class="form-control" type="text" data-default="" value="{$SEARCH.keyword}" name="q" maxlength="255" placeholder="{$LANG->getModule('enter_keyword')}">
                </div>
            </div>
            <div class="col-xs-12 col-md-6 col-sm-6">
                <div class="form-group">
                    <label><strong>{$LANG->getModule('status')}:</strong></label>
                    <select class="form-control" name="status" data-default="0">
                        <option value="-1">{$LANG->getModule('all')}</option>
                        {foreach from=$STATUS key=key item=row}
                        <option value="{$key}" {if $key == $SEARCH.status} selected="selected" {/if}>{$row}</option>
                        {/foreach}
                    </select>
                </div>
            </div>
            <div class="col-xs-12 col-md-6 col-sm-6">
                <div class="form-group">
                    <label><strong>{$LANG->getModule('type_popup')}:</strong></label>
                    <select class="form-control" name="type_popup" data-default="0">
                        <option value="0">{$LANG->getModule('all')}</option>
                        {foreach from=$TYPE_POPUP key=key item=row}
                        <option value="{$key}" {if $key == $SEARCH.type_popup} selected="selected" {/if}>{$row}</option>
                        {/foreach}
                    </select>
                </div>
            </div>
            <div class="col-xs-12 col-md-6 col-sm-6">
                <div class="form-group">
                    <label><strong>{$LANG->getModule('display_layout')}:</strong></label>
                    <select class="form-control" name="display_layout" data-default="0">
                        <option value="0">{$LANG->getModule('all')}</option>
                        {foreach from=$LAYOUT key=key item=row}
                        <option value="{$key}" {if $key == $SEARCH.display_layout} selected="selected" {/if}>{$row}</option>
                        {/foreach}
                    </select>
                </div>
            </div>
            <div class="col-xs-12 col-md-6 col-sm-6">
                <div class="form-group">
                    <label for="ipt_fromtime"><strong>{$LANG->getModule('start_time')}:</strong></label>
                    <input class="form-control datepicker" data-default="" id="start_time" type="text" value="{$SEARCH.start_time}" name="start_time" maxlength="10" autocomplete="off" placeholder="dd-mm-yyyy">
                </div>
            </div>
            <div class="col-xs-12 col-md-6 col-sm-6">
                <div class="form-group">
                    <label for="ipt_totime"><strong>{$LANG->getModule('end_time')}:</strong></label>
                    <input class="form-control datepicker" data-default="" id="end_time" type="text" value="{$SEARCH.end_time}" name="end_time" maxlength="10" autocomplete="off" placeholder="dd-mm-yyyy">
                </div>
            </div>
            <div class="col-xs-12 col-md-6 col-sm-6">
                <div class="form-group">
                    <label class="visible-sm-block visible-md-block visible-lg-block">&nbsp;</label>
                    <input class="btn btn-primary" type="submit" value="{$LANG->getModule('search')}">
                    <input class="btn btn-default" id="btn_reset_form_search" type="button" value="{$LANG->getModule('reset')}">
                </div>
            </div>
        </div>
    </form>
</div>
<div class="table-responsive">
    <table class="table table-striped table-bordered table-hover vertical-align" style="padding: 0px;">
        <thead class="tableFloatingHeaderOriginal">
            <tr>
                <th class="text-center w50">{$LANG->getModule('stt')}</th>
                <th class="text-center"><div class="inlineblock">{$LANG->getModule('title')}</div></th>
                <th class="text-center"><div class="inlineblock">{$LANG->getModule('type_popup')}</div></th>
                <th class="text-center"><div class="inlineblock">{$LANG->getModule('display_layout')}</div></th>
                <th class="text-center"><div class="inlineblock">{$LANG->getModule('time_valid')}</div></th>
                <th class="text-center"><div class="inlineblock">{$LANG->getModule('status')}</div></th>
                <th class="text-center"><div class="inlineblock">{$LANG->getModule('statics')}</div></th>
                <th class="text-center"><div class="inlineblock">{$LANG->getModule('action')}</div></th>
            </tr>
        </thead>
        <tbody>
            {foreach from=$DATA item=row}
            <tr>
                <td class="text-center">{$row.stt}</td>            
                <td><a href="{$row.link}">{$row.title}</a></td>
                <td class="text-center">{$row.popup_type}</td>
                <td class="text-center">{$row.display_layout}</td>
                <td class="text-center"><span>{$row.start_time}</span><br/><span>{$row.end_time}</span></td>
                <td class="text-center">
                    <div class="dropdown" id="status-container-{$row.id}">
                        <span class="label label-{$row.label_status} dropdown-toggle pointer" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" id="badge-status-{$row.id}">
                            {$row.status} <i class="fa fa-angle-down ml-1"></i>
                        </span>
                        <div class="dropdown-menu shadow border-0 py-2 list-group list-group-flush status-select-menu">
                            <a href="javascript:void(0)" onclick="changePopupStatus({$row.id}, 1, '{$LANG->getModule('status_1')}', 'badge-success')" class="list-group-item list-group-item-action py-2 text-success">
                                <i class="fa fa-check-circle mr-2"></i> {$LANG->getModule('status_1')}
                            </a>
                            <a href="javascript:void(0)" onclick="changePopupStatus({$row.id}, 0, '{$LANG->getModule('status_0')}', 'label-warning text-dark')" class="list-group-item list-group-item-action py-2 text-warning">
                                <i class="fa fa-clock-o mr-2"></i> {$LANG->getModule('status_0')}
                            </a>
                            <a href="javascript:void(0)" onclick="changePopupStatus({$row.id}, 2, '{$LANG->getModule('status_2')}', 'label-danger')" class="list-group-item list-group-item-action py-2 text-danger">
                                <i class="fa fa-ban mr-2"></i> {$LANG->getModule('status_2')}
                            </a>
                        </div>
                    </div>
                </td>
                <td class="text-center">
                    <span title="{$LANG->getModule('total_view')}" class="text-secondary">
                        <strong><i class="fa fa-eye"></i> {$row.total_view}</strong>
                    </span>
                    
                    <span title="{$LANG->getModule('total_click')}" class="text-primary margin-left-lg" style="font-weight: 600;">
                        <strong><i class="fa fa-mouse-pointer"></i> {$row.total_click}</strong>
                    </span>
                    
                    <span title="{$LANG->getModule('total_closed')}" class="text-danger margin-left-lg">
                        <strong><i class="fa fa-times-circle"></i> {$row.total_closed}</strong>
                    </span>
                </td>
                <td class="text-center">
                    <a href="{$row.link_edit}" title="{$LANG->getModule('edit')}" class="btn btn-primary btn-xs"><em class="fa fa-edit fa-xs"></em></a>
                    <button type="button" title="{$LANG->getModule('delete')}" class="btn btn-danger btn-xs delete_popup margin-left" data-id={$row.id}><em class="fa fa-trash-o fa-xs"></em></button>
                </td>
            </tr>
            {/foreach}
        </tbody>
        {if not empty($GENERATE_PAGE)}
        <tfoot class="text-center">
            <tr>
                <td colspan="10">
                    {$GENERATE_PAGE}
                </td>
            </tr>
        </tfoot>
        {/if}
    </table>
</div>
<script type="text/javascript">
$(function() {
    $('.btn-status-popover').each(function() {
        var id = $(this).data('id');
        $(this).popover({
            html: true,
            sanitize: false, // Quan trọng để nhận HTML bên trong
            content: function() {
                // Lấy nội dung từ div ẩn tương ứng
                return $('#popover-content-' + id).html();
            },
            // Tạo template mới không có tiêu đề, chỉ có thân
            template: '<div class="popover" role="tooltip"><div class="popover-body p-0"></div></div>'
        });
    });
    form = $('#form_search_popup');
    $('#btn_reset_form_search').on('click', function (e) {
        e.preventDefault();
        $("[data-default]", form).each(function() {
            if ($(this).is("input[type=text], input[type=hidden], input[type=number]")) {
                $(this).val($(this).attr("data-default"));
            } else if ($(this).is("select")) {
                $(this).val($(this).attr("data-default"));
            }
        });
        $('html, body').animate({ scrollTop : $('#contentmod').offset().top }, 800);
    });

    $('.delete_popup').on('click', function (e) {
        e.preventDefault();
        let btn = $(this);
         btn.prop('disabled', true);
        id_popup = btn.data('id');
        nvConfirm(nv_is_del_confirm[0], function() {  
            $.ajax({
                type: 'POST',
                url: script_name + '?' + nv_lang_variable + '=' + nv_lang_data + '&' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=' + nv_func_name + '&nocache=' + new Date().getTime(),
                data: {
                    "delete": 1,
                    "id": id_popup,
                    "checkss": '{$CHECKSS}',
                },
                success: function (res) {
                    btn.prop('disabled', false);
                    if (res == 'OK') {
                        location.reload();
                        return;
                    }
                    nvToast(nv_is_del_confirm[2], 'error');
                },
                error: function (xhr, text, err) {
                    btn.prop('disabled', false);
                    nvToast(text, 'error');
                }
            });
        }, function() {
            btn.prop('disabled', false);
        });
    });  
});

$(document).ready(function() {
    $("#start_time, #end_time").datepicker({
        dateFormat : "dd/mm/yy",
        changeMonth : true,
        changeYear : true,
        showOtherMonths : true,
        showOn: 'focus'
    });    
});
function changePopupStatus(id, newStatus, textStatus, label) {
    var badge = $('#badge-status-' + id);
    badge.addClass('opacity-50');
    $.ajax({
        type: 'POST',
        url: script_name + '?' + nv_lang_variable + '=' + nv_lang_data + '&' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=' + nv_func_name + '&nocache=' + new Date().getTime(),
        data: {
            "change_status": 1,
            "id": id,
            "checkss": '{$CHECKSS}',
            "status": newStatus
        },
        success: function (res) {
            if (res == 'OK') {
                badge.removeClass('badge-success badge-warning badge-danger opacity-50');                
                badge.html(textStatus + ' <i class="fa fa-angle-down ml-1"></i>').addClass(label);
                nvToast(nv_is_change_act_confirm[1], 'success');
            } else {
                nvToast(nv_is_change_act_confirm[2], 'error');
                badge.removeClass('opacity-50');
            }            
        },
        error: function (xhr, text, err) {
            nvToast(text, 'error');
        }
    });
}
</script>
