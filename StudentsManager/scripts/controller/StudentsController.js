var studentsconfig = {
    pageSize: 5,
    pageIndex: 1,
    search: null,
    isSearch: false
}
var studentsController = {
    init: function () {
        studentsController.loadData();
    },
    loadData: function (changePageSize) {
        $.ajax({
            url: '/students/loaddata',
            type: 'GET',
            dataType: 'json',
            data: {
                page: studentsconfig.pageIndex,
                pageSize: studentsconfig.pageSize,
                isSearch: studentsconfig.isSearch,
                search: studentsconfig.search
            },
            success: function (response) {
                if (response.status) {
                    var data = response.data;
                    var html = '';
                    var teamplate = $('#data-template').html();
                    $.each(data, function (i, item) {
                        html += Mustache.render(teamplate, {
                            StudId: item.StudId,
                            FullName: item.FullName,
                            Address: item.Address,
                            BirthDay: item.BirthDay,
                            Gender: item.Gender ? "<span class=\"label label-success\">Male</span>" : "<span class=\"label label-danger\">Female</span>",
                            Phone: item.Phone,
                            CreateAt: item.CreateAt,
                            UpdateAt: item.UpdateAt
                        });
                    });
                    $('#tblData').html(html);
                    if (response.totalRow != 0) {
                        studentsController.paging(response.totalRow, function () {
                            studentsController.loadData();
                        }, changePageSize);
                    }
                    studentsController.registerEvent();
                }
            }
        });
    },
    registerEvent: function () {
        $('.delete').on('click', function () {
            var conf = confirm('Are you sure you want to delete the item?');
            if (conf) {
                var id = $(this).data('id');
                studentsController.deleteStudent(id);
            }
        });
        $('#searchStudents').off('keypress').on('keypress', function (e) {
            if (e.which == 13) {
                studentsconfig.isSearch = true;
                studentsconfig.search = $(this).val();
                studentsController.loadData(true);
            }
        });
        
    },
    paging: function (totalRow, callback, changePageSize) {
        var totalPage = Math.ceil(totalRow / studentsconfig.pageSize);

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
                    studentsconfig.pageIndex = page;
                    setTimeout(callback, 200);
                }
            });
        }
        var posStart = ((studentsconfig.pageIndex - 1) * studentsconfig.pageSize) + 1;
        var posEnd = posStart + (studentsconfig.pageSize - 1);
        if (posEnd > totalRow)
            posEnd = totalRow;
        var html = 'Showing ' + posStart + ' to ' + posEnd + ' of ' + totalRow + ' entries';
        $('#dataTables-example_info').html(html);
    },
    deleteStudent: function (id) {
        var data = {
            StudId: id
        };
        $.ajax({
            url: '/students/delete',
            type: 'POST',
            dataType: 'json',
            data: { data: JSON.stringify(data) },
            success: function (response) {
                if (response.status) {
                    alert('Delete succesfully!');
                    studentsController.loadData(true);
                }
            }
        });
    }
}
studentsController.init();