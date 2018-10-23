var homeConfig = {
    classId: $("#ClassId").val(),
};
var homeController = {
    init: function () {
        homeController.loadData();
    },
    registerEvent: function () {
        $("#ClassId").off("change").on("change", function () {
            homeConfig.classId = $(this).val();
            homeController.loadData();
        });
    },
    loadData: function () {
        var data = {
            classId: homeConfig.classId
        }
        $.ajax({
            url: '/home/loadDropData',
            type: 'GET',
            dataType: 'json',
            data: data,
            success: function (response) {
                if (response.status) {
                    var data = response.data;
                    var html = '';
                    var teamplate = $('#StudId');
                    $.each(data, function (i, item) {
                        html += '<option value="' + item.Value + '">' + item.Text + '</option>';
                    });
                    teamplate.html(html);
                    $('#select2-ClassId-container').html(response.text);
                    $('#select2-ClassId-container').attr('title', response.text);
                    homeController.registerEvent();
                }
            }
        });
    }
}
homeController.init();