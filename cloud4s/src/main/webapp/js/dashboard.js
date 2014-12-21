function harshikaAjax() {
    $.ajax({
        url : 'loadfiles.html',
        dataType : "json",
        cache : false ,
        contentType : 'application/json; charset=utf-8',
        type : 'GET',
        success : function(data) {
            var jsonLoadFiles=data.files;
            console.log(jsonLoadFiles);
            var tableData =" <thead><tr><th style='text-align: center'>"+ "#" +"</th><th style='text-align: left'>"+ "Name" +"</th><th style='text-align: left'>"+ "Kind" +"</th><th>"+ "  " +"</th></tr></thead>";
            tableData += "<tbody>";
            for(var i=0; i < jsonLoadFiles.length; i++){
                var obj = jsonLoadFiles[i];
                tableData += "<tr class='share-div'>";
                tableData += "<td style='text-align:center'>" +(i+1)+"</td>";
                tableData += "<td>"+obj["filename"]+"</td><td>"+obj["iconname"]+"</td><td style='text-align:center'>";
                // Set download button at the end of the table raw.
                var btn = " ";
                btn += "<button class='share-button btn btn-primary btn-xs' style=";
                btn += "'align:right'";
                btn += "type='submit'";
                btn += "id='"+"downloadButton"+i+" ' ";
                btn += "onclick='"+"download("+"this.id"+")'";
                btn += " value= '" +obj["filename"]+","+obj["path"]+"'>";
                btn += "<i class='fa fa-download'></i>"
                btn += "</button>";
                btn += "&nbsp;&nbsp;";
                btn += "<button class='share-button btn btn-primary btn-xs' style=";
                btn += "'align:right'";
                btn += "type='submit'";
                btn += "id='"+"shareButton"+i+" ' ";
                btn += "onclick='"+"share("+"this.id"+")'";
                btn += " value= '" +obj["filename"]+","+obj["path"]+"'>";
                btn += "<i class='fa fa-share'></i>"
                btn += "</button>";
                tableData += " "+btn+"</td>";
                tableData += "</tr>";
            }
            tableData += "</tbody>";
            $("table").html(tableData);
        }
    });
}


function download(id) {
    var values = (document.getElementById(id).value).split(",");;
    console.log(values);
//            alert(values);
    $.ajax({
        type : "Get",
        url : "download",
        data : "filename=" + values[0] + "&path=" + values[1],
        success : function(response) {
            alert(values[0]+"successfully downloaded.");
        },
        error : function(e) {
            alert('Error: ' + e);
        }
    });
}

function share(id) {
    var values = (document.getElementById(id).value).split(",");;
    console.log(values);
    alert(values);
}


$(document).ready( function(){
    $('#keyLength').val(512);
    var privateKey;
    var publicKey;
    var ciphertext;
    var cipherpassword;
    // generate new RSA keys
    $('#rsakeyGen').click(function () {
        var sKeySize = $('#keyLength').val();
        var keySize = parseInt(sKeySize);
        var PassPhrase = "The Moon is a Harsh Mistress.";

        privateKey = cryptico.generateRSAKey(PassPhrase, keySize);
        publicKey = cryptico.publicKeyString(privateKey);
        $('#privateKey').val(privateKey);
        $('#publicKey').val(publicKey);
        $('#publicKeyInput').val(publicKey);
        $('#privateKeyInput').val(privateKey);

    });

    // encrypt  password(rsa)
    $('#encrypt').click(function () {

        var pswd = $('#password-encrpt').val();

        if (pswd) {
            if (publicKey) {

                cipherpassword = cryptico.encrypt(pswd, publicKey);
                $('#pswdCipher').val(cipherpassword);

            }
            else {
                alert("No public key found!");
            }

        }
        else {
            alert("Message and Password cannot be empty!");
        }

    });

    //send massage cipher and password cipher to user
    $('#send').click(function () {
        $('#pswdCipher2').val(cipherpassword);
    });

    //decrypt password(rsa)
    $('#pswdDecrypt').click(function () {
        if ($('#pswdCipher2').val() && $('#privateKeyInput').val()) {
            var password = cryptico.decrypt(cipherpassword.cipher, privateKey);
            $('#password-decrypt').val(password.plaintext);
        }
        else {
            alert("No password cipher found!");
        }
    });


});
