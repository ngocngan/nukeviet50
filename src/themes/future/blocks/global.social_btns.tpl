<ul class="socal-icons list-unstyled d-flex align-items-center gap-2 mb-0">
    {foreach from=$SOCIALS item=icon}
    <li>
        <a href="{$icon.url}" title="{$icon.name}" aria-label="{$icon.name}" style="--hover-color:#{$icon.color}"><i class="{$icon.icon}"></i></a>
    </li>
    {/foreach}
</ul>
