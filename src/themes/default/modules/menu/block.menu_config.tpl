<div class="row mb-3">
    <label class="col-sm-3 col-form-label text-sm-end text-truncate fw-medium">{$LANG->getModule('menu')}:</label>
    <div class="col-sm-5">
        <select name="menuid" class="form-select">
            {foreach from=$MENUS item=menu}
            <option value="{$menu.id}" {if $DATA.menuid eq $menu.id}selected{/if}>{$menu.title}</option>
            {/foreach}
        </select>
    </div>
</div>
<div class="row mb-3">
    <label class="col-sm-3 col-form-label text-sm-end text-truncate fw-medium">{$LANG->getModule('title_length')}:</label>
    <div class="col-sm-9">
        <input type="text" class="form-control" name="config_title_length" value="{$DATA.title_length}">
        <div class="form-text">{$LANG->getModule('title_length_note')}</div>
    </div>
</div>
