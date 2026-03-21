<div class="pull-right">
    {if $DETAIL.status == 1}
    <a href="javascript:void(0);" onclick="nv_chang_status({$DETAIL.id})" class="btn btn-danger btn-sm"><em class="fa fa-ban fa-sm">&nbsp;</em> {$LANG->getModule('unlock')}</a>
    {elseif $DETAIL.status == 3}
    <a href="javascript:void(0);" onclick="nv_chang_status({$DETAIL.id})" class="btn btn-success btn-sm"><em class="fa fa-check fa-sm">&nbsp;</em> {$LANG->getModule('active')}</a>
    {/if}
    <a href="{$DATA.link_edit}" target="_blank" class="btn btn-success btn-sm"><em class="fa fa-edit fa-sm">&nbsp;</em> {$LANG->getModule('edit')}</a>
    <a href="{$DATA.link_preview}" target="_blank" class="btn btn-primary btn-sm"><em class="fa fa-eye fa-sm">&nbsp;</em> {$LANG->getModule('preview_popup')}</a>
</div>
<div class="clearfix"></div>
<div class="table-responsive">
    <table class="table table-striped table-bordered table-hover">
        <caption>
            <em class="fa fa-file-text-o">&nbsp;</em>{$DETAIL.title}
        </caption>
        <tbody>
            {foreach $DATA.data as $item}
            <tr>
                <td>{$item.0}</td>
                <td>{$item.1}</td>
            </tr>
            {/foreach}
        </tbody>
    </table>
</div>
<script type="text/javascript">
    function nv_chang_status(id) {
        var checkss = '{$CHECKSS}';
        if (confirm(nv_is_change_act_confirm[0])) {
            $(this).prop('disabled', true);
            $.post(script_name + '?' + nv_lang_variable + '=' + nv_lang_data + '&' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=' + nv_func_name + '&nocache=' + new Date().getTime()+ '&change_status=1&id=' + id + '&checkss=' + checkss, function(res) {
                var r_split = res.split("|");
                if (r_split[0] != 'OK') {
                    alert(nv_is_change_act_confirm[2]);
                } else {
                    window.location.href = window.location.href;
                }
            });
        }
    }
</script>
