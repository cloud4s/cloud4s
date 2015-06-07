<%--
  Created by IntelliJ IDEA. recoverkey
  User: sameera
  Date: 2/10/2015
  Time: 3:44 PM
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html lang="en">
<head>

    <title>Recover Key - Cloud4s</title>
    <link href='<c:url value="/css/login.css" />' rel="stylesheet" type="text/css"/>

    <script src="js/main.js"></script>
    <script src='<c:url value="/js/jquery.js" />' type="text/javascript"></script>
    <script src='<c:url value="/js/recover.js" />' type="text/javascript"></script>
    <script src='<c:url value="/js/secrets.js" />' type="text/javascript"></script>

</head>

<body>

<%--Header--%>
<jsp:include page="header.jsp" />

<%--Content--%>
<div class="intro-header">
    <div class="container login-box">

        <div class="form-signin" >

            <div class="row" id="allPieces">
                <label></label>
            </div>

            <div class="row" style="text-align: left">
                <label style="color: brown; font-size: 25px;">sent sources</label>
                <ul id="sentSources">

                </ul>
            </div>
            <div id="keyPieces" class="row">
            </div>
            <div class="row">
                <button id="recoverKeySubmit" class="btn btn-lg btn-primary btn-block">Recover Key</button>

                <input id="userName" value='${pageContext.request.userPrincipal.name}' type="hidden">
                <br>
                <input id="masterKey" class="form-control col-lg-8" style="margin-bottom: 20px">
                <br>
                <a id="Submit1" href="/dash" class="btn btn-primary btn-lg" style="width: 100%;">Submit Key</a>
            </div>
        </div>

    </div> <!-- /container -->

</div>
<style>
    ul{
        list-style-type: square;
    }
</style>
<%--Footer--%>
<jsp:include page="footer.jsp" />
<script>
    $(document).ready(function(){
        $('#Submit1').click(function(){
            var key = document.getElementById("masterKey").value;
            localStorage.setItem("cloud4s_" + "${pageContext.request.userPrincipal.name}", key);
        });

    });
</script>

</body>
</html>
