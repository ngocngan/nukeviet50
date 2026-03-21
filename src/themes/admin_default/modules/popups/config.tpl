<form action="" method="post">
    <div class="table-responsive">
        <table class="table table-striped table-bordered table-hover">
            <tbody>
                <tr>
                    <td>{$LANG->getModule('display_layout')}</td>
                    <td>
                        <select class="form-control select2-hidden-accessible" name="display_layout" data-select2-id="select2-data-1-e4j4" tabindex="-1" aria-hidden="true">
                            {foreach from=$DISPLAY_LAYOUT key=key item=row}
                            <option value="{$key}" {if $key == $DATA.display_layout} selected="selected"{/if}>{$row}</option>
                            {/foreach}
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>{$LANG->getModule('popup_delay')}</td>
                    <td>
                        <input type="number" value="{$DATA.popup_delay}" class="form-control" id="popup_delay" name="popup_delay">
                    </td>
                </tr>
                <tr>
                    <td>{$LANG->getModule('display_frequency')}</td>
                    <td>
                        <input type="number" value="{$DATA.display_frequency}" class="form-control" id="display_frequency" name="display_frequency"><br><span>Số ngày giữa hai lần hiển thị popup đối với cùng một người dùng</span>
                    </td>
                </tr>
                <tr>
                    <td>{$LANG->getModule('display_object')}</td>
                    <td>
                        <select name="display_object" class="form-control w300 valid" aria-invalid="false">
                            {foreach from=$DISPLAY_OBJECT key=key item=row}
                            <option value="{$key}" {if $key == $DATA.display_object} selected="selected"{/if}>{$row}</option>
                            {/foreach}
                        </select>
                    </td>
                </tr>
                
                <tr>
                    <td>{$LANG->getModule('display_device')}</td>
                    <td>
                        <select name="display_device" class="form-control w300 valid" aria-invalid="false">
                            {foreach from=$DISPLAY_DEVICE key=key item=row}
                                <option value="{$key}" {if $key  == $DATA.display_device} selected="selected"{/if}>{$row}</option>
                            {/foreach}
                        </select>
                    </td>
                </tr><tr>
                    <td>{$LANG->getModule('close_on_outside_click')}</td>
                    <td><input type="checkbox" value="1" class="form-control" id="close_on_outside_click" name="close_on_outside_click" {$DATA.checked}></td>
                </tr>
            </tbody>
        </table>
        <div class="text-center"><input class="btn btn-primary" name="submit" type="submit" value="{$LANG->getModule('save')}"></div>
    </div>
</form>
