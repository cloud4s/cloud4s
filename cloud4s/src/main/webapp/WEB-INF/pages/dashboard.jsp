<%--
  Created by IntelliJ IDEA.
  User: sameera
  Date: 12/4/2014
  Time: 8:25 PM
  To change this template use File | Settings | File Templates.
--%>

<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="en">
<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="DashBoard for Cloud4s">
    <meta name="author" content="Sameera">

    <title>DashBoard - Cloud4s</title>

    <link href='<c:url value="/css/dashboard.css" />' rel="stylesheet" type="text/css"/>
    <link href='<c:url value="/css/jquery-ui.css" />' rel="stylesheet" type="text/css"/>
    <link href='<c:url value="/css/jquery-ui.theme.css" />' rel="stylesheet" type="text/css"/>

    <script src="js/main.js"></script>
    <script src='<c:url value="/js/jquery.js" />' type="text/javascript"></script>
    <script src='<c:url value="/js/jquery-ui.js" />' type="text/javascript"></script>

    <script src="//cdn.datatables.net/1.10.4/js/jquery.dataTables.min.js"></script>
    <link href='<c:url value="//cdn.datatables.net/1.10.4/css/jquery.dataTables.css" />' rel="stylesheet" type="text/css"/>

    <!----------------AES sripts------------->
    <script src="js/aes/aes.js"></script>
    <script src="js/aes/aes-ctr.js"></script>
    <script src="js/aes/aes-ctr-file.js"></script>
    <script src="js/aes/file-saver.js"></script>
    <script src="js/aes/mtl.js"></script>
    <script src="js/aes/prettify.js"></script>
    <%-------------------------------------%>

    <!-------------------------------------RSA scripts------------------------------------->
    <script language="JavaScript" type="text/javascript" src="js/rsa/rsa_pack.js"></script>
    <%-------------------------------------------------------------------------------------%>

    <script src="js/FileSaver.js"></script>

    <sec:authorize access="hasRole('ROLE_USER')">
        <!-- For login user -->
        <c:url value="/j_spring_security_logout" var="logoutUrl" />
        <form action="${logoutUrl}" method="post" id="logoutForm">
            <input type="hidden" name="${_csrf.parameterName}"
                   value="${_csrf.token}" />
        </form>

        <script>
            function formSubmit() {
                $('#logoutForm').submit();
            }
        </script>

    </sec:authorize>

    <script type="text/javascript">
        var userList;
        var FileTable;

        function loadfilesRepeat() {
            if(FileTable==undefined){

            }else {

                $.ajax({
                    url: 'loadfiles.html',
                    dataType: "json",
                    cache: false,
                    contentType: 'application/json; charset=utf-8',
                    type: 'GET',
                    success: function (data) {
                        var jsonLoadFiles = data.files;
                        console.log(jsonLoadFiles);
                        var dataset = [];
                        for (var i = 0; i < jsonLoadFiles.length; i++) {
                            var obj = jsonLoadFiles[i];
                            var testdata = [];
                            testdata.push(obj["filename"]);
                            //testdata.push(obj["iconname"]);
                            testdata.push(obj["path"]);
                            testdata.push(obj["index"]);

                            dataset.push(testdata);

                        }
                        console.log(dataset);
                        FileTable.destroy();
                        FileTable = $('#table').DataTable({
                            "data": dataset,
                            "columns": [
                                { "title": "FileName" },
                                { "title": "Path" },
                                { "title": "" }

                            ],
                            "columnDefs": [
                                {
                                    "targets": 2,
                                    "data": "download",
                                    "render": function (data, type, full, meta) {
                                        var i = 0;
                                        for (var a = 0; a < full.length; a++) {
                                            return '<button class="share-button btn btn-primary btn-xs" style="align:right" type ="submit" id="downloadButton' + full[2] + '" onclick="download(this.id)" value="' + full[0] + ',' + full[1] + '"><i class="fa fa-download"></i></button>&nbsp;&nbsp;' +
                                                    '<button class="share-button btn btn-primary btn-xs" style="align:right" type="submit" id="shareButton' + full[2] + '" onclick="share(this.id)" value="' + full[0] + ',' + full[1] + '"><i class="fa fa-share"></i></button>&nbsp;&nbsp;' +
                                                    '<button class="share-button btn btn-primary btn-xs" style="align:right" type="submit" id="deleteButton'+full[2]+'" onclick="delete_file(this.id)" value="'+full[0]+','+full[1]+'"><i class="fa fa-warning"></i></button>';
                                        }
                                    }
                                }
                            ]
                        });
                    }
                });
            }
        }
        function loadfiles() {
            $.ajax({
                url : 'loadfiles.html',
                dataType : "json",
                cache : false ,
                contentType : 'application/json; charset=utf-8',
                type : 'GET',
                success : function(data) {
                    var jsonLoadFiles=data.files;
                    console.log(jsonLoadFiles);
                    var dataset = [];
                    for(var i=0; i < jsonLoadFiles.length; i++) {
                        var obj = jsonLoadFiles[i];
                        var  testdata=[];
                        testdata.push(obj["filename"]);
                        //testdata.push(obj["iconname"]);
                        testdata.push(obj["path"]);
                        testdata.push(obj["index"]);

                        dataset.push(testdata);

                    }
                    console.log(dataset);
                    FileTable=$('#table').DataTable( {
                        "data": dataset,
                        "columns": [
                            { "title": "FileName" },
                            { "title": "Path" },
                            { "title": "" }

                        ],
                        "columnDefs": [ {
                            "targets": 2,
                            "data": "download",
                            "render": function(data,type,full,meta){
                                var i=0;
                                for(var a = 0; a < full.length; a++) {
                                    return '<button class="share-button btn btn-primary btn-xs" style="align:right" type ="submit" id="downloadButton'+full[2]+'" onclick="download(this.id)" value="'+full[0]+','+full[1]+'"><i class="fa fa-download"></i></button>&nbsp;&nbsp;' +
                                            '<button class="share-button btn btn-primary btn-xs" style="align:right" type="submit" id="shareButton'+full[2]+'" onclick="share(this.id)" value="'+full[0]+','+full[1]+'"><i class="fa fa-share"></i></button>&nbsp;&nbsp;' +
                                            '<button class="share-button btn btn-primary btn-xs" style="align:right" type="submit" id="deleteButton'+full[2]+'" onclick="delete_file(this.id)" value="'+full[0]+','+full[1]+'"><i class="fa fa-warning"></i></button>';
                                }
                            }
                        } ]
                    } );
                }
            });


        }


        function download(id) {

            var alertPopup = $('#alertPopup');
            alertPopup.dialog({
                autoOpen: false,
                hide: "scale",
                show : "scale",
                height: 100,
                width:200
            });
            alertPopup.empty();
            alertPopup.append("<label>Downloading...</label>");
            alertPopup.dialog("open");
            var values = (document.getElementById(id).value).split(",");
            console.log(values);
            var username = "${pageContext.request.userPrincipal.name}";
            $.ajax({
                type : "Get",
                url : "download",
                data : "filename=" + values[0] + "&path=" + values[1]+"&username="+username,
                success : function(response) {
//                    alert(values[0]+" successfully downloaded.");
                    readFile(values[0]);
                },
                error : function(e) {
                    console.log(JSON.stringify(e));
                }
            });
        }

        //confirm pop up


        //File sharing function
        function share(id) {
            $('#emailValidation').hide();
            var values = (document.getElementById(id).value).split(",");
            var fileName = values[0];
            var filePath = values[1];
            $(function() {
                var popup = $( "#sharePopUp" );
                var alertPopup = $('#alertPopup');
                alertPopup.dialog({
                    autoOpen: false,
                    hide: "scale",
                    show : "scale",
                    height: 100,
                    width:200
                });
                popup.dialog({
                    autoOpen: false,
                    modal: true,
                    buttons: {
                        "Share": function() {
                            alertPopup.empty();
                            alertPopup.append("<label>Sharing...</label>");
                            alertPopup.dialog("open");
                            var list = $('#emailList').val();
                            var pubKey = $('#publicKey').val().replace(/\s+/g, '');
                            if($('#publicMode').is(':checked'))
                            {
                                list= $('#currentEmail').val();
                            }
                            shareToOut(fileName,filePath,list,pubKey);
                            popup.dialog( "close" );

                        },
                        "Cancel": function() {
                            $('#emailList').val("");
                            $('#currentEmail').val("");
                            $( this ).dialog( "close" );
                        }
                    },
                    hide: "slide",
                    show : "slide",
                    height: 400,
                    width:500
                });
                popup.dialog( "open" );
            });

        }

        //Share files with external users.
        function shareToOut(fileName,filePath,list,pubKey){
            var MasterKey = get_masterKey();
            var userName = "${pageContext.request.userPrincipal.name}";
            var checked = $('#publicMode').is(':checked');
            var receiver;
            var recPubkey;
            $.ajax({
                type: "Get",
                url: "getFileKey.html",
                dataType: "json",
                cache: false,
                contentType: "application/json; charset=UTF-8",
                data: "fileName=" + fileName + "&filePath=" + filePath + "&userName=" + userName,
                success: function (response) {
                    var jsonObj = response;
                    console.log("file key: " + jsonObj["filekey"].replace(/ /g,'+'));
                    //decrypt file key using Master key...
                    var decryptedFileKey = Aes.Ctr.decrypt(jsonObj["filekey"].replace(/ /g,'+'), MasterKey, 256);
                    console.log("Decrypted file key:"+decryptedFileKey);
                    if(checked){
                        //re-encrypt file key with the public key....
                        var encrypt = new JSEncrypt();
                        encrypt.setPublicKey(pubKey);
                        var reEncrypted = encrypt.encrypt(decryptedFileKey)
                        console.log("decrypted file key: " + decryptedFileKey);
                        console.log("renecrypted file key: " + reEncrypted);
                        sendMails(fileName, reEncrypted, list, filePath);
                    }
                    else{
                        $.ajax({
                            type : "Get",
                            url : "getPubKey.html",
                            data : "Email=" + list,
                            success : function(response) {
                                var jsonObj = JSON.parse(response);
                                console.log("Response of getPubKey : "+response);
                                receiver=jsonObj["username"];
                                recPubkey=jsonObj["PubKey"];
                                console.log("receiver:"+receiver);
                                console.log("recPubkey :"+recPubkey);
                                //re-encrypt file key with the receiver's public key....
                                var encryptInt = new JSEncrypt();
                                encryptInt.setPublicKey(recPubkey);
                                var reEncryptedKey = encryptInt.encrypt(decryptedFileKey);
                                console.log("Re-encrypted key :"+reEncryptedKey);
                                $.ajax({
                                    type : "Get",
                                    url : "share/",
                                    dataType : "json",
                                    cache : false ,
                                    contentType: "application/json; charset=UTF-8",
                                    data : "fileName=" + fileName + "&path=" + filePath+"&username="
                                    +receiver+"&filekey="+reEncryptedKey+"&shareBy="+userName,
                                    success : function(response) {
                                        var jsonObj = JSON.parse(response);
                                        console.log("Response :"+jsonObj);
                                    },
                                    error : function(e) {
                                        console.log(JSON.stringify(e));
                                    }
                                });
                            },
                            error : function(e) {
                                console.log(JSON.stringify(e));
                            }
                        });
                    }
                    $('#alertPopup').dialog("close");
                },
                error: function (e) {
                    console.log(JSON.stringify(e));
                }
            });
        }

        //send mails to external users.
        function sendMails(fileName,reEncrypted,mailList,path){
            console.log("In function sendMails reEncrypted:"+reEncrypted);
            var alertPopup = $('#alertPopup');
            var publicMode = $('#publicMode');
            var ispublic = publicMode.is(':checked')
            $.ajax({
                type : "GET",
                url : "/shareFile",
                dataType : "json",
                cache : false ,
                contentType : 'application/json; charset=utf-8',
                data : "filename=" + fileName + "&to=" + mailList+"&defileKey="+reEncrypted+"&path="+path,
                success : function() {
                    $('#emailList').val("");
                    $('#currentEmail').val("");
                    alertPopup.prop('title', 'Success :)');
                    alertPopup.dialog("open");
                },
                error : function(e) {
                    alertPopup.prop('title', 'Error :(');
                    alertPopup.dialog("open");
                }
            });
        }

        function decryptFile(file,key){
            var start = 0;
            var stop = file.size - 1;
            var reader = new FileReader();
            // If we use onloadend, we need to check the readyState.
            reader.onloadend = function(evt) {
                if (evt.target.readyState == FileReader.DONE) { // DONE == 2
                    var data = evt.target.result;
                    console.log(data);
                }
            };
            var blob = file.slice(start, stop + 1);
            reader.readAsBinaryString(blob);
        }

        function sendFileKeyToDB(fileKey,fileName){
            var MasterKey = get_masterKey();
            var encryptedFileKey = Aes.Ctr.encrypt(fileKey,MasterKey,256);
            var username = "${pageContext.request.userPrincipal.name}";
            $.ajax({
                type : "Get",
                url : "filekey",
                data : "enKey=" + encryptedFileKey + "&fileName=" + fileName+"&username="+username,
                success : function(response) {
                    console.log( fileName+ ": encrypted key uploaded to DB.");
                    $('#alertPopup').dialog("close");
                },
                error : function(e) {
                    console.log(JSON.stringify(e));
                }
            });
        }

        function uploadEncryptedFile(fileName){
            $.ajax({
                type : "Get",
                url : "upload",
                data : "fileName=" + fileName,
                success : function(response) {
                    console.log(fileName+": successfully uploaded.");
                    $('#alertPopup').dialog("close");
                },
                error : function(e) {
                    console.log(JSON.stringify(e));
                    uploadEncryptedFile(fileName);
                }
            });
        }

        function getAllUsers(){
            var data;
            $.ajax({
                url : 'getAllUsers.html',
                dataType : "json",
                cache : false ,
                contentType : 'application/json; charset=utf-8',
                type : 'GET',
                success : function(data) {
                    var jsonLoadUsers=data.users;
                    console.log(jsonLoadUsers);
                    userList= jsonLoadUsers;
                }
            });
        }

        function saveFile(enKey,data,fileName){
            var filename = fileName.replace(/\.encrypted$/,'');
            var MasterKey = get_masterKey();
            console.log("encrytpted file key:"+enKey);
            var decryptedFileKey = Aes.Ctr.decrypt(enKey.replace(/ /g, '+'),MasterKey,256);
            console.log("decrypted file key:"+decryptedFileKey);
            console.log("Encrypted data:"+data);
            var decryptedData = Aes.Ctr.decrypt(data,decryptedFileKey,256);
            console.log("Decrypted data: "+decryptedData);
            // convert single-byte character stream to ArrayBuffer bytestream
            var contentBytes = new Uint8Array(decryptedData.length);
            for (var i=0; i<decryptedData.length; i++) {
                contentBytes[i] = decryptedData.charCodeAt(i);
            }
            var blob = new Blob([contentBytes], {type: 'application/octet-stream'});
            saveAs(blob, filename);
            $('#alertPopup').dialog("close");
        }

        function readFile(filename){
            $.ajax({
                url:'getFile.html',
                type:"GET",
                contentType: "application/json; charset=utf-8",
                data: "filename=" +filename, //Stringified Json Object
                async: false, //Cross-domain requests and dataType: "jsonp" requests do not support synchronous operation
                cache: false, //This will force requested pages not to be cached by the browser
                processData:false, //To avoid making query String instead of JSON
                success: function(data){
                    var json = JSON.parse(data);
                    saveFileKey(json["encryptedKey"],json["fileContent"],filename);
                }});
        }

        // Key storing in browser
        function get_masterKey(){
            var key = localStorage.getItem("cloud4s_"+"${pageContext.request.userPrincipal.name}");
            if (key==null){
                $(function() {
                    document.getElementById('inputKey1').value = "";
                    var popup = $( "#keyPopUp" );
                    popup.dialog({
                        autoOpen: false,
                        modal: true,
                        buttons: {
                            "Store": function() {
                                insert_value();
                                popup.dialog("close");
                            }
                        },
                        hide: "puff",
                        show : "slide",
                        height: 300,
                        width:300
                    });
                    popup.dialog( "open" );
                });
                var val = document.getElementById("inputKey1").value;
                return val;
            }
            else{
                return key;
            }
        }

        function insert_value() {
            var val = document.getElementById("inputKey1").value;
            localStorage.setItem("cloud4s_" + "${pageContext.request.userPrincipal.name}", val);
        }

        function delete_file(id){
            $("#dialog-confirm").dialog({
                resizable: false,
                modal: true,
                title: "Confirm",
                height: 100,
                width: 200,
                buttons: {
                    "Yes": function () {
                        $(this).dialog('close');
                        var values = (document.getElementById(id).value).split(",");
//
                        var userName = "${pageContext.request.userPrincipal.name}";
                        var fileName = values[0];
                        var path = values[1];
                        console.log("file name : "+fileName);
                        console.log("path : "+path);
                        $.ajax({
                            url:'deleteFileFromDropBox.html',
                            type:"GET",
                            contentType: "application/json; charset=utf-8",
                            data: "fileName=" +fileName+"&userName="+userName+"&path="+path, //Stringified Json Object
                            async: false, //Cross-domain requests and dataType: "jsonp" requests do not support synchronous operation
                            cache: false, //This will force requested pages not to be cached by the browser
                            processData:false, //To avoid making query String instead of JSON
                            success: function(data){
//
                            }});
                    },
                    "No": function () {
                        $(this).dialog('close');
                    }
                }
            });

        }

    </script>

