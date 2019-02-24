$(document).ready(function(){
    let usersIDs = [];
    let addUsersToUI = function(data, context){
        for(user of data){
            //console.log(usersIDs);

            if(usersIDs.includes(user.id))
                continue;
            usersIDs.push(user.id);
            let userBox = $("<div class='col-5 m-1'></div>");
            let userBoxRow = $("<div class='row'></div>");
            userBoxRow.append(
                $("<div class='col-4 mr-2'><img src='' width='70px' height='80px'/></div>")
            );
            userBoxRow.append(
                $("<div class='col-5 p-0 ml-4'><a href='/users/" + user.id + " class='font-weight-bold'>" + user.name + "</a><button class='btn btn-danger' id='" + user.id + "'>remove</button></div>")
            );
            userBox.append(userBoxRow);

            context.append(userBox);
        }
    };
    let sendAjaxRequest = function(target){
        let data = JSON.stringify(target);
        $.ajax({
            url: "/orders/invite.json",
            type: "POST",
            data: data,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: (data) => {
                let usersBox = $("#invited-people-list");
                addUsersToUI(data, usersBox);
                $("#order_invited_ids").val(usersIDs.toString());
            }
        });
    };
    $("#invite-box").on("keypress", function(e){
        if(e.keyCode == 13){
            e.preventDefault();
            let target = {"name": $(this).val()};
            sendAjaxRequest(target);
            $(this).val("");

        }
    });
    $("#invite-btn").on("click", function(e){
        e.preventDefault();
        let target = {"name": $("#invite-box").val()};
        sendAjaxRequest(target);
        $("#invite-box").val("");

    });


    $("#invited-people-list").on('click', 'button', function(){
        usersIDs.splice(usersIDs.indexOf($(this).attr("id")), 1);
        $("#order_invited_ids").val(usersIDs.toString());
        $(this).parent().parent().parent().remove();
    });
/*     $("#order").submit(function(e){
        e.preventDefault();
        let url = $(this).attr("action");
        let data = $(this).serialize()+usersIDs;
        console.log(data);
        $.ajax({
            url: url,
            type: "POST",
            data: data
        });
        //console.log($(this).serialize()+usersIDs);

    }) */
});