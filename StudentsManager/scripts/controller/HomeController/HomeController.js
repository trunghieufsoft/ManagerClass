var homeconfig = {
    pageSize: 5,
    pageIndex: 1,
    classId: $('#ClassId').val()
}
var homeController = {
    init: function () {
        homeController.loadData();
    },
    loadData: function (changePageSize) {
        $.ajax({
            url: '/home/loaddata',
            type: 'GET',
            dataType: 'json',
            data: {
                page: homeconfig.pageIndex,
                pageSize: homeconfig.pageSize,
                classId: homeconfig.classId
            },
            success: function (response) {
                if (response.status) {
                    var data = response.data;
                    var html = '';
                    var teamplate = $('#data-template').html();
                    $('#select2-ClassId-container').html(response.text);
                    $('#select2-ClassId-container').attr('title', response.text);
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
                        homeController.paging(response.totalRow, function () {
                            homeController.loadData();
                        }, changePageSize);
                    }
                    homeController.registerEvent();
                }
            }
        });
    },
    registerEvent: function () {
        $('.delete').on('click', function () {
            var conf = confirm('Are you sure you want to delete the item?');
            if (conf) {
                var id = $(this).data('id');
                var classId = $('#ClassId').val();
                homeController.deleteStudent(id, classId);
            }
        });
        $(".edit").on("click", function () {
            var ClassId = $("#ClassId").val();
            var StudId = $(this).data('id');
            window.location.href = "/home/edit?studId=" + StudId + "&classId=" + ClassId;
        })
        $("#ClassId").off("change").on("change", function () {
            homeconfig.classId = $(this).val();
            homeController.loadData(true);
        });

    },
    paging: function (totalRow, callback, changePageSize) {
        var totalPage = Math.ceil(totalRow / homeconfig.pageSize);

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
                    homeconfig.pageIndex = page;
                    setTimeout(callback, 200);
                }
            });
        }
        var posStart = ((homeconfig.pageIndex - 1) * homeconfig.pageSize) + 1;
        var posEnd = posStart + (homeconfig.pageSize - 1);
        if (posEnd > totalRow)
            posEnd = totalRow;
        var html = 'Showing ' + posStart + ' to ' + posEnd + ' of ' + totalRow + ' entries';
        $('#dataTables-example_info').html(html);
    },
    deleteStudent: function (id, classId) {
        var data = {
            ClassId: classId,
            StudId: id,
        };
        $.ajax({
            url: '/home/delete',
            type: 'POST',
            dataType: 'json',
            data: { data: JSON.stringify(data) },
            success: function (response) {
                if (response.status) {
                    alert('Delete succesfully!');
                    homeController.loadData(true);
                }
            }
        });
    }
}
homeController.init();