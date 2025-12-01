<h1>
    {$DATA.title}
    {if $smarty.const.NV_IS_MODADMIN}
    <span class="dropdown fs-6">
        <a class="link-secondary" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            <i class="fa-solid fa-screwdriver-wrench"></i> <span class="visually-hidden">{$LANG->getModule('admtools')}</span>
        </a>
        <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="{$smarty.const.NV_BASE_ADMINURL}index.php?{$smarty.const.NV_LANG_VARIABLE}={$smarty.const.NV_LANG_DATA}&amp;{$smarty.const.NV_NAME_VARIABLE}={$MODULE_NAME}&amp;{$smarty.const.NV_OP_VARIABLE}=content&amp;id={$DATA.id}"><i class="fa-solid fa-pencil fa-fw text-center"></i> {$LANG->getGlobal('edit')}</a></li>
            <li><a class="dropdown-item" href="#" data-toggle="nv_del_content" data-id="{$DATA.id}" data-checkss="{$DATA.admin_checkss}" data-adminurl="{$smarty.const.NV_BASE_ADMINURL}" data-detail="true"><i class="fa-solid fa-trash fa-fw text-center text-danger" data-icon="fa-trash"></i> {$LANG->getGlobal('delete')}</a></li>
        </ul>
    </span>
    {/if}
</h1>
{if $smarty.const.NV_IS_MODADMIN and empty($DATA.status)}
<div class="alert alert-warning" role="alert"><i class="fa-solid fa-triangle-exclamation"></i> {$LANG->getModule('warning')}</div>
{/if}
{if not empty($OTHERS)}
{* Danh sách các bài khác *}
<hr>
<ul>
    <li>sdsd</li>
</ul>
{/if}









{*
<!-- BEGIN: main -->

<div class="page panel panel-default">
    <div class="panel-body">
        <h1 class="title margin-bottom-lg">{CONTENT.title}</h1>
        <!-- BEGIN: socialbutton -->
        <div class="margin-bottom">
            <div style="display:flex;align-items:flex-start;">
                <!-- BEGIN: facebook --><div class="margin-right"><div class="fb-like" style="float:left!important;margin-right:0!important" data-href="{CONTENT.link}" data-layout="button_count" data-action="like" data-show-faces="false" data-share="true"></div></div><!-- END: facebook -->
                <!-- BEGIN: twitter --><div class="margin-right"><a href="http://twitter.com/share" class="twitter-share-button">Tweet</a></div><!-- END: twitter -->
                <!-- BEGIN: zalo --><div><div class="zalo-share-button" data-href="" data-oaid="{ZALO_OAID}" data-layout="1" data-color="blue" data-customize=false></div></div><!-- END: zalo -->
            </div>
        </div>
        <!-- END: socialbutton -->

        <!-- BEGIN: imageleft -->
        <figure class="article left pointer" data-toggle="modalShowByObj" data-obj="#imgpreview">
            <div style="width:{CONTENT.thumb.width}px;">
                <img alt="{CONTENT.title}" src="{CONTENT.thumb.src}" class="img-thumbnail" />
                <!-- BEGIN: alt --><figcaption>{CONTENT.imagealt}</figcaption><!-- END: alt -->
            </div>
        </figure>
        <div id="imgpreview" style="display:none">
            <p class="text-center"><img alt="{CONTENT.title}" src="{CONTENT.img.src}" srcset="{CONTENT.img.srcset}" class="img-thumbnail"/></p>
        </div>
        <!-- END: imageleft -->

        <!-- BEGIN: description -->
        <div class="hometext margin-bottom-lg">{CONTENT.description}</div>
        <!-- END: description -->

        <!-- BEGIN: imagecenter -->
        <figure class="article center pointer" data-toggle="modalShowByObj">
            <p class="text-center"><img alt="{CONTENT.title}" src="{CONTENT.img.src}" srcset="{CONTENT.img.srcset}" width="{CONTENT.img.width}" class="img-thumbnail" /></p>
            <!-- BEGIN: alt --><figcaption>{CONTENT.imagealt}</figcaption><!-- END: alt -->
        </figure>
        <!-- END: imagecenter -->

        <div class="clear"></div>

        <div id="page-bodyhtml" class="bodytext margin-bottom-lg">
            {CONTENT.bodytext}
        </div>
    </div>
</div>
<!-- BEGIN: comment -->
<div class="page panel panel-default">
    <div class="panel-body">
    {CONTENT_COMMENT}
    </div>
</div>
<!-- END: comment -->
<!-- BEGIN: other -->
<div class="page panel panel-default">
    <div class="panel-body">
        <ul class="nv-list-item">
            <!-- BEGIN: loop -->
            <li><em class="fa fa-angle-double-right">&nbsp;</em><h3><a title="{OTHER.title}" href="{OTHER.link}">{OTHER.title}</a></h3></li>
            <!-- END: loop -->
       </ul>
    </div>
</div>
<!-- END: other -->
<!-- END: main -->
*}