</head>

<body onload="loadfiles();get_masterKey();window.setTimeout(window.setInterval(loadfilesRepeat,10000),10000);">
<%--Header--%>
<jsp:include page="header.jsp" />
<%--Body Content--%>
<div class="intro-header">

    <div class="container">
        <!-- Sidebar Menu Items  -->
        <div class="collapse navbar-collapse navbar-ex1-collapse">
            <ul class="nav navbar-nav side-nav">
                <li>
                    <span class="btn btn-primary btn-file" style="width: 120px">
                        Upload
                        <input name="src-file" id="src-file" onchange="encryptFile(this.files[0])" type="file">
                    </span>
                </li>
                <li class="active">
                    <a href="/setShareOut" style="color: #000000"><i class="fa fa-fw fa-dashboard"></i> <span>Shared By Me</span></a>
                </li>
                <li>
                    <a href="/setShareIn" style="color: #000000"><i class="fa fa-fw fa-bar-chart-o"></i> <span>Shared With Me</span></a>
                </li>

            </ul>
        </div>
    </nav>

    <!--Content Area-->
    <div id="page-wrapper">
        <div class="container-fluid">
            <!-- Bread Crumb -->
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header"> My Files</h1>
                </div>
            </div>
        </div>
    </div>
    <%--list display--%>
    <div class="table-responsive">
    <table id="table" name="table" class="table table-hover table-striped table-condensed">

    </table>
    </div>

    <%--public share popup--%>
    <div id="sharePopUp" title="Share File" hidden="hidden">
        Public Share <input type="checkbox" id="publicMode" class="pull-right">
        <div class="row">
            <div class="col-lg-2"><label>E-mail</label></div>
            <div class="col-lg-8"><input id="currentEmail" type="text" placeholder="Email" style="width: 100%; height: 30px;"/></div>
            <div class="col-lg-2"><button id="addEmail">Add</button></div>
        </div>
        <div hidden="hidden" id="emailValidation">Not an Email</div>
        <br>
        <div class="row">
            <textarea id="emailList" style="position: absolute; width: 94%; left: 3%;  min-height: 150px;" readonly></textarea>
        </div>
        <div class="row">
            <input type="text" id="publicKey" placeholder="public key" hidden="hidden" style="position: relative; width: 94%; left: 3%; top: 175px">
        </div>
    </div>
