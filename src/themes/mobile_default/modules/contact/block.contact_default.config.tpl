<div class="row mb-3">
    <label for="config_departmentid" class="col-sm-3 col-form-label text-sm-end text-truncate fw-medium">{$LANG->getModule('pick_department')}:</label>
    <div class="col-sm-5">
        <select name="config_departmentid" id="config_departmentid" class="form-select">
            {foreach from=$DEPARTMENTS item=department}
            <option value="{$department.id}"{if $department.id eq $CONFIG.departmentid} selected{/if}>{$department.full_name}</option>
            {/foreach}
        </select>
    </div>
</div>
<div class="row mb-3">
    <div class="col-sm-3 col-form-label text-sm-end text-truncate fw-medium pt-0">{$LANG->getModule('properties_show')}:</div>
    <div class="col-sm-8">
        {foreach from=$SHOWS key=key item=title}
        <div class="form-check">
            <input class="form-check-input" type="checkbox" name="config_shows[]" value="{$key}" id="config_show_{$key}"{if in_array($key, $CONFIG.shows)} checked{/if}>
            <label class="form-check-label" for="config_show_{$key}">
                {$title}
            </label>
        </div>
        {/foreach}
    </div>
</div>
<div class="row mb-3">
    <label for="config_other_limit" class="col-sm-3 col-form-label text-sm-end text-truncate fw-medium">{$LANG->getModule('number_others')}:</label>
    <div class="col-sm-9">
        <input type="number" min="0" name="config_other_limit" id="config_other_limit" class="form-control w-auto mw-100" value="{$CONFIG.other_limit}">
        <div class="form-text">{$LANG->getModule('number_others_help')}</div>
    </div>
</div>
<div class="row mb-3">
    <div class="col-sm-9 offset-sm-3">
        <div class="form-check form-switch">
            <input class="form-check-input" type="checkbox" role="switch" id="config_show_clock" name="config_show_clock" value="1"{if $CONFIG.show_clock} checked{/if}>
            <label class="form-check-label" for="config_show_clock">{$LANG->getModule('show_clock')}</label>
        </div>
    </div>
</div>
