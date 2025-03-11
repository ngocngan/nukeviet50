/**
 * NukeViet Content Management System
 * @version 4.x
 * @author VINADES.,JSC <contact@vinades.vn>
 * @copyright (C) 2009-2024 VINADES.,JSC. All rights reserved
 * @license GNU/GPL version 2 or any later version
 * @see https://github.com/nukeviet The NukeViet CMS GitHub project
 */

'use strict';

/**
 * Tạo thẻ báo lỗi cho các trường dữ liệu trong form khi valid
 *
 * @param {JQuery} ipt
 * @param {String} message
 * @returns {JQuery}
 */
function _make_check_invalid(ipt, message) {
    let element = ipt.next();
    if (!element.length || (!element.is('.invalid-feedback') && !element.is('.invalid-tooltip'))) {
        element = $('<div class="invalid-tooltip"></div>').insertAfter(ipt);
    }
    element.text(message);
    ipt.addClass('is-invalid');
    return element;
}

/**
 * Kiểm tra từng input trong form
 *
 * @param {JQuery} ipt
 * @param {String | undefined | null} customMess
 * @param {Boolean | undefined} focus
 * @returns {JQuery}
 */
function _check_invalid(ipt, customMess, focus) {
    const valid = {
        type: $(ipt).data('valid'),
        empty: $(ipt).data('empty') !== undefined ? $(ipt).data('empty') : '',
        allowedEmpty: !!$(ipt).data('allowed-empty'),
    };
    focus && ipt.focus();
    if (customMess && customMess.length > 0) {
        return _make_check_invalid(ipt, customMess);
    }
    // Check bắt buộc
    if (!valid.allowedEmpty && (valid.type == 'email' || valid.type == 'text') && trim(ipt.val()) == valid.empty) {
        return _make_check_invalid(ipt, nv_required);
    }
    // Check rule
    if (valid.type == 'email' && !nv_mailfilter.test(trim(ipt.val()))) {
        return _make_check_invalid(ipt, nv_email);
    }
}

/**
 * Hàm kiểm tra validate form trước khi submit mặc định
 *
 * @param {HTMLElement | JQuery} form
 * @returns {Boolean}
 */
