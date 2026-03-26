<script src="{$smarty.const.ASSETS_STATIC_URL}/js/flatpickr/flatpickr.min.js"></script>
<script src="{$smarty.const.ASSETS_STATIC_URL}/js/language/flatpickr-{$smarty.const.NV_LANG_INTERFACE}.js"></script>
<div class="card card-popup-content">
    <div class="card-header">
        <form action="" method="get" id="form_search_popup">
            <div class="row mb-3 g-2">
                <div class="col-6 col-md-3">
                    <input class="form-control" type="text" data-default="" value="{$SEARCH.keyword}" name="q" maxlength="255" aria-label="{$LANG->getModule('key_word')}" placeholder="{$LANG->getModule('key_word')}">
                </div>
                <div class="col-6 col-md-3">
                    <select class="form-control" name="status" data-default="-1" aria-label="{$LANG->getModule('search_by')}">
                        <option value="-1">{$LANG->getModule('status')}</option>
                        {foreach from=$STATUS key=key item=row}
                        <option value="{$key}" {if $key == $SEARCH.status} selected="selected" {/if}>{$row}</option>
                        {/foreach}
                    </select>
                </div>
                <div class="col-6 col-md-3">
                    <select class="form-control" name="type_popup" data-default="0" aria-label="{$LANG->getModule('search_by')}">
                        <option value="0">{$LANG->getModule('type_popup')}</option>
                        {foreach from=$TYPE_POPUP key=key item=row}
                        <option value="{$key}" {if $key == $SEARCH.type_popup} selected="selected" {/if}>{$row}</option>
                        {/foreach}
                    </select>
                </div>
                <div class="col-6 col-md-3">
                    <select class="form-control" name="display_layout" data-default="0" aria-label="{$LANG->getModule('search_by')}">
                        <option value="0">{$LANG->getModule('display_layout')}</option>
                        {foreach from=$LAYOUT key=key item=row}
                        <option value="{$key}" {if $key == $SEARCH.display_layout} selected="selected" {/if}>{$row}</option>
                        {/foreach}
                    </select>
                </div>
                <div class="col-6 col-md-3">
                    <div class="input-group">
                        <input class="form-control flatpickr-input" data-default="" id="start_time" type="text" value="{$SEARCH.start_time}" name="start_time" readonly="readonly" placeholder="{$LANG->getModule('from_date')}" aria-label="{$LANG->getModule('from_date')}" aria-describedby="from-btn">
                        <button class="btn btn-secondary" type="button" id="from-btn" aria-label="{$LANG->getModule('from_date')}">
                            <i class="fa-solid fa-calendar"></i>
                        </button>
                    </div>
                </div>
                <div class="col-6 col-md-3">
                    <div class="input-group">
                        <input class="form-control flatpickr-input" data-default="" id="end_time" type="text" value="{$SEARCH.end_time}" name="end_time" readonly="readonly" placeholder="{$LANG->getModule('to_date')}" aria-label="{$LANG->getModule('to_date')}" aria-describedby="to-btn">
                        <button class="btn btn-secondary" type="button" id="to-btn" aria-label="{$LANG->getModule('to_date')}">
                            <i class="fa-solid fa-calendar"></i>
                        </button>
                    </div>
                </div>
                <div class="col-6 col-md-3">
                    <button class="btn btn-info">{$LANG->getModule('search')}</button>
                    <input class="btn btn-default" id="btn_reset_form_search" type="button" value="{$LANG->getModule('reset')}">
                </div>
            </div>
        </form>
    </div>
    <div class="card-body">
        <div class="table-responsive-lg table-card pb-1" id="list-news-items">
            <table class="table table-striped align-middle table-sticky mb-0">
                <colgroup>
                    <col style="width: 5%;">
                    <col style="width: 20%;">
                    <col style="width: 10%;">
                    <col style="width: 11%;">
                    <col style="width: 12%;">
                    <col style="width: 14%;">
                    <col style="width: 14%;">
                    <col style="width: 14%;">
                </colgroup>
                <thead class="tableFloatingHeaderOriginal">
                    <tr>
                        <th class="text-nowrap">
                            <input type="checkbox" data-toggle="checkAll" name="checkAll[]" class="form-check-input m-0 align-middle" aria-label="{$LANG->getGlobal('toggle_checkall')}">
                        </th>
                        <th class="text-nowrap">{$LANG->getModule('title')}</th>
                        <th class="text-nowrap">{$LANG->getModule('type_popup')}</th>
                        <th class="text-nowrap">{$LANG->getModule('display_layout')}</th>
                        <th class="text-nowrap">{$LANG->getModule('time_valid')}</th>
                        <th class="text-nowrap">{$LANG->getModule('status')}</th>
                        <th class="text-nowrap">{$LANG->getModule('statics')}</th>
                        <th class="text-nowrap">{$LANG->getModule('action')}</th>
                    </tr>
                </thead>
                <tbody>
                    {foreach from=$DATA item=row}
                    <tr>
                        <td class="checkbox-{$row.id}">
                            <input type="checkbox" data-toggle="checkSingle" name="checkSingle[]" value="{$row.id}" class="form-check-input m-0 align-middle" aria-label="{$LANG->getGlobal('toggle_checksingle')}">
                        </td>
                        <td><a href="{$row.link}">{$row.title}</a></td>
                        <td>{$row.popup_type}</td>
                        <td>{$row.display_layout}</td>
                        <td><span>{$row.start_time}</span><br/><span>{$row.end_time}</span></td>
                        <td>
                            <div class="dropdown" id="status-container-{$row.id}">
                                <a href="javascript:void(0)" 
                                class="badge-status-{$row.id} badge bg-{$row.label_status} rounded-pill dropdown-toggle pointer text-decoration-none" 
                                data-bs-toggle="dropdown" 
                                aria-expanded="false" 
                                id="badge-status-{$row.id}">{$row.status}</a>

                                <ul class="dropdown-menu shadow border-0">
                                    <li>
                                        <a class="dropdown-item py-2 text-success" href="javascript:void(0)" onclick="changePopupStatus({$row.id}, 1, '{$LANG->getModule('status_1')}', 'bg-success', '{$CHECKSS}')">
                                            <i class="fa fa-check-circle me-2"></i> {$LANG->getModule('status_1')}
                                        </a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item py-2 text-warning" href="javascript:void(0)" onclick="changePopupStatus({$row.id}, 0, '{$LANG->getModule('status_0')}', 'bg-warning', '{$CHECKSS}')">
                                            <i class="fa fa-clock-o me-2"></i> {$LANG->getModule('status_0')}
                                        </a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item py-2 text-danger" href="javascript:void(0)" onclick="changePopupStatus({$row.id}, 2, '{$LANG->getModule('status_2')}', 'bg-danger', '{$CHECKSS}')">
                                            <i class="fa fa-ban me-2"></i> {$LANG->getModule('status_2')}
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </td>
                        <td>
                            <div class="d-flex align-items-center gap-3">
                                <span title="{$LANG->getModule('total_view')}" class="{if $row.total_view > 0}text-primary{else}text-muted{/if}">
                                    <i class="fa fa-eye"></i> {$row.total_view}
                                </span>                                
                                <span title="{$LANG->getModule('total_click')}" class="{if $row.total_click > 0}text-success{else}text-muted{/if}">
                                    <i class="fa fa-hand-pointer-o"></i> {$row.total_click}
                                </span>
                                <span title="{$LANG->getModule('total_closed')}" class="{if $row.total_closed > 0}text-danger{else}text-muted{/if}">
                                    <i class="fa fa-window-close-o"></i> {$row.total_closed}
                                </span>
                            </div>
                        </td>
                        <td>
                            <div class="d-flex gap-1">
                                <a href="{$row.link_preview}" title="{$LANG->getModule('preview_popup')}" class="btn btn-outline-primary btn-xs me-1"><em class="fa fa-eye fa-xs"></em></a>
                                <a href="{$row.link_edit}" title="{$LANG->getModule('edit')}" class="btn btn-outline-success btn-xs me-1"><em class="fa fa-edit fa-xs"></em></a>
                                {if $ADMIN_LEV <= 2}
                                <button type="button" title="{$LANG->getModule('delete')}" class="btn btn-danger btn-xs delete_popup" data-checkss="{$CHECKSS}" data-id={$row.id}><em class="fa fa-trash-o fa-xs"></em></button>
                                {/if}
                            </div>
                        </td>
                    </tr>
                    {/foreach}
                </tbody>
            </table>
        </div>
    </div>
    <div class="card-footer border-top">
        <div class="d-flex flex-wrap justify-content-between align-items-center">
            <div class="d-flex flex-wrap flex-sm-nowrap align-items-center">
                <div class="me-2">
                    <input type="checkbox" data-toggle="checkAll" name="checkAll[]" class="form-check-input m-0 align-middle" aria-label="{$LANG->getGlobal('toggle_checkall')}">
                </div>
                <div class="input-group me-1 my-1">
                    <select id="element_action" class="form-select fw-150" aria-label="{$LANG->getGlobal('select_actions')}" aria-describedby="element_action_btn">
                        {foreach from=$ACTIONS key=action item=title}
                        <option value="{$action}">{$title}</option>
                        {/foreach}
                    </select>
                    <button class="btn btn-primary" type="button" id="element_action_btn" data-toggle="actionArticle" data-checksess="{$CHECKSS}" data-ctn="#list-news-items">{$LANG->getModule('action')}</button>
                </div>
            </div>
            {if not empty($GENERATE_PAGE)}
            <div class="pagination-wrap">
                {$GENERATE_PAGE}
            </div>
            {/if}
        </div>
    </div>
</div>
