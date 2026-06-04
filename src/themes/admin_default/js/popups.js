/**
 * @Project NUKEVIET 5.x
 * @Author VINADES.,JSC <contact@vinades.vn>
 * @Copyright (C) 2020 VINADES.,JSC. All rights reserved
 * @License: Not free read more http://nukeviet.vn/vi/store/modules/nvtools/
 * @Createdate Tue, 02 Mar 2026 09:11:42 GMT
 */

$(function() {
    form = $('#form_search_popup');
    $('#btn_reset_form_search').on('click', function (e) {
        e.preventDefault();
        $("[data-default]", form).each(function() {
            if ($(this).is("input[type=text], input[type=hidden], input[type=number]")) {
                $(this).val($(this).attr("data-default"));
            } else if ($(this).is("select")) {
                $(this).val($(this).attr("data-default"));
            }
        });
        $('html, body').animate({ scrollTop : $('#contentmod').offset().top }, 800);
    });

    $('.delete_popup').on('click', function (e) {
        e.preventDefault();
        let btn = $(this);
         btn.prop('disabled', true);
        id_popup = btn.data('id');
        nvConfirm(nv_is_del_confirm[0], function() {
            $.ajax({
                type: 'POST',
                url: script_name + '?' + nv_lang_variable + '=' + nv_lang_data + '&' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=' + nv_func_name + '&nocache=' + new Date().getTime(),
                data: {
                    "delete": 1,
                    "id": id_popup,
                    "checkss": '{$CHECKSS}',
                },
                success: function (res) {
                    btn.prop('disabled', false);
                    if (res == 'OK') {
                        location.reload();
                        return;
                    }
                    nvToast(nv_is_del_confirm[2], 'error');
                },
                error: function (xhr, text, err) {
                    btn.prop('disabled', false);
                    nvToast(text, 'error');
                }
            });
        }, function() {
            btn.prop('disabled', false);
        });
    });
});

