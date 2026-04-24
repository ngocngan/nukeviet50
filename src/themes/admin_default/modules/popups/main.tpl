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
                    <select class="form-control" name="status" data-default="-1">
                        <option value="-1">{$LANG->getModule('all_status')}</option>
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
                        <option value="0">{$LANG->getModule('all_type')}</option>
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
                        <option value="0">{$LANG->getModule('all_layout')}</option>
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
    <table class="table table-striped table-bordered table-hover vertical-align">
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
                            <a href="javascript:void(0)" onclick="changePopupStatus({$row.id}, 1, '{$LANG->getModule('status_1')}', 'badge-success', '{$CHECKSS}')" class="list-group-item list-group-item-action py-2 text-success">
                                <i class="fa fa-check-circle mr-2"></i> {$LANG->getModule('status_1')}
                            </a>
                            <a href="javascript:void(0)" onclick="changePopupStatus({$row.id}, 0, '{$LANG->getModule('status_0')}', 'label-warning text-dark', '{$CHECKSS}')" class="list-group-item list-group-item-action py-2 text-warning">
                                <i class="fa fa-clock-o mr-2"></i> {$LANG->getModule('status_0')}
                            </a>
                            <a href="javascript:void(0)" onclick="changePopupStatus({$row.id}, 2, '{$LANG->getModule('status_2')}', 'label-danger', '{$CHECKSS}')" class="list-group-item list-group-item-action py-2 text-danger">
                                <i class="fa fa-ban mr-2"></i> {$LANG->getModule('status_2')}
                            </a>
                        </div>
                    </div>
                </td>
                <td class="text-center">
                    <span title="{$LANG->getModule('total_view')}" class="{if $row.total_view > 0}text-primary {else}text-muted{/if}">
                        <strong><i class="fa fa-eye"></i> {$row.total_view}</strong>
                    </span>

                    <span title="{$LANG->getModule('total_click')}" class="{if $row.total_click > 0}text-success{else}text-muted{/if} margin-left-lg">
                        <strong><i class="fa fa-mouse-pointer"></i> {$row.total_click}</strong>
                    </span>

                    <span title="{$LANG->getModule('total_closed')}" class="{if $row.total_closed > 0}text-danger{else}text-muted{/if} margin-left-lg">
                        <strong><i class="fa fa-times-circle"></i> {$row.total_closed}</strong>
                    </span>
                </td>
                <td class="text-center">
                    <a href="{$row.link_preview}" title="{$LANG->getModule('preview_popup')}" class="btn btn-primary btn-xs"><em class="fa fa-eye fa-xs"></em></a>
                    <a href="{$row.link_edit}" title="{$LANG->getModule('edit')}" class="btn btn-primary btn-xs margin-left"><em class="fa fa-edit fa-xs"></em></a>
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
