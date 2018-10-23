var classesConfig = {
    pageSize: 5,
    pageIndex: 1,
    search: null,
    isSearch: false
}
var classesController = {
    init: function () {
        classesController.loadData();
    },
    loadData: function (changePageSize) {
        var data = {
            page: classesConfig.pageIndex,
            pageSize: classesConfig.pageSize,
            isSearch: classesConfig.isSearch,
            search: classesConfig.search
        }
        $.ajax({
            url: '/classes/loaddata',
            type: 'GET',
            dataType: 'json',
            data: data,
            success: function (response) {
                if (response.status) {
                    var data = response.data;
                    var html = '';
                    var teamplate = $('#data-template').html();
                    $.each(data, function (i, item) {
                        html += Mustache.render(teamplate, {
                            ClassId: item.ClassId,
                            ClassName: item.ClassName,
                            StudTotal: item.StudTotal,
                            CreateAt: item.CreateAt,
                            UpdateAt: item.UpdateAt
                        });
                    });
                    $('#tblData').html(html);
                    if (response.totalRow != 0) {
                        classesController.paging(response.totalRow, function () {
                            classesController.loadData();
                        }, changePageSize);
                    }
                    classesController.registerEvent();
                }
            }
        });
    },
    registerEvent: function () {
        $('.delete').on('click', function () {
            var conf = confirm('Are you sure you want to delete the item?');
            if (conf) {
                var id = $(this).data('id');
                classesController.deleteClass(id);
            }
        });
        $('#searchClasses').off('keypress').on('keypress', function (e) {
            if (e.which == 13) {
                classesConfig.search = $(this).val();
                classesConfig.isSearch = true;
                classesController.loadData(true);
            }
        });
    },
    paging: function (totalRow, callback, changePageSize) {
        var totalPage = Math.ceil(totalRow / classesConfig.pageSize);

        //Unbind pagination if it existed or click change pagesize
        if ($('#pagination a').length === 0 || changePageSize === true) {
            $('#pagination').empty();
            $('#pagination').removeData("twbs-pagination");
            $('#pagination').unbind("page");
        }
        if (totalPage != 1) {
            $('#pagination').twbsPagination({
                totalPages: totalPage,
                visiblePages: 10,
                first: "<<",
                prev: "<",
                next: ">",
                last: ">>",
                onPageClick: function (event, page) {
                    classesConfig.pageIndex = page;
                    setTimeout(callback, 200);
                }
            });
        }
        var posStart = ((classesConfig.pageIndex - 1) * classesConfig.pageSize) + 1;
        var posEnd = posStart + (classesConfig.pageSize - 1);
        if (posEnd > totalRow)
            posEnd = totalRow;
        var html = 'Showing ' + posStart + ' to ' + posEnd + ' of ' + totalRow + ' entries';
        $('#dataTables-example_info').html(html);
    },
    deleteClass: function (id) {
        var data = {
            ClassId: id
        };
        $.ajax({
            url: '/classes/delete',
            type: 'POST',
            dataType: 'json',
            data: { data: JSON.stringify(data) },
            success: function (response) {
                if (response.status) {
                    alert('Delete succesfully!');
                    classesController.loadData(true);
                }
            }
        });
    }
}
classesController.init();