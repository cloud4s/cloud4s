<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="sec"
          uri="http://www.springframework.org/security/tags"%>
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

    <!--AES sripts-->
    <script src="js/aes/aes.js"></script>
    <script src="js/aes/aes-ctr.js"></script>
    <script src="js/aes/aes-ctr-file.js"></script>
    <script src="js/aes/file-saver.js"></script>
    <script src="js/aes/mtl.js"></script>
    <script src="js/aes/prettify.js"></script>

    <!--RSA scripts-->
    <script src="js/rsa/aes.js"></script>
    <script src="js/rsa/rsa.js"></script>
    <script src="js/rsa/api.js"></script>
    <script src="js/rsa/cryptico.js"></script>
    <script src="js/rsa/cryptico.min.js"></script>
    <script src="js/rsa/hash.js"></script>
    <script src="js/rsa/jsbn.js"></script>
    <script src="js/rsa/random.js"></script>
    <script src="js/rsa/jsencrypt.js"></script>

    <script src="js/FileSaver.js"></script>

    <sec:authorize access="hasRole('ROLE_USER')">
        <!-- For login user -->
        <c:url value="/j_spring_security_logout" var="logoutUrl" />
        <form action="${logoutUrl}" method="post" id="logoutForm">
            <input type="hidden" name="${_csrf.parameterName}"
                   value="${_csrf.token}" />
        </form>

        <c:url value="/upload" var="uploadUrl" />
        <form action="${uploadUrl}" method="get" id="uploadForm">
            <input id="fileName" name="fileName" type="hidden" value=""/>
        </form>

        <script>
            function formSubmit() {
                $('#logoutForm').submit();
            }
        </script>

    </sec:authorize>

    <script type="text/javascript">
        var userList;
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
                    alert('Error: ' + e);
                }
            });
        }

        function share(id) {
            $('#emailValidation').hide();
            var values = (document.getElementById(id).value).split(",");

            $(function() {
                var popup = $( "#sharePopUp" );
                var alertPopup = $('#shareSuccess');
                alertPopup.dialog({
                    autoOpen: false,
                    hide: "scale",
                    show : "scale",
                    height: 200,
                    width:300
                });
                popup.dialog({
                    autoOpen: false,
                    modal: true,
                    buttons: {
                        "Share": function() {
                            var list = $('#emailList').val();
                            $.ajax({
                                type : "GET",
                                url : "/shareFile",
                                dataType : "json",
                                cache : false ,
                                contentType : 'application/json; charset=utf-8',
                                data : "filename=" + values[0] + "&to=" + list,
                                success : function() {
                                    $('#emailList').val("");
                                    $('#currentEmail').val("");
                                    popup.dialog( "close" );
                                    alertPopup.dialog("open");
                                },
                                error : function(e) {
                                    alert(JSON.stringify(e));
                                }
                            });
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
            var MasterKey = "hasithaKey";
            var encryptedFileKey = Aes.Ctr.encrypt(fileKey,MasterKey,256);
            alert("encrypted file key:"+encryptedFileKey);
            var username = "${pageContext.request.userPrincipal.name}";
            $.ajax({
                type : "Get",
                url : "filekey",
                data : "enKey=" + encryptedFileKey + "&fileName=" + fileName+"&username="+username,
                success : function(response) {
                    console.log( fileName+ ": encrypted key uploaded to DB.");
                },
                error : function(e) {
                    alert('Error: ' + e);
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
                },
                error : function(e) {
                    alert('Error: ' + e);
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

        function saveFileKey(enKey,data,fileName){
            var filename = fileName.replace(/\.encrypted$/,'');
            var MasterKey = "hasithaKey";
            var decryptedFileKey = Aes.Ctr.decrypt(enKey,MasterKey,256);
            console.log("decrypted file key:"+decryptedFileKey);
            alert(decryptedFileKey);
            var decryptedData = Aes.Ctr.decrypt(data,decryptedFileKey,256);
            alert(decryptedData);
            var blob = new Blob([decryptedData], {type: "text/plain;charset=utf-8"});
            saveAs(blob, filename);
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

        function getShareFile(){

            $.ajax({
                url:'getFile.html',
                type:"GET",
                contentType: "application/json; charset=utf-8",
                data: "username=" +filename, //Stringified Json Object
                async: false,    //Cross-domain requests and dataType: "jsonp" requests do not support synchronous operation
                cache: false,    //This will force requested pages not to be cached by the browser
                processData:false, //To avoid making query String instead of JSON
                success: function(data){
                    alert(data);
                }});
        }

    </script>

</head>

<body onload="harshikaAjax()">
<%--Header--%>
<jsp:include page="header.jsp" />
<%--Body Content--%>
<div class="intro-header">

    <div class="container">
        <%--<a href="javascript:formSubmit()"><i class="fa fa-fw fa-power-off"></i> Log Out</a>--%>

        <!-- Sidebar Menu Items  -->
        <div class="collapse navbar-collapse navbar-ex1-collapse">
            <ul class="nav navbar-nav side-nav">
                <li>
                    <%--<input name="password-file" id="password-encrpt" value="1234" type="text" hidden="hidden">--%>
                        <span class="btn btn-default btn-file">
                            Upload
                            <input name="src-file" id="src-file" onchange="encryptFile(this.files[0])" type="file">
                        </span>

                </li>
                <li class="active">
                    <a href="javascript:redFile()"><i class="fa fa-fw fa-dashboard"></i> My Files</a>
                </li>
                <li>
                    <a href="javascript:getAllUsers()"><i class="fa fa-fw fa-bar-chart-o"></i> Shared</a>
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

    <%--share popup--%>
    <div id="sharePopUp" title="Share File" hidden="hidden">
        <div class="row">
            <label>E-mail</label>
            <input id="currentEmail" type="text"/>
            <button id="addEmail">Add</button>
        </div>
        <div hidden="hidden" id="emailValidation">Not an Email</div>
        <div class="row">
            <textarea id="emailList" style="resize: vertical; width: 90%" readonly></textarea>
        </div>
    </div>
    <div id="shareSuccess" title="Success"  hidden="hidden">

    </div>

</div>
<%--Footer--%>
<jsp:include page="footer.jsp" />

<script>
    $(document).ready(function(){
        var emailList = $('#emailList');
        $('#addEmail').click(function(){
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
    });
    function IsEmail(email) {
        var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
        return regex.test(email);
    }
</script>

</body>

</html>
<%--
  Created by IntelliJ IDEA.
  User: hp
  Date: 12/4/2014
  Time: 8:25 PM
  To change this template use File | Settings | File Templates.
--%>

