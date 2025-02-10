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
    $('body').on('keyup change', '[required]', function(e) {
        if (e.type === 'keyup' && e.keyCode === 13) {
            return;
        }

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
            menu.removeClass('processed has-expanded no-expanded');
            $('[data-toggle="item-lev-1"]', menu).removeClass('d-none');
            $('[data-toggle="submenu"]', menu).removeClass('submenu-end');
            iExpanded.find('ul').remove();
            if (nukeviet.isMScreen()) {
                return;
            }

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
                if (document.documentElement.dir === 'rtl') {
                    if (this.getBoundingClientRect().left < 0) {
                        $(this).addClass('submenu-end');
                    }
                } else if (this.getBoundingClientRect().right > document.documentElement.clientWidth) {
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

        // Ẩn hiện submenu trên mobile
        $('[data-toggle="subtg"]', menu).on('click', function(e) {
            e.preventDefault();
            if (!nukeviet.isMScreen()) {
                return;
            }

            const btn = $(this);
            const pMenu = btn.closest('li');
            const sMenu = $('> ul:first', pMenu);

            if (pMenu.is('.opening') || pMenu.is('.closing') || sMenu.length !== 1) {
                return;
            }
            if (pMenu.is('.open')) {
                // Thu gọn
                pMenu.addClass('closing');
                sMenu[0].style.height = sMenu[0].scrollHeight + "px";
                setTimeout(() => {
                    sMenu[0].style.height = 0;
                }, 1);
                setTimeout(() => {
                    pMenu.removeClass('closing open');
                    sMenu[0].style.height = null;
                }, 150);
                return;
            }
            // Mở rộng
            pMenu.addClass('opening');
            sMenu[0].style.height = sMenu[0].scrollHeight + "px";
            setTimeout(() => {
                pMenu.addClass('open').removeClass('opening');
                sMenu[0].style.height = null;
            }, 150);
        });
    }

    // Xử lý đóng mở menu mobile
    const mainNavToggler = $('[data-toggle="toggle-main-nav"]');
    mainNavToggler.on('click', function(e) {
        e.preventDefault();
        const btn = $(this);
        const hd = $('[data-toggle="site-header"]');
        const body = document.getElementsByTagName('body')[0];

        if (hd.is('.showing') || hd.is('.hiding')) {
            return;
        }
        btn.toggleClass('active');
        if (hd.is('.show')) {
            // Ẩn
            hd.addClass('hiding');
            hd.data('backdrop').removeClass('show');

            setTimeout(() => {
                hd.removeClass('show showing hiding');
                hd.data('backdrop').remove();
                hd.data('backdrop', null);

                body.style.overflow = hd.data('body-overflow');
                body.style.paddingRight = hd.data('body-padding-right');
                if (body.getAttribute('style') === '') {
                    body.removeAttribute('style');
                }
            }, 300);
            return;
        }

        // Hiện
        const backDrop = $('<div class="site-header-backdrop fade"></div>');
        backDrop.on('click', function() {
            btn.trigger('click');
        });
        hd.addClass('showing');
        hd.after(backDrop);
        hd.data('backdrop', backDrop);

        hd.data('body-overflow', body.style.overflow);
        hd.data('body-padding-right', body.style.paddingRight);
        body.style.overflow = 'hidden';
        if (document.documentElement.scrollHeight > window.innerHeight) {
            body.style.paddingRight = nukeviet.getScrollbarWidth() + 'px';
        }

        setTimeout(() => {
            backDrop.addClass('show');
        }, 1);
        setTimeout(() => {
            hd.addClass('show').removeClass('showing');
        }, 300);
    });
    $(window).on('resize', function() {
        // Đang mở menu mobile mà resize thì tự đóng
        if (mainNavToggler.is('.active') && !nukeviet.isMScreen()) {
            mainNavToggler.trigger('click');
        }
    });

    // Google map
    $('.company-map-modal').on('show.bs.modal', function() {
        if (!$('iframe', this).length) {
            $('.modal-body', this).html('<iframe class="w-100 fh-300" frameborder="0" src="' + $(this).data('src') +'" allowfullscreen></iframe>')
        }
    });
});
