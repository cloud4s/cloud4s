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

    <title>Shared By Me - Cloud4s</title>

    <link href='<c:url value="/css/dashboard.css" />' rel="stylesheet" type="text/css"/>
    <link href='<c:url value="/css/jquery-ui.css" />' rel="stylesheet" type="text/css"/>
    <link href='<c:url value="/css/jquery-ui.theme.css" />' rel="stylesheet" type="text/css"/>

    <script src='<c:url value="/js/jquery.js" />' type="text/javascript"></script>
    <script src='<c:url value="/js/jquery-ui.js" />' type="text/javascript"></script>

    <script src="//cdn.datatables.net/1.10.4/js/jquery.dataTables.min.js"></script>
    <link href='<c:url value="//cdn.datatables.net/1.10.4/css/jquery.dataTables.css" />' rel="stylesheet" type="text/css"/>


    <script src='<c:url value="/js/jquery.confirm.js" />' type="text/javascript"></script>
    <script>
        var userList;
        var FileTable;
        function loadFiles() {
            var userName = "${pageContext.request.userPrincipal.name}";

            $.ajax({
                url : 'getShareOut',
                dataType : "json",
                data : "username=" + userName,
                cache : false ,
                contentType : 'application/json; charset=utf-8',
                type : 'GET',
                success : function(data) {
                    var jsonLoadFiles=data.sharedFiles;
                    console.log(jsonLoadFiles);
                    var dataset = [];
                    for(var i=0; i < jsonLoadFiles.length; i++) {
                        var obj = jsonLoadFiles[i];
                        var  testdata=[];
                        testdata.push(obj["filename"]);
                        testdata.push(obj["receiver"]);
                        testdata.push(obj["revoke"]);
                        testdata.push(obj["index"]);

                        dataset.push(testdata);
                    }
                    console.log(dataset);

                    FileTable=$('#table').DataTable( {
//                   FileTable.draw({
                        "data": dataset,
                        "columns": [
                            { "title": "FileName" },
                            { "title": "Receiver" },
                            { "title": "" }
                        ],
                        "columnDefs": [ {
                            "targets": 2,
                            "data": "download",
                            "render": function(data,type,full,meta){
                                var i=0;
                                for(var a = 0; a < full.length; a++) {
                                    return '<input class="boolean-tr" type="hidden" value="'+full[2]+'" >' +
                                            '<button class="share-button btn btn-primary btn-xs grant_access confirm" style="align:right" type ="submit" id="downloadButton'+full[3]+'" onclick="grant_access(this.id)" value="'+full[0]+','+full[1]+'"><i class="fa fa-key"></i></button>&nbsp;&nbsp;' +
                                            '<button class="share-button btn btn-primary btn-xs revoke_access confirm" style="align:right" type="submit" id="shareButton'+full[3]+'" onclick="revoke_access(this.id)" value="'+full[0]+','+full[1]+'"><i class="fa fa-chain-broken"></i></button>&nbsp;&nbsp;' +
                                            '<button class="share-button btn btn-primary btn-xs confirm-delete" style="align:right" type="submit" id="shareButton'+full[3]+'" onclick="delete_access(this.id)" value="'+full[0]+','+full[1]+'"><i class="fa fa-warning"></i></button>';
                                }
                            }
                        }
                        ]
                    } );


                    $('tr').each(function() {
                        var bool = $(this).find('.boolean-tr').val();
                        var revokeBtn = $(this).find('.revoke_access');
                        var grantBtn = $(this).find('.grant_access');
                        if (bool == "true") { // check for bool value
                            grantBtn.show(); // show the buttons
                            revokeBtn.hide();
                        }else{
                            grantBtn.hide(); // show the buttons
                            revokeBtn.show();
                        }
                    });



//                    $(".confirm-delete").confirm({
//                        text: "Are you sure you want to delete that comment?",
//                        title: "Confirmation required",
//                        confirm: function(button) {
////                            delete_access(this.id)
//                        },
//                        cancel: function(button) {
//                            // nothing to do
//                        },
//                        confirmButton: "Yes I am",
//                        cancelButton: "No",
//                        post: true,
//                        confirmButtonClass: "btn-danger",
//                        cancelButtonClass: "btn-default"
//                    });
                }
            });
        }

        function grant_access(id){
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
                        var userName = "${pageContext.request.userPrincipal.name}";
                        var fileName = values[0];
                        var receiver = values[1];
                        console.log("file name : "+fileName);
                        console.log("receiver : "+receiver);
                        send_ajax(fileName,receiver,userName,"grant_access");
                        FileTable.destroy();
                        loadFiles();

                    },
                    "No": function () {
                        $(this).dialog('close');
                    }
                }
            });



        }

        function revoke_access(id){
            $("#dialog-confirm").dialog({
                resizable: false,
                modal: true,
                title: "Confirm",
                height: 100,
                width: 200,
                buttons: {
                    "Yes": function () {
                        $(this).dialog('close');
                        //function
                        var values = (document.getElementById(id).value).split(",");
                        var userName = "${pageContext.request.userPrincipal.name}";
                        var fileName = values[0];
                        var receiver = values[1];
                        console.log("file name : "+fileName);
                        console.log("receiver : "+receiver);
                        send_ajax(fileName,receiver,userName,"revoke_access");
                        FileTable.destroy();
                        loadFiles();
                    },
                    "No": function () {
                        $(this).dialog('close');
                    }
                }
            });

        }

        function delete_access(id){

            $("#dialog-confirm").dialog({
                resizable: false,
                modal: true,
                title: "Confirm",
                height: 100,
                width: 200,
                buttons: {
                    "Yes": function () {
                        $(this).dialog('close');
                        //function
                        var values = (document.getElementById(id).value).split(",");
                        var userName = "${pageContext.request.userPrincipal.name}";
                        var fileName = values[0];
                        var receiver = values[1];
                        console.log("file name : "+fileName);
                        console.log("receiver : "+receiver);
                        send_ajax(fileName,receiver,userName,"delete_access");
                        FileTable.destroy();
                        loadFiles();
                    },
                    "No": function () {
                        $(this).dialog('close');
                    }
                }
            });

        }

        function send_ajax(fileName,receiver,userName,ajax_url){
            $.ajax({
                type : "Get",
                url : ajax_url,
                dataType : "json",
                cache : false ,
                contentType : 'application/json; charset=utf-8',
                data : "filename=" + fileName + "&receiver=" + receiver+"&username="+userName,
                success : function(response) {
                    console.log("Response : "+response);
                },
                error : function(e) {
                    console.log(JSON.stringify(e));
                }
            });
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
                        <h1 class="page-header"> Files Shared By Me</h1>
                    </div>
                </div>
            </div>
        </div>
        <%--confirm div--%>
        <div id="dialog-confirm" hidden="hidden"></div>
        <%--list display--%>
        <div class="table-responsive">
            <table id="table" name="table" class="table table-hover table-striped table-condensed">

            </table>
        </div>
    </div>
    <%--<i class='fa fa-warning'></i>--%>

</div>

<%--Footer--%>
<jsp:include page="footer.jsp" />

<script>
    $(document).ready(function(){

    });
</script>

</body>

</html>


