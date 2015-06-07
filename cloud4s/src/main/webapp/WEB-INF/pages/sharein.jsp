<%--
  Created by IntelliJ IDEA.
  User: Cloud4S
  Date: 2/5/2015
  Time: 5:30 PM
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="sec"
          uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="en">

<head>

<title>Shared With Me - Cloud4s</title>

<link href='<c:url value="/css/dashboard.css" />' rel="stylesheet" type="text/css"/>
<link href='<c:url value="/css/jquery-ui.css" />' rel="stylesheet" type="text/css"/>
<link href='<c:url value="/css/jquery-ui.theme.css" />' rel="stylesheet" type="text/css"/>

<script src='<c:url value="/js/jquery.js" />' type="text/javascript"></script>
<script src='<c:url value="/js/jquery-ui.js" />' type="text/javascript"></script>

<script src="//cdn.datatables.net/1.10.4/js/jquery.dataTables.min.js"></script>
<link href='<c:url value="//cdn.datatables.net/1.10.4/css/jquery.dataTables.css" />' rel="stylesheet" type="text/css"/>

    <!--AES sripts-->
    <script src="js/aes/aes.js"></script>
    <script src="js/aes/aes-ctr.js"></script>
    <script src="js/aes/aes-ctr-file.js"></script>
    <script src="js/aes/file-saver.js"></script>
    <script src="js/aes/mtl.js"></script>
    <script src="js/aes/prettify.js"></script>

    <!--RSA scripts-->
    <script language="JavaScript" type="text/javascript" src="js/rsa/rsa_pack.js"></script>

<script>
var userList;
function loadFiles() {
    var userName = "${pageContext.request.userPrincipal.name}";
    $.ajax({
        url : 'getShareIn',
        dataType : "json",
        cache : false ,
        contentType : 'application/json; charset=utf-8',
        data : "username=" + userName,
        type : 'GET',
        success : function(data) {
            var jsonLoadFiles=data.sharedFiles;//get shared files details as Json objects..
            console.log(jsonLoadFiles);
            var dataset = [];
            for(var i=0; i < jsonLoadFiles.length; i++) {
                var obj = jsonLoadFiles[i];
                var  testdata=[];
                testdata.push(obj["filename"]);
                testdata.push(obj["sharedBy"]);
                testdata.push(obj["url"]);
                testdata.push(obj["filekey"].replace(/ /g,'+'));
                testdata.push(obj["index"]);

                dataset.push(testdata);
            }
            console.log(dataset);
            var FileTable=$('#table').DataTable( {
                "data": dataset,
                "columns": [
                    { "title": "FileName" },
                    { "title": "SharedBy" },
                    { "title": "" }
                ],
                "columnDefs": [ {
                    "targets": 2,
                    "data": "download",
                    "render": function(data,type,full,meta){
                        var i=0;
                        for(var a = 0; a < full.length; a++) {

                            return '<button class="share-button btn btn-primary btn-xs" style="align:right" type ="submit" id="downloadButton'+full[4]+'" onclick="downloadFile(this.id)" value="'+full[0]+','+full[2]+','+full[3]+'"><i class="fa fa-download"></i></button>';
                        }
                    }
                } ]
            } );
        }
    });
}

//file downloading function in SharedIn window
function downloadFile(id){
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
    var MasterKey = get_masterKey();
    var userName = "${pageContext.request.userPrincipal.name}"; //get user name
    var values = (document.getElementById(id).value).split(","); //split filename and url ',' character
    var filename = values[0];
    var fileURL = values[1];
    $.ajax({
        type : "Get",
        url : "getShareFileData",
        dataType: "json",
        cache: false,
        contentType: "application/json; charset=UTF-8",
        data : "fileURL=" + fileURL,
        success : function(response) {
            var fileContent = response["fileContent"];
            console.log("fileContent : "+fileContent);
            $.ajax({
                type : "Get",
                url : "getPrivateKey",
                dataType: "json",
                cache: false,
                contentType: "application/json; charset=UTF-8",
                data : "Username=" + userName,
                success : function(response) {
                    var jsonObj = response;
                    var enPrvKey = jsonObj["PrvKey"].replace(/ /g,'+');//get the ecrypted file key from DB..
                    console.log("Encrypted PrvKey : "+enPrvKey);
                    var prvKey = Aes.Ctr.decrypt(enPrvKey,MasterKey,256);//decrypt encrypted private key with master key..
                    var enFileKey = values[2].replace(/ /g, '+');//replace '' with '+' character..
                    var decrypt = new JSEncrypt();
                    decrypt.setPrivateKey(prvKey);
                    var fileKey = decrypt.decrypt(enFileKey);//decrypt encrypted file key with private key..
                    console.log("Prv Key: "+prvKey);
                    console.log("Encrypted filekey : "+enFileKey);
                    console.log("File key : "+fileKey);
                    saveFile(fileContent,filename,fileKey);
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

function saveFile(data,fileName,fileKey){
    var filename = fileName.replace(/\.encrypted$/,'');//remove the extention '.ecrypted' from file name..
    var decryptedData = Aes.Ctr.decrypt(data,fileKey,256);//decrypte file content from file key..
    console.log("Decrypted data: "+decryptedData);
    // convert single-byte character stream to ArrayBuffer bytestream
    var contentBytes = new Uint8Array(decryptedData.length);
    for (var i=0; i<decryptedData.length; i++) {
        contentBytes[i] = decryptedData.charCodeAt(i);
    }
    var blob = new Blob([contentBytes], {type: 'application/octet-stream'});//create the blob..
    saveAs(blob, filename);
    $('#alertPopup').dialog("close");
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

</script>

</head>

<body onload="loadFiles()">
<%--Header--%>
<jsp:include page="header.jsp" />

<%--Body Content--%>
<div class="intro-header">

    <div class="container">
        <!-- Sidebar Menu Items  -->
        <div class="collapse navbar-collapse navbar-ex1-collapse">
            <ul class="nav navbar-nav side-nav">
                <li>
                    <a href="/dash"><i class="fa fa-fw fa-file"></i> My Files</a>
                </li>
                <li>
                    <a href="/setShareOut"><i class="fa fa-hand-o-right"></i> Shared By Me</a>
                </li>
                <li>
                    <a href="/setShareIn"><i class="fa fa-hand-o-down"></i> Shared With Me</a>
                </li>
            </ul>
        </div>
        <!--Content Area-->
        <div id="page-wrapper">
            <div class="container-fluid">
                <!-- Bread Crumb -->
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header"> Files Shared With Me</h1>
                    </div>
                </div>
            </div>
        </div>
        <%--list display--%>
        <div class="table-responsive">
            <table id="table" name="table" class="table table-hover table-striped table-condensed">

            </table>
        </div>
        <%--notification alert--%>
        <div id="alertPopup" title=""  hidden="hidden"></div>

        <div id="keyPopUp" hidden="hidden" title="Store Key">
            <input type="text" value="${pageContext.request.userPrincipal.name}">
            <p></p>
            <input type="text" id="inputKey1" placeholder="Key">
        </div>
    </div>

</div>

<%--Footer--%>
<jsp:include page="footer.jsp" />

</body>

</html>


