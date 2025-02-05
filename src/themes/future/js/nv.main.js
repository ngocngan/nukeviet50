/**
 * NukeViet Content Management System
 * @version 4.x
 * @author VINADES.,JSC <contact@vinades.vn>
 * @copyright (C) 2009-2024 VINADES.,JSC. All rights reserved
 * @license GNU/GPL version 2 or any later version
 * @see https://github.com/nukeviet The NukeViet CMS GitHub project
 */

'use strict';

$(function() {
    // Đồng hồ
    const sClock = $('#site-digital-clock');
    if (sClock.length) {
        setInterval(() => {
            nv_my_dst && nv_is_dst() && (nv_my_ofs += 1);
            const newDate = new Date();
            newDate.setHours(newDate.getHours() + (newDate.getTimezoneOffset() / 60) + nv_my_ofs);
            sClock.text(nv_format_date(sClock.data('format'), newDate));
        }, 1000);
    }

    // Validate dạng mặc định: Check rule trước khi submit form
    const checkDIpt = (input) => {
        const ipt = $(input);
        const err = $(input).next();
        const value = trim(ipt.val());
        if (
            !err.length ||
            (!err.is('.invalid-feedback') && !err.is('.invalid-tooltip')) ||
            typeof ipt.data('error-mess') === 'undefined' ||
            ipt.data('error-mess') === ''
        ) {
            return 0;
        }
        if (
            value === '' ||
            (typeof ipt.attr('minlength') !== 'undefined' && value.length < parseInt(ipt.attr('minlength'))) ||
            (typeof ipt.attr('maxlength') !== 'undefined' && value.length > parseInt(ipt.attr('maxlength')))
        ) {
            ipt.addClass('is-invalid');
            err.text(ipt.data('error-mess'));
            return 1;
        }
        return 0;
    };
    $('body').on('submit', '[data-toggle="valid-dform"]', function(e) {
        const form = $(this);
        let invalid = 0;
        $('[required]', form).each(function() {
            invalid += checkDIpt(this);
        });
        if (invalid > 0) {
            e.preventDefault();
        }
    });
    $('body').on('keyup change', '[required]', function() {
        const input = $(this);
        const form = input.closest('form');
        if (!form.length || !form.is('[data-toggle="valid-dform"]')) {
            return;
        }
        input.removeClass('is-invalid');

        const err = input.next();
        if (err.length && (err.is('.invalid-feedback') || err.is('.invalid-tooltip'))) {
            err.text('');
        }
    });

    // Thanh menu ngang mặc định
    const menu = $('[data-toggle="main-nav"]');
    if (menu.length == 1) {
        const buildMenu = () => {
            const iExpanded = $('[data-toggle="item-expanded"]', menu);

            /**
             * Bước 1: Reset hết về mặc định
             * Bước 2: Tính xem có phần mở rộng không, không tính nút expand
             * Bước 3: Tính lại kể cả nút expanded
             *
             * no processed thì nút expanded có show nhưng dạng visibility: hidden
             * processed thì:
             * - has-expanded nút expanded show visible
             * - no-expanded hidden
             */
            menu.removeClass('processed has-expanded no-expanded');
            $('[data-toggle="item-lev-1"]', menu).removeClass('d-none');
            $('[data-toggle="submenu"]', menu).removeClass('submenu-end');
            iExpanded.find('ul').remove();

            const expandWidth = iExpanded.innerWidth();
            let menuWidth = menu.innerWidth();
            let expanded = false;
            let sWidth = 0;
            $('[data-toggle="item-lev-1"]', menu).each(function() {
                sWidth += $(this).innerWidth();
                if (sWidth > menuWidth) {
                    expanded = true;
                }
            });
            if (!expanded) {
                menu.addClass('processed no-expanded');
                return;
            }

            const stacks = [];
            menuWidth = menu.innerWidth() - expandWidth;
            sWidth = 0;
            $('[data-toggle="item-lev-1"]', menu).each(function() {
                sWidth += $(this).innerWidth();
                if (sWidth > menuWidth) {
                    stacks.push($(this).clone());
                    $(this).addClass('d-none');
                }
            });
            menu.addClass('processed has-expanded');
            const mExpanded = $('<ul data-toggle="submenu"></ul>');
            stacks.forEach((item) => {
                mExpanded.append(item);
            });
            iExpanded.append(mExpanded);

            // Bố trí lại vị trí các submenu
            $('[data-toggle="submenu"]', menu).each(function() {
                if (this.getBoundingClientRect().right > document.documentElement.clientWidth) {
                    $(this).addClass('submenu-end');
                }
            });
        };
        let timer = null;

        $(window).on('resize', function() {
            clearTimeout(timer);
            timer = setTimeout(buildMenu, 50);
        });
        buildMenu();
    }
});

$(window).on('load', function() {

});