function nv_precheck_form(form) {
    if (!(form instanceof jQuery)) {
        form = $(form);
    }

    $('.is-invalid', form).removeClass('is-invalid');
    $('.is-valid', form).removeClass('is-valid');
    $('.invalid-tooltip, .valid-feedback', form).text('');

    $('[data-valid]', form).each(function() {
        _check_invalid($(this));
    });

    const invalid = form.find('.invalid-tooltip:visible, .valid-feedback:visible').first();
    const iptBefore = invalid.prev('[data-valid]');
    if (iptBefore.length > 0) {
        iptBefore.focus();
        return false;
    }

    return true;
}

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

    // QR-code
    $('[data-toggle="siteQrCode"').on('show.bs.dropdown', function(e) {
        const btn = $(e.target);
        const ctn = btn.closest('.dropup');
        if (btn.data('load') != 'no') {
            return;
        }
        btn.data('load', 'loading');
        const img = new Image;
        $(img).on('load', function() {
            $('img', ctn).attr('src', img.src);
            $('.loader', ctn).addClass('d-none');
            btn.data('load', 'yes');
        });
        img.src = nv_base_siteurl + "index.php?second=qr&u=" + encodeURIComponent($(btn).data("url"));
    });

    // Đổi kiểu giao diện
    $('[data-toggle="siteThemeModeChange"]').on('click', function(e) {
        e.preventDefault();
        window.location.href = $(this).data('type');
    });

    // Tooltip mặc định của block: Ảnh + Mô tả
    ([...document.querySelectorAll('[data-toggle="tooltipArticle"]')].map(tipEl => new bootstrap.Tooltip(tipEl, {
        boundary: document.body,
        container: 'body',
        html: true,
        trigger: 'hover',
        title: () => {
            let html = '';
            if ($(tipEl).data('img') != '') {
                html += '<div class="img"><div class="img-inner"><img src="' + $(tipEl).data('img') + '" alt="' + $(tipEl).data('alt') + '"></div></div>';
            }
            html += '<div class="tip-body">' + $(tipEl).data('hometext') + '</div>';
            return html;
        },
        template: '<div class="tooltip tooltip-block-articles" role="tooltip"><div class="tooltip-arrow"></div><div class="tooltip-inner"></div></div>'
    })));

    // Xử lý các form ajax mặc định
    $('body').on('submit', '[data-toggle="ajax-form"]', function(e) {
        e.preventDefault();

        const form = $(this);

        if ($('.is-invalid:visible', form).length > 0) {
            let ipt = $('.is-invalid:visible:first', form);
            if (ipt.is('.input-group')) {
                ipt = $('input:first', ipt);
            }
            ipt.focus();
            return;
        }

        $('.is-invalid', form).removeClass('is-invalid');
        $('.is-valid', form).removeClass('is-valid');

        if (typeof(CKEDITOR) !== 'undefined') {
            for (let instance in CKEDITOR.instances) {
                CKEDITOR.instances[instance].updateElement();
                CKEDITOR.instances[instance].setReadOnly(true);
            }
        }

        const formData = new FormData(form[0]);
        $('input, textarea, select, button', form).prop('disabled', true);

        $.ajax({
            url: form.attr('action'),
            type: (form.attr('method') || 'POST'),
            data: formData,
            processData: false,
            contentType: false,
            dataType: 'json',
            cache: false,
            success: function(respon) {
                // Gửi form thành công
                if (respon.status == 'OK' || respon.status == 'ok' || respon.status == 'success') {
                    let cb;
                    const callback = form.data('callback');
                    if ('function' === typeof callback) {
                        cb = callback(respon);
                    } else if ('string' == typeof callback && "function" === typeof window[callback]) {
                        cb = window[callback](respon);
                    }
                    if (cb === 0 || cb === false) {
                        return;
                    }
                    let timeout = 0;
                    if (respon.mess) {
                        nukeviet.toast(respon.mess, respon.warning ? 'warning' : 'success');
                        timeout = respon.timeout ? respon.timeout : 2000;
                    }
                    if (respon.redirect) {
                        setTimeout(() => {
                            window.location.href = respon.redirect;
                        }, timeout);
                    } else if (respon.refresh) {
                        setTimeout(() => {
                            window.location.reload();
                        }, timeout);
                    } else {
                        setTimeout(() => {
                            $('input, textarea, select, button', form).prop('disabled', false);
                            if (typeof(CKEDITOR) !== 'undefined') {
                                for (let instance in CKEDITOR.instances) {
                                    CKEDITOR.instances[instance].setReadOnly(false);
                                }
                            }
                        }, 1000);
                    }
                }
                // Gửi form thất bại
                $('input, textarea, select, button', form).prop('disabled', false);
                if (respon.tab) {
                    bootstrap.Tab.getOrCreateInstance(document.getElementById(respon.tab)).show();
                }
                if (respon.input) {
                    let eleCtn = null;
                    if (respon.input_parent) {
                        // Trường hợp nhiều input cùng tên có chỉ định ra thẻ cha của nó
                        eleCtn = $(respon.input_parent, form);
                    } else {
                        eleCtn = form;
                    }
                    let ele = $('[name^=' + respon.input + ']', eleCtn);
                    if (ele.length) {
                        _check_invalid(ele, respon.mess, true);
                        return;
                    }
                }
                nukeviet.toast(respon.mess, 'error');
            },
            error: function(xhr, text, err) {
                $('input, textarea, select, button', form).prop('disabled', false);
                nukeviet.toast(err || text, 'error');
                console.log(xhr, text, err);
            }
        });
    });

    $(document).on('change keyup', '[data-toggle="ajax-form"] select', function() {
        $(this).removeClass('is-invalid is-valid');
        if ($(this).parent().is('.input-group')) {
            $(this).parent().removeClass('is-invalid is-valid');
        }
    });

    $(document).on('change keyup', '[data-toggle="ajax-form"] [type="text"], [data-toggle="ajax-form"] [type="password"], [data-toggle="ajax-form"] [type="number"], [data-toggle="ajax-form"] [type="email"], [data-toggle="ajax-form"] textarea', function(e) {
        if (e.type === "keyup" && e.which === 13) {
            return;
        }
        let pr = $(this).parent();
        let prAlso = $(this).parent().is('.input-group');
        $(this).removeClass('is-invalid is-valid');
        if (prAlso) pr.removeClass('is-invalid is-valid');
    });
});
