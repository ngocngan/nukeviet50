<script src="{$smarty.const.ASSETS_STATIC_URL}/js/flatpickr/flatpickr.min.js"></script>
<script src="{$smarty.const.ASSETS_STATIC_URL}/js/language/flatpickr-{$smarty.const.NV_LANG_INTERFACE}.js"></script>
<div class="popup-detail-wrapper card-popup-content p-2 p-md-4">
    <div class="card border-0 shadow-sm rounded-4 bg-white overflow-hidden">        
        <div class="card-header bg-white py-3 px-3 px-md-4 d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3 border-bottom border-light">
            <div>
                <h1 class="h5 fw-bold mb-0 text-dark">{$DETAIL.title}</h1>
                <small class="text-muted">ID: #{$DETAIL.id}</small>
            </div>
            <div class="d-flex flex-wrap align-items-center gap-2">
                <div class="dropdown" id="status-container-{$DETAIL.id}">
                    <a href="javascript:void(0)" 
                        class="badge-status-{$DETAIL.id} badge d-flex align-items-center gap-2 px-3 py-2 text-decoration-none rounded-pill shadow-sm border border-opacity-25 dropdown-toggle fs-6
                        {if $DETAIL.status == 1}bg-success-subtle text-success border-success{elseif $DETAIL.status == 0}bg-warning-subtle text-warning border-warning{else}bg-danger-subtle text-danger border-danger{/if}" 
                        data-bs-toggle="dropdown" 
                        aria-expanded="false"
                        id="badge-status-{$DETAIL.id}">                        
                        <span class="fw-bold">{$DETAIL.status_txt}</span>
                    </a>                    
                    <ul class="dropdown-menu dropdown-menu-end shadow-lg border-0 rounded-3 mt-2 py-1">
                        <li>
                            <a class="dropdown-item py-2 d-flex align-items-center text-success" href="javascript:void(0)" onclick="changePopupStatus({$DETAIL.id}, 1, '{$LANG->getModule('status_1')}', 'bg-success-subtle text-success border-success', '{$CHECKSS}')">
                                <i class="fa fa-check-circle-o me-2 fs-5"></i> 
                                <span class="fw-bold">{$LANG->getModule('status_1')}</span>
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item py-2 d-flex align-items-center text-warning" href="javascript:void(0)" onclick="changePopupStatus({$DETAIL.id}, 0, '{$LANG->getModule('status_0')}', 'bg-warning-subtle text-warning border-warning', '{$CHECKSS}')">
                                <i class="fa fa-clock-o me-2 fs-5"></i> 
                                <span class="fw-bold">{$LANG->getModule('status_0')}</span>
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item py-2 d-flex align-items-center text-danger" href="javascript:void(0)" onclick="changePopupStatus({$DETAIL.id}, 2, '{$LANG->getModule('status_2')}', 'bg-danger-subtle text-danger border-danger', '{$CHECKSS}')">
                                <i class="fa fa-times-circle-o me-2 fs-5"></i> 
                                <span class="fw-bold">{$LANG->getModule('status_2')}</span>
                            </a>
                        </li>
                    </ul>
                </div>
                <a href="{$DATA.link_preview}" target="_blank" class="btn bg-primary-subtle text-primary border-0 px-3 fw-bold shadow-none rounded-3">
                    <i class="fa fa-eye fs-6"></i> <span class="d-none d-sm-inline ms-1">{$LANG->getModule('preview_popup')}</span>
                </a>
                <a href="{$DATA.link_edit}" class="btn btn-primary px-3 shadow-sm fw-bold rounded-3 border-0">
                    <i class="fa fa-edit fs-6"></i> <span class="d-none d-sm-inline ms-1">{$LANG->getModule('edit')}</span>
                </a>
            </div>
        </div>
        <div class="card-body p-3 p-md-4">
            <div class="row g-3 g-md-4">
                {foreach from=$DATA.data item=item}
                <div class="col-12 col-md-6">
                    <div class="info-row d-flex align-items-start">
                        <div class="info-label text-muted col-4 col-sm-3 col-md-5 col-lg-4">
                            {$item.0}
                        </div>
                        <div class="info-value text-dark ps-4 border-start border-2">
                            {if $item.0 == "{$LANG->getModule('status')}"}
                                <span class="badge-status-{$DETAIL.id} rounded-pill 
                                    {if $DETAIL.status == 1}bg-success-subtle text-success
                                    {else if $DETAIL.status == 2}bg-danger-subtle text-danger
                                    {else}bg-warning-subtle text-warning{/if} 
                                    px-3 py-1 border border-opacity-10">
                                    {$item.1}
                                </span>
                            {else}
                                <span class="fw-medium text-break">{$item.1}</span>
                            {/if}
                        </div>
                    </div>
                </div>
                {/foreach}
            </div>
        </div>
    </div>
</div>
