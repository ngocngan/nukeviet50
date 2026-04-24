<div class="d-flex pull-right gap-2">
    <div class="dropdown" id="status-container-{$DETAIL.id}">
        <span class="btn btn-sm btn-status label-{$DETAIL.label_status} badge-status-{$DETAIL.id} dropdown-toggle pointer" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            {$DETAIL.status_txt} <i class="fa fa-angle-down ml-1"></i>
        </span>
        <div class="dropdown-menu shadow border-0 py-2 list-group list-group-flush status-select-menu">
            <a href="javascript:void(0)" onclick="changePopupStatus({$DETAIL.id}, 1, '{$LANG->getModule('status_1')}', 'label-success', '{$CHECKSS}')" class="list-group-item list-group-item-action py-2 text-success">
                <i class="fa fa-check-circle mr-2"></i> {$LANG->getModule('status_1')}
            </a>
            <a href="javascript:void(0)" onclick="changePopupStatus({$DETAIL.id}, 0, '{$LANG->getModule('status_0')}', 'label-warning text-dark', '{$CHECKSS}')" class="list-group-item list-group-item-action py-2 text-warning">
                <i class="fa fa-clock-o mr-2"></i> {$LANG->getModule('status_0')}
            </a>
            <a href="javascript:void(0)" onclick="changePopupStatus({$DETAIL.id}, 2, '{$LANG->getModule('status_2')}', 'label-danger', '{$CHECKSS}')" class="list-group-item list-group-item-action py-2 text-danger">
                <i class="fa fa-ban mr-2"></i> {$LANG->getModule('status_2')}
            </a>
        </div>
    </div>
    <a href="{$DATA.link_edit}" target="_blank" class="btn btn-success btn-sm"><em class="fa fa-edit fa-sm">&nbsp;</em> {$LANG->getModule('edit')}</a>
    <a href="{$DATA.link_preview}" target="_blank" class="btn btn-primary btn-sm"><em class="fa fa-eye fa-sm">&nbsp;</em> {$LANG->getModule('preview_popup')}</a>
</div>
<div class="clearfix"></div>
<div class="table-responsive">
    <table class="table table-striped table-bordered table-hover">
        <colgroup><col class="w300">
        <col>
        <caption>
            <em class="fa fa-file-text-o">&nbsp;</em>{$DETAIL.title}
        </caption>
        <tbody>
            {foreach $DATA.data as $item}
            <tr>
                <td>{$item.0}</td>
                <td>
                    {if $item.0 == "{$LANG->getModule('status')}"}
                        <span class="badge-status-{$DETAIL.id} label label-{$DETAIL.label_status}">
                            {$item.1}
                        </span>
                    {else}
                        {$item.1}
                    {/if}
                </td>
            </tr>
            {/foreach}
        </tbody>
    </table>
</div>
