/**
 * NukeViet Content Management System
 * @version 4.x
 * @author VINADES.,JSC <contact@vinades.vn>
 * @copyright (C) 2009-2024 VINADES.,JSC. All rights reserved
 * @license GNU/GPL version 2 or any later version
 * @see https://github.com/nukeviet The NukeViet CMS GitHub project
 */

'use strict';

var nukeviet = nukeviet || {};
nukeviet.inform = {
    cookie: {
        name: nv_cookie_prefix + '_inft',
        count: nv_cookie_prefix + '_infc'
    },
    lastCount: 0,
    lastCheck: 0,
    refresh: 30000,
    timer: null,
    ps: null
};
nukeviet.inform.GetCount = () => {
    const currentTime = new Date().getTime();
    const elapsedTime = currentTime - nukeviet.inform.lastCheck;
    const ctn = $('#inform-notification');

    if (elapsedTime > nukeviet.inform.refresh) {
        nukeviet.inform.lastCheck = currentTime;
        nv_setCookie(nukeviet.inform.cookie.name, nukeviet.inform.lastCheck, 365);
        var url = ctn.data('checkinform-url') + ((-1 < ctn.data('checkinform-url').indexOf("?")) ? '&' : '?') + 'nocache=' + currentTime;
        $.ajax({
            type: 'POST',
            url: url,
            data: {
                __checkInform: 1,
                __userid: ctn.data('userid'),
                __groups: ctn.data('usergroups'),
                _csrf: ctn.data('csrf')
            },
            dataType: "json",
            success: function(data) {
                nukeviet.inform.lastCount = parseInt(data.count);
                nv_setCookie(nukeviet.inform.cookie.count, nukeviet.inform.lastCount, 365);
                $('[data-toggle="unreadCounter"]', ctn).text(nukeviet.inform.lastCount);
                if (nukeviet.inform.lastCount > 0) {
                    $('[data-toggle="unreadBadge"]', ctn).removeClass('d-none');
                } else {
                    $('[data-toggle="unreadBadge"]', ctn).addClass('d-none');
                }
            }
        });
        nukeviet.inform.RunCount(nukeviet.inform.refresh);
        return;
    }
    $('[data-toggle="unreadCounter"]', ctn).text(nukeviet.inform.lastCount);
    if (nukeviet.inform.lastCount > 0) {
        $('[data-toggle="unreadBadge"]', ctn).removeClass('d-none');
    } else {
        $('[data-toggle="unreadBadge"]', ctn).addClass('d-none');
    }
    nukeviet.inform.RunCount(nukeviet.inform.refresh - elapsedTime);
};
nukeviet.inform.RunCount = (delay) => {
    clearTimeout(nukeviet.inform.timer);
    nukeviet.inform.timer = setTimeout(() => {
        nukeviet.inform.GetCount();
    }, delay);
};
nukeviet.inform.GetList = () => {
    const ctn = $('#inform-notification');
    const loader = $('[data-toggle="loader"]', ctn);
    if (loader.is('.fa-spinner')) {
        return;
    }
    loader.removeClass(loader.data('icon')).addClass('fa-spinner fa-spin-pulse');

    let filter = $('input[name=aj_filter]', ctn).val();
    let query = ('' != filter && 'all' != filter) ? 'filter=' + filter + '&nocache=' : 'nocache=';
    let url = ctn.data('url') + ((-1 < ctn.data('url').indexOf("?")) ? '&' : '?') + query + new Date().getTime();

    $.ajax({
        type: 'GET',
        url: url,
        dataType: "json",
        success: function(result) {
            $('.inform-content', ctn).html(result.content);
            nukeviet.inform.ps.update();
            if (result.count) {
                nukeviet.inform.lastCount = 0;
                nv_setCookie(nukeviet.inform.cookie.count, nukeviet.inform.lastCount, 365);
                nukeviet.inform.GetCount();
            }
            loader.removeClass('fa-spinner fa-spin-pulse').addClass(loader.data('icon'));
        },
        error: function() {
            loader.removeClass('fa-spinner fa-spin-pulse').addClass(loader.data('icon'));
        }
    })
};

$(function() {
    const ctn = $('#inform-notification');

    // Đóng dropdown
    ctn.on('click', '[data-toggle="informClose"]', function(e) {
        e.preventDefault();
        bootstrap.Dropdown.getOrCreateInstance($('.dropdown-menu', ctn)[0]).toggle();
    });

    // Lấy danh sách thông báo
    $('.inform-toggle', ctn).on('show.bs.dropdown', function() {
        nukeviet.inform.GetList();
    });

    // Thanh cuộn
    nukeviet.inform.ps = new PerfectScrollbar($('.inform-content', ctn)[0], {
        wheelSpeed: 1,
        wheelPropagation: true,
        minScrollbarLength: 20
    });

    // Làm mới danh sách
    ctn.on('click', '[data-toggle="refreshList"]', function(e) {
        e.preventDefault();
        nukeviet.inform.GetList();
    });

    // Thay đổi tiêu chí lọc
    $('[data-toggle=changeFilter]', ctn).on('click', function(e) {
        e.preventDefault();
        $('[name=aj_filter]', ctn).val($(this).data('filter'));
        if (!$(this).is('.active')) {
            $(this).addClass('active');
            $(this).siblings().removeClass('active');
            nukeviet.inform.GetList();
        }
    })
});

// Đếm số thông báo chưa đọc
$(window).on('load', function() {
    const ctn = $('#inform-notification');
    nukeviet.inform.refresh = parseInt(ctn.data('refresh-time')) * 1000;
    nukeviet.inform.lastCount = parseInt(nv_getCookie(nukeviet.inform.cookie.count) || 0);
    nukeviet.inform.lastCheck = parseInt(nv_getCookie(nukeviet.inform.cookie.name) || 0);
    nukeviet.inform.GetCount();
});
