<script src="{$smarty.const.ASSETS_STATIC_URL}/js/flatpickr/flatpickr.min.js"></script>
<script src="{$smarty.const.ASSETS_STATIC_URL}/js/language/flatpickr-{$smarty.const.NV_LANG_INTERFACE}.js"></script>
<div class="card">
    <div class="card-header">
        <form action="" method="get" id="form_search_popup">
            <div class="row mb-3 g-2">
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
                    <select class="form-control" name="display_object" data-default="0" aria-label="{$LANG->getModule('search_by')}">
                        {foreach from=$OBJECT key=key item=row}
                        <option value="{$key}" {if $key == $SEARCH.display_object} selected="selected" {/if}>{$row}</option>
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
                    <button class="btn btn-info">Tìm kiếm</button>
                    <input class="btn btn-default" id="btn_reset_form_search" type="button" value="{$LANG->getModule('reset')}">
                </div>
            </div>
        </form>
    </div>
    <div class="card-body popup-stats-wrapper d-flex flex-wrap gap-3 p-4">    
        <div class="popup-stat-card bg-success-subtle border-success-subtle text-success">
            <div class="stat-content">
                <div class="stat-label text-secondary small">{$LANG->getModule('total_view')}</div>
                <div class="stat-number">{$STATICS.total_view}</div>
            </div>
            <i class="fa fa-eye"></i>
        </div>
        <div class="popup-stat-card bg-primary-subtle border-primary-subtle text-primary">
            <div class="stat-content">
                <div class="stat-label text-secondary small">{$LANG->getModule('total_click')}</div>
                <div class="stat-number">{$STATICS.total_click}</div>
            </div>
            <i class="fa fa-hand-pointer-o"></i>
        </div>
        <div class="popup-stat-card bg-warning-subtle border-warning-subtle text-warning-emphasis">
            <div class="stat-content">
                <div class="stat-label text-secondary small">{$LANG->getModule('total_closed')}</div>
                <div class="stat-number">{$STATICS.total_closed}</div>
            </div>
            <i class="fa fa-times-circle"></i>
        </div>
        <div class="popup-stat-card bg-info-subtle border-info-subtle text-info-emphasis">
            <div class="stat-content">
                <div class="stat-label text-secondary small">{$LANG->getModule('ctr_click_view')}</div>
                <div class="stat-number">{$STATICS.ctr_click_view}</div>
            </div>
            <i class="fa fa-pie-chart"></i>
        </div>
        <div class="popup-stat-card bg-danger-subtle border-danger-subtle text-danger">
            <div class="stat-content">
                <div class="stat-label text-secondary small">{$LANG->getModule('ctr_closed_view')}</div>
                <div class="stat-number">{$STATICS.ctr_closed_view}</div>
            </div>
            <i class="fa fa-percent"></i>
        </div>
    </div>

    <div class="card-body">
        <div class="table-responsive-lg table-card pb-1">
            <table class="table table-striped align-middle table-sticky mb-0">
                <colgroup>
                    <col style="width: 5%;">
                    <col style="width: 20%;">
                    <col style="width: 10%;">
                    <col style="width: 10%;">
                    <col style="width: 13%;">
                    <col style="width: 15%;">
                    <col style="width: 14%;">
                </colgroup>
                <thead class="tableFloatingHeaderOriginal">
                    <tr>
                        <th class="text-nowrap">{$LANG->getModule('stt')}</th>
                        <th class="text-nowrap">{$LANG->getModule('title')}</th>
                        <th class="text-nowrap">{$LANG->getModule('total_view')}</th>
                        <th class="text-nowrap">{$LANG->getModule('total_click')}</th>
                        <th class="text-nowrap">{$LANG->getModule('ctr_click_view')}</th>
                        <th class="text-nowrap">{$LANG->getModule('total_closed')}</th>
                        <th class="text-nowrap">{$LANG->getModule('ctr_closed_view')}</th>
                    </tr>
                </thead>
                <tbody>
                    {foreach from=$DATA item=row}
                    <tr>
                        <td>{$row.stt}</td>            
                        <td><a href="{$row.link}">{$row.title|escape:'html'}</a></td>
                        <td>{$row.total_view}</td>
                        <td>{$row.total_click}</td>
                        <td>{$row.ctr_click_view}</td>
                        <td>{$row.total_closed}</td>
                        <td>{$row.ctr_closed_view}</td>
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
    </div>
</div>
