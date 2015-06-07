/**
 * Created by Chanu MR on 1/20/2015.
 */
var user_name;
var shares;
var requires;

$(document).ready(function(){


    var keysArray=[];
    var emailArray=[];

    $('#recoverKeySubmit').click(function(){
        for(var i=1;i<=parseInt(shares);i++){
            var ID = "piece"+ i.toString();
            var textId = "send" + i.toString();

            keysArray.push(document.getElementById(ID).value);
            emailArray.push(document.getElementById(textId).value);
        }

        $.ajax({
            type: 'GET',
            url: "keyrecovery_req",
            data: "name=" + user_name +
                "&shares=" + shares +
                "&requires=" + requires +
                "&keysArray=" + keysArray +
                "&emailArray=" + emailArray,
            success : function(response) {
                console.log("Key recovery setup successful!!!");
            },
            error : function(e) {
                console.log(JSON.stringify(e));
            }
        });
    });

    $('.keyPiece > button').click(function(){
        var num = $(this).text();
        shares = num;
        $('.keyPiece > button.btn-danger').removeClass("btn-danger");
        $(this).addClass("btn-danger");
        var recoveryDD = $('#piecesToRecovery');
        var details = $('#shareDetails');
        recoveryDD.empty();
        details.empty();

        for(var i=2; i<= num; i++){
            var option = "<button type='button' class='btn btn-default'>"+i+"</button>";
            recoveryDD.append(option);
        }

        $('.toRecovery > button').click(function(){
            $('#piecesToRecovery > button.btn-danger').removeClass("btn-danger");
            var second = $(this).text();
            requires = second;
            details.empty();
            $(this).addClass("btn-danger");
            var keyParts = divide(parseInt(num), parseInt(second));//                    var keyParts = [1111, 2222, 3333, 4444, 5555];//assign key parts to this variable
            for (var i = 1; i <= num; i++) {
                var name = "Piece" + i.toString();
                var textId = "send" + i.toString();
                var labaleID = "piece" + i.toString();

                var content = "<div class='row'><div class='col-lg-5'><label class='pull-center'>" + name + "</label></div><div class='col-lg-7'><input class='pull-left form-control' id="+textId+"><input class='pull-left form-control' type='hidden' id="+labaleID+" value=" + keyParts[i - 1] + "></div></div><br>";
                details.append(content);

            }
        });
    });


});
function IsEmail(email) {
    var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
    return regex.test(email);
}

function secret_share(){

    var parts = secrets.share(new_master_key,5,2);
    localStorage.setItem("1", parts[0]);
    localStorage.setItem("2",parts[1]);

    var part1 = localStorage.getItem("1");
    var part2 = localStorage.getItem("2");

    var rslt = secrets.hex2str(secrets.combine([part1,part2]));
    console.log("output is "+rslt);
    var email = $('#inputEmail').val;

}

function key_from_browser(name){

    var key = localStorage.getItem("cloud4s_"+name);
    var current_user = name;
    user_name = current_user;
    document.getElementById('inputKey').value = key;

}



function divide(toDevide,toRecover){

    var master_key = $('#inputKey').val();
    var new_master_key = secrets.str2hex(master_key);
    var parts = secrets.share(new_master_key,toDevide,toRecover);
    return parts;

}


function sendingMail() {


}