$(document).ready(function() {
    if ($("#start_time, #end_time").length > 0) {
        $("#start_time, #end_time").datepicker({
            dateFormat : "dd-mm-yy",
            changeMonth : true,
            changeYear : true,
            showOtherMonths : true,
            showOn: 'focus'
        });

        $('#start-date-btn').click(function(){
            $("#start_time").datepicker('show');
        });
        $('#end-date-btn').click(function(){
            $("#end_time").datepicker('show');
        });
    }
    $('#form_add_new_popup select[name="display_type"]').change(function(){
        if ($(this).val() != 3) {
            $("#id_display_interval").addClass('hidden d-none');
        } else {
            $("#id_display_interval").removeClass('hidden d-none');
        }
    });

    $('#form_add_new_popup input[name="is_all_page"]').change(function(){
        if ($(this).is(':checked')) {
            $("#required_page").addClass('hidden d-none');
        } else {
            $("#required_page").removeClass('hidden d-none');
        }
    });

    $('input[name="is_all_page"]').change(function(){
        if ($(this).is(':checked')) {
            $("#required_page").addClass('hidden');
        } else {
            $("#required_page").removeClass('hidden');
        }
    });

    // Toggle collapse
    $('.module-header').click(function(e) {
        if ($(e.target).is('input')) return;
        let $item = $(this).closest('.module-item');
        $item.toggleClass('open');
        $(this).find('.toggle')
            .html($item.hasClass('open') ? '<i class="fa fa-angle-down toggle fa-lg"></i>' : '<i class="fa fa-angle-right toggle fa-lg"></i>');
    });

    // Check module thì check all func
    $('.module-checkbox').change(function() {
        let module = $(this).data('module');
        $('.func-checkbox[data-module="' + module + '"]').prop('checked', $(this).is(':checked'));
        buildData();
    });

    // Check func thì chỉ cần build lại data
    $('.func-checkbox').change(function() {
        buildData();
    });

    let val = $('#display_pages').val();
    if (val) {
        let data = JSON.parse(val);
        $.each(data, function(module, funcs) {
            funcs.forEach(function(fun) {
                $('.func-checkbox[data-module="' + module + '"][value="' + fun + '"]').prop('checked', true);
            });
            $('.module-checkbox[data-module="' + module + '"]').prop('checked', true);
        });
    }

    function buildData() {
        let data = {};
        $('.module-checkbox').each(function() {
            let module = $(this).data('module');
            let funcs = $('.func-checkbox[data-module="' + module + '"]:checked');
            if (funcs.length === 0) return;
            data[module] = [];
            funcs.each(function() {
                data[module].push($(this).val());
            });
        });
        $('#display_pages').val(JSON.stringify(data));
    }

    // Chọn 1 or nhiều popup và thực hiện các chức năng đổi trạng thái, xóa
    $('[data-toggle="actionArticle"]').on('click', function (e) {
        e.preventDefault();
        let btn = $(this);
        if (btn.is(':disabled')) {
            return;
        }
        let ctn = $(btn.data('ctn')), listid = [];
        $('[data-toggle="checkSingle"]:checked', ctn).each(function () {
            listid.push($(this).val());
        });
        if (listid.length < 1) {
            nvAlert(nv_please_check);
            return;
        }
        let action = $('#element_action').val();

        if (action == 'delete') {
            nvConfirm(nv_is_del_confirm[0], () => {
                btn.prop('disabled', true);
                $('#element_action').prop('disabled', true);
                $.ajax({
                    type: 'POST',
                    url: script_name + '?' + nv_lang_variable + '=' + nv_lang_data + '&' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=main&nocache=' + new Date().getTime(),
                    data: {
                        checkss: btn.data('checksess'),
                        listid: listid.join(','),
                        action: action,
                        delete: 1
                    },
                    success: function (res) {
                        btn.prop('disabled', false);
                        $('#element_action').prop('disabled', false);
                        if (res.status == 'success') {
                            location.reload();
                        } else if (res.status == 'error') {
                            nvToast(res.mess, 'error');
                        } else {
                            nvToast(nv_is_del_confirm[2], 'error');
                        }
                    },
                    error: function (xhr, text, err) {
                        btn.prop('disabled', false);
                        $('#element_action').prop('disabled', false);
                        nvToast(text, 'error');
                        console.log(xhr, text, err);
                    }
                });
            });
        } else {
            btn.prop('disabled', true);
            $('#element_action').prop('disabled', true);
            $.ajax({
                type: 'POST',
                url: script_name + '?' + nv_lang_variable + '=' + nv_lang_data + '&' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=main&nocache=' + new Date().getTime(),
                data: {
                    checkss: btn.data('checksess'),
                    listid: listid.join(','),
                    action: action,
                    change_status: 1
                },
                success: function (res) {
                    btn.prop('disabled', false);
                    $('#element_action').prop('disabled', false);
                    if (res.status == 'success') {
                        location.reload();
                    } else if (res.status == 'error') {
                        nvToast(res.mess, 'error');
                    } else {
                        nvToast(nv_is_del_confirm[2], 'error');
                    }
                },
                error: function (xhr, text, err) {
                    btn.prop('disabled', false);
                    $('#element_action').prop('disabled', false);
                    nvToast(text, 'error');
                    console.log(xhr, text, err);
                }
            });
        }
    });
});

function changePopupStatus(id, newStatus, textStatus, label, checkss) {
    var badge = $('.badge-status-' + id);
    badge.addClass('opacity-50');
    $.ajax({
        type: 'POST',
        url: script_name + '?' + nv_lang_variable + '=' + nv_lang_data + '&' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=' + nv_func_name + '&nocache=' + new Date().getTime(),
        data: {
            "change_status": 1,
            "id": id,
            "checkss": checkss,
            "status": newStatus
        },
        success: function (res) {
            if (res.status == 'success') {
                badge.removeClass('badge-success label-warning text-dark label-danger opacity-50');
                badge.html(textStatus + ' <i class="fa fa-angle-down ml-1"></i>').addClass(label);
                nvToast(nv_is_change_act_confirm[1], 'success');
            } else {
                nvToast(nv_is_change_act_confirm[2], 'error');
                badge.removeClass('opacity-50');
            }
        },
        error: function (xhr, text, err) {
            badge.removeClass('opacity-50');
            nvToast(text, 'error');
        }
    });
}
