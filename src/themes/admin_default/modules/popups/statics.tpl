<link type="text/css" href="{ASSETS_STATIC_URL}/js/jquery-ui/jquery-ui.min.css" rel="stylesheet" />
<script type="text/javascript" src="{ASSETS_STATIC_URL}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="{ASSETS_LANG_STATIC_URL}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>

<div class="well">
    <form action="" method="get" id="form_search_popup">
        <div class="row">            
            <div class="col-xs-12 col-md-6 col-sm-6">
                <div class="form-group">
                    <label><strong>{$LANG->getModule('status')}:</strong></label>
                    <select class="form-control" name="status" data-default="-1">
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
                    <label><strong>{$LANG->getModule('display_object')}:</strong></label>
                    <select class="form-control" name="display_object" data-default="0">
                        {foreach from=$OBJECT key=key item=row}
                        <option value="{$key}" {if $key == $SEARCH.display_object} selected="selected" {/if}>{$row}</option>
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
                    <input class="btn btn-primary" type="submit" value="{$LANG->getModule('filter')}">
                    <input class="btn btn-default" id="btn_reset_form_search" type="button" value="{$LANG->getModule('reset')}">
                </div>
            </div>
        </div>
    </form>
</div>
<div class="popup-stats-wrapper">    
    <div class="popup-stat-card btn-success">
        <div class="stat-title">{$LANG->getModule('total_view')}</div>
        <div class="stat-value">{$STATICS.total_view}</div>        
    </div>
    <div class="popup-stat-card btn-primary">
        <div class="stat-title">{$LANG->getModule('total_click')}</div>
        <div class="stat-value">{$STATICS.total_click}</div>        
    </div>
    <div class="popup-stat-card btn-warning">
        <div class="stat-title">{$LANG->getModule('total_closed')}</div>
        <div class="stat-value">{$STATICS.total_closed}</div>        
    </div>    
    <div class="popup-stat-card btn-info">
        <div class="stat-title">{$LANG->getModule('ctr_click_view')}</div>
        <div class="stat-value">{$STATICS.ctr_click_view}</div>        
    </div>
    <div class="popup-stat-card btn-danger">
        <div class="stat-title">{$LANG->getModule('ctr_closed_view')}</div>
        <div class="stat-value">{$STATICS.ctr_closed_view}</div>        
    </div>
</div>
<div class="table-responsive">
    <table class="table table-striped table-bordered table-hover">
        <thead class="tableFloatingHeaderOriginal">
            <tr>
                <th class="w50 text-center">{$LANG->getModule('stt')}</th>
                <th class="text-center"><div class="inlineblock">{$LANG->getModule('title')}</div></th>
                <th class="text-center"><div class="inlineblock">{$LANG->getModule('total_view')}</div></th>
                <th class="text-center"><div class="inlineblock">{$LANG->getModule('total_click')}</div></th>
                <th class="text-center"><div class="inlineblock">{$LANG->getModule('ctr_click_view')}</div></th>
                <th class="text-center w250"><div class="inlineblock">{$LANG->getModule('total_closed')}</div></th>
                <th class="text-center"><div class="inlineblock">{$LANG->getModule('ctr_closed_view')}</div></th>
            </tr>
        </thead>
        <tbody>
            {foreach from=$DATA item=row}
            <tr>
                <td class="text-center">{$row.stt}</td>            
                <td><a href="{$row.link}">{$row.title}</a></td>
                <td class="text-center">{$row.total_view}</td>
                <td class="text-center">{$row.total_click}</td>
                <td class="text-center">{$row.ctr_click_view}</td>
                <td class="text-center">{$row.total_closed}</td>
                <td class="text-center">{$row.ctr_closed_view}</td>
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
</script>
