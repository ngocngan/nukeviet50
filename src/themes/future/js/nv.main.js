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
});
