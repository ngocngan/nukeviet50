/**
 * NukeViet Content Management System
 * @version 4.x
 * @author VINADES.,JSC <contact@vinades.vn>
 * @copyright (C) 2009-2024 VINADES.,JSC. All rights reserved
 * @license GNU/GPL version 2 or any later version
 * @see https://github.com/nukeviet The NukeViet CMS GitHub project
 */

'use strict';

function contactRequestform_precheck(form) {
    return 1;
}

$(function() {
    // Submit các form gửi yêu cầu liên hệ lại
    $('[data-toggle="contactRequestform"]').each(function() {
        $(this).on('submit', function(e) {
            e.preventDefault();
            console.log('Form submit');
        });
    });
});
