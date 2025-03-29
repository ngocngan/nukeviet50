{if not $HOME}
<h1 class="visually-hidden">{$PAGE_TITLE}</h1>
{/if}
<div class="vstack gap-3">
    {foreach from=$ARRAY_CATS item=datacat}
    {if isset($datacat.content)}
    <div class="catbox">
        <div class="catbox-header mb-3 d-flex border-bottom border-4 border-primary align-items-center">
            <a href="{$datacat.link}" class="text-bg-primary px-2 py-1">{$datacat.title}</a>
            {if $datacat.numsubcat gt 0}
            <ul class="list-inline mb-0 ms-auto">
                {assign var="stt" value=0}
                {foreach from=$datacat.subcats item=subcat}
                {assign var="stt" value=($stt+1)}
                {if $stt lte 3}
                <li class="list-inline-item">
                    <a href="{$subcat.link}" class="link-body-emphasis">{$subcat.title}</a>
                </li>
                {/if}
                {/foreach}
                {if $datacat.numsubcat gt 3}
                <li class="list-inline-item">
                    <a href="{$datacat.link}" class="link-body-emphasis" aria-label="{$LANG->getModule('more')}" title="{$LANG->getModule('more')}">
                        <i class="fa-solid fa-right-from-bracket"></i>
                    </a>
                </li>
                {/if}
            </ul>
            {/if}
        </div>
        <div class="catbox-contents">
            {assign var="numitems" value=count($datacat.content)}
            {if $numitems gt 1}
            {* Có 1 tin mới + tin bên phải (end) *}
            <div class="row">
                <div class="col-lg-6">
                    {* Tin mới nhất *}
                    {assign var="row" value=$datacat.content[0]}
                    {if not empty($row.imghome)}
                    <div class="mb-2">
                        <a href="{$row.link}"{if $row.external_link} target="_blank"{/if} class="thumbnail-lg" style="--nv-aspect-ratio: {$IMGRATIO}%;">
                            <span><img src="{$row.imghome}" alt="{$row.homeimgalt ?: $row.title}"></span>
                        </a>
                    </div>
                    {/if}
                    <ul class="list-inline small mb-1 text-muted">
                        <li class="list-inline-item"><i class="fa-regular fa-clock"></i> {$row.publtime|ddatetime}</li>
                        <li class="list-inline-item"><i class="fa-regular fa-eye"></i> {$row.hitstotal|dnumber}</li>
                        {if $COMMENT_ENABLED}
                        <li class="list-inline-item"><i class="fa-regular fa-comment"></i> {$row.hitscm|dnumber}</li>
                        {/if}
                    </ul>
                    <div class="fs-5 fw-medium mb-1">
                        <a class="link-body-emphasis" href="{$row.link}"{if $row.external_link} target="_blank"{/if}>{$row.title}</a>
                        {assign var="newday" value=(($row.newday * 86400) + $row.publtime)}
                        {if $newday gte $smarty.now}
                        <span class="badge text-bg-danger badge-new">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" viewBox="0 0 16 16">
                                <path d="M7.657 6.247c.11-.33.576-.33.686 0l.645 1.937a2.89 2.89 0 0 0 1.829 1.828l1.936.645c.33.11.33.576 0 .686l-1.937.645a2.89 2.89 0 0 0-1.828 1.829l-.645 1.936a.361.361 0 0 1-.686 0l-.645-1.937a2.89 2.89 0 0 0-1.828-1.828l-1.937-.645a.361.361 0 0 1 0-.686l1.937-.645a2.89 2.89 0 0 0 1.828-1.828zM3.794 1.148a.217.217 0 0 1 .412 0l.387 1.162c.173.518.579.924 1.097 1.097l1.162.387a.217.217 0 0 1 0 .412l-1.162.387A1.73 1.73 0 0 0 4.593 5.69l-.387 1.162a.217.217 0 0 1-.412 0L3.407 5.69A1.73 1.73 0 0 0 2.31 4.593l-1.162-.387a.217.217 0 0 1 0-.412l1.162-.387A1.73 1.73 0 0 0 3.407 2.31zM10.863.099a.145.145 0 0 1 .274 0l.258.774c.115.346.386.617.732.732l.774.258a.145.145 0 0 1 0 .274l-.774.258a1.16 1.16 0 0 0-.732.732l-.258.774a.145.145 0 0 1-.274 0l-.258-.774a1.16 1.16 0 0 0-.732-.732L9.1 2.137a.145.145 0 0 1 0-.274l.774-.258c.346-.115.617-.386.732-.732z"/>
                            </svg> {$LANG->getModule('newpost')}
                        </span>
                        {/if}
                    </div>
                    <div class="text-truncate-3">
                        {$row.hometext}
                    </div>
                </div>
                <div class="col-lg-6">
                    {* Các tin khác *}
                    <ul class="list-unstyled vstack gap-3 mb-0">
                        {assign var="stt" value=0}
                        {foreach from=$datacat.content item=row}
                        {if $stt gt 0}
                            <li>
                                <article class="row">
                                    {if not empty($row.imghome)}
                                    <div class="col-12 col-sm-4 col-lg-5">
                                        <a href="{$row.link}"{if $row.external_link} target="_blank"{/if} class="thumbnail-lg" style="--nv-aspect-ratio: {$IMGRATIO}%;">
                                            <span><img src="{$row.imghome}" alt="{$row.homeimgalt ?: $row.title}"></span>
                                        </a>
                                    </div>
                                    {/if}
                                    <div class="col-12{if not empty($row.imghome)} col-sm-8 col-lg-7{/if}">
                                        <ul class="list-inline small mb-2 text-muted lh-sm">
                                            <li class="list-inline-item"><i class="fa-regular fa-clock"></i> {$row.publtime|ddatetime}</li>
                                            <li class="list-inline-item"><i class="fa-regular fa-eye"></i> {$row.hitstotal|dnumber}</li>
                                            {if $COMMENT_ENABLED}
                                            <li class="list-inline-item"><i class="fa-regular fa-comment"></i> {$row.hitscm|dnumber}</li>
                                            {/if}
                                        </ul>
                                        <div class="fw-medium mb-1 lh-sm">
                                            <a class="link-body-emphasis" href="{$row.link}"{if $row.external_link} target="_blank"{/if}>{$row.title}</a>
                                            {assign var="newday" value=(($row.newday * 86400) + $row.publtime)}
                                            {if $newday gte $smarty.now}
                                            <span class="badge text-bg-danger badge-new">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" viewBox="0 0 16 16">
                                                    <path d="M7.657 6.247c.11-.33.576-.33.686 0l.645 1.937a2.89 2.89 0 0 0 1.829 1.828l1.936.645c.33.11.33.576 0 .686l-1.937.645a2.89 2.89 0 0 0-1.828 1.829l-.645 1.936a.361.361 0 0 1-.686 0l-.645-1.937a2.89 2.89 0 0 0-1.828-1.828l-1.937-.645a.361.361 0 0 1 0-.686l1.937-.645a2.89 2.89 0 0 0 1.828-1.828zM3.794 1.148a.217.217 0 0 1 .412 0l.387 1.162c.173.518.579.924 1.097 1.097l1.162.387a.217.217 0 0 1 0 .412l-1.162.387A1.73 1.73 0 0 0 4.593 5.69l-.387 1.162a.217.217 0 0 1-.412 0L3.407 5.69A1.73 1.73 0 0 0 2.31 4.593l-1.162-.387a.217.217 0 0 1 0-.412l1.162-.387A1.73 1.73 0 0 0 3.407 2.31zM10.863.099a.145.145 0 0 1 .274 0l.258.774c.115.346.386.617.732.732l.774.258a.145.145 0 0 1 0 .274l-.774.258a1.16 1.16 0 0 0-.732.732l-.258.774a.145.145 0 0 1-.274 0l-.258-.774a1.16 1.16 0 0 0-.732-.732L9.1 2.137a.145.145 0 0 1 0-.274l.774-.258c.346-.115.617-.386.732-.732z"/>
                                                </svg> {$LANG->getModule('newpost')}
                                            </span>
                                            {/if}
                                        </div>
                                    </div>
                                </article>
                            </li>
                        {/if}
                        {assign var="stt" value=($stt+1)}
                        {/foreach}
                    </ul>
                </div>
            </div>
            {else}
            {* Chỉ có 1 tin mới *}
            {foreach from=$datacat.content item=row}
            <div class="row">
                {if not empty($row.imghome)}
                <div class="col-12 col-sm-4 col-lg-6">
                    <a href="{$row.link}"{if $row.external_link} target="_blank"{/if} class="thumbnail-lg" style="--nv-aspect-ratio: {$IMGRATIO}%;">
                        <span><img src="{$row.imghome}" alt="{$row.homeimgalt ?: $row.title}"></span>
                    </a>
                </div>
                {/if}
                <div class="col-12{if not empty($row.imghome)} col-sm-8 col-lg-6{/if}">
                    <div class="fs-5 fw-medium mb-1">
                        <a class="link-body-emphasis" href="{$row.link}"{if $row.external_link} target="_blank"{/if}>{$row.title}</a>
                        {assign var="newday" value=(($row.newday * 86400) + $row.publtime)}
                        {if $newday gte $smarty.now}
                        <span class="badge text-bg-danger badge-new">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" viewBox="0 0 16 16">
                                <path d="M7.657 6.247c.11-.33.576-.33.686 0l.645 1.937a2.89 2.89 0 0 0 1.829 1.828l1.936.645c.33.11.33.576 0 .686l-1.937.645a2.89 2.89 0 0 0-1.828 1.829l-.645 1.936a.361.361 0 0 1-.686 0l-.645-1.937a2.89 2.89 0 0 0-1.828-1.828l-1.937-.645a.361.361 0 0 1 0-.686l1.937-.645a2.89 2.89 0 0 0 1.828-1.828zM3.794 1.148a.217.217 0 0 1 .412 0l.387 1.162c.173.518.579.924 1.097 1.097l1.162.387a.217.217 0 0 1 0 .412l-1.162.387A1.73 1.73 0 0 0 4.593 5.69l-.387 1.162a.217.217 0 0 1-.412 0L3.407 5.69A1.73 1.73 0 0 0 2.31 4.593l-1.162-.387a.217.217 0 0 1 0-.412l1.162-.387A1.73 1.73 0 0 0 3.407 2.31zM10.863.099a.145.145 0 0 1 .274 0l.258.774c.115.346.386.617.732.732l.774.258a.145.145 0 0 1 0 .274l-.774.258a1.16 1.16 0 0 0-.732.732l-.258.774a.145.145 0 0 1-.274 0l-.258-.774a1.16 1.16 0 0 0-.732-.732L9.1 2.137a.145.145 0 0 1 0-.274l.774-.258c.346-.115.617-.386.732-.732z"/>
                            </svg> {$LANG->getModule('newpost')}
                        </span>
                        {/if}
                    </div>
                    <ul class="list-inline small mb-1 text-muted">
                        <li class="list-inline-item"><i class="fa-regular fa-clock"></i> {$row.publtime|ddatetime}</li>
                        <li class="list-inline-item"><i class="fa-regular fa-eye"></i> {$row.hitstotal|dnumber}</li>
                        {if $COMMENT_ENABLED}
                        <li class="list-inline-item"><i class="fa-regular fa-comment"></i> {$row.hitscm|dnumber}</li>
                        {/if}
                    </ul>
                    <div class="text-truncate-3">
                        {$row.hometext}
                    </div>
                </div>
            </div>
            {/foreach}
            {/if}
        </div>
    </div>
    {/if}
    {/foreach}
</div>
