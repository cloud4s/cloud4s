/**
 * Created by Chanu MR on 2/12/2015.
 */

var limit;

$(document).ready(function(){
    var sources, n, m;
    $('#masterKey').val("");

    var user = document.getElementById("userName").value;
    var sentSources = $('#sentSources');
    sentSources.empty();
    $.ajax({
        url : 'getKeyRecoveryDetails',
        dataType : "json",
        cache : false ,
        contentType : 'application/json; charset=utf-8',
        type : 'GET',
        data :  "name=" + user,
        success : function(data) {

            console.log(data);
            var addresses = data["details"].split(",");

            for(var i=0; i<addresses.length ;i++){
                var sentSource= "<label>"+addresses[i]+"</label><br>"
                sentSources.append(sentSource);
            }

            n=data["shares"];
            m=data["requires"];

            limit = m;
            var info= "<label>There are " +n+" key pieces. Minimum "+m+" pieces need to recover the key</label>";
            $('#allPieces').append(info);

            var keyDiv = $('#keyPieces');
            for(var i=0; i<m; i++){
                var textId = "part"+ i;
                keyDiv.append("<input id="+textId+" class='form-control keyPart'><br>");
            }
        },
        error : function(error){
            console.log(JSON.stringify(error));
        }
    });

    $('#recoverKeySubmit').click(function(){
        var keyArray = new Array(limit);
        for(var i=0; i<limit; i++){
            keyArray[i]=document.getElementById("part"+i).value;
        }
        var masterKey = secrets.hex2str(secrets.combine(keyArray));

        $('#masterKey').val(masterKey);
    });



});