<<<<<<< HEAD
=======

    <div id="alertPopup"  hidden="hidden">

    </div>
>>>>>>> 6b95246e1d680602ef74eddb7d627fc47dbbab23

    <%--notification alert--%>
    <div id="alertPopup" title=""  hidden="hidden"></div>
    <%--confirm div--%>
     <div id="dialog-confirm" hidden="hidden"></div>

    <%--Master key missing popup--%>
    <div id="keyPopUp" hidden="hidden" title="Store Key">
        <input type="text" value="${pageContext.request.userPrincipal.name}">
        <p></p>
        <input type="text" id="inputKey1" placeholder="Key"><br>
        <label style="font-size: 12px">
            (We strongly recomend to recover the key if you are not sure. If the key you entered is wrong files will not be encrypted properly)
        </label>
        <a href="/recoverkey" class="btn btn-primary">Recover key</a>
    </div>
</div>
<%--Footer--%>
<jsp:include page="footer.jsp" />

<script>
    $(document).ready(function(){
        var emailList = $('#emailList');
        var publicMode= $('#publicMode');
        var publicKey = $('#publicKey');
        var addMail = $('#addEmail');

        addMail.click(function(){
            var currentEmail = $('#currentEmail');
            if(IsEmail(currentEmail.val())){
                $('#emailValidation').hide();
                var list = emailList.val();
                if(list==""){
                    emailList.val(currentEmail.val()); //updated email list
                }
                else{
                    emailList.val(list+"; "+currentEmail.val()); //updated email list
                }
                currentEmail.val(""); //resetting email entering field
            }
            else{
                $('#emailValidation').show();
            }
        });
        publicMode.change(function(){
            if(publicMode.is(':checked')){
                publicKey.show();
                addMail.hide();
                emailList.hide();
                if(emailList.val().toString().indexOf(";") >= 0){
                    emailList.val("");
                }
            }
            else{
                publicKey.hide();
                addMail.show();
                emailList.show();
            }
        });

        $('#src-file').change(function(){
            var alertPopup = $('#alertPopup');
            alertPopup.dialog({
                autoOpen: false,
                hide: "scale",
                show : "scale",
                height: 100,
                width:200
            });
            alertPopup.empty();
            alertPopup.append("<label>Uploading...</label>");
            alertPopup.dialog("open");
        });

    });
    function IsEmail(email) {
        var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
        return regex.test(email);
    }


</script>

</body>

</html>

