<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html lang="en">
<head>

    <title>Set Key Recovery - Cloud4s</title>
    <link href='<c:url value="/css/login.css" />' rel="stylesheet" type="text/css"/>

    <script src="js/main.js"></script>
    <script src='<c:url value="/js/jquery.js" />' type="text/javascript"></script>
    <script src='<c:url value="/js/keyShare.js" />' type="text/javascript"></script>
    <script src='<c:url value="/js/secrets.js" />' type="text/javascript"></script>

</head>

<body onload="key_from_browser(document.getElementById('user').textContent);">

<%--Header--%>
<jsp:include page="header.jsp" />

<%--Content--%>
<div class="intro-header">
    <div class="container login-box" width="500px !important">

        <form class="form-signin" method="get" action="/login">
            <label for="inputKey" >Encryption Key</label>
            <input id="inputKey" class="form-control" name="inputKey" type="password"  readonly>
            <label id="user" for="inputKey" hidden="hidden">${username}</label>
            </br></br>
            <div class="row">
                <div class="col-lg-5">
                    <label class="pull-left">Key Pieces</label>
                </div>
                <div class="col-lg-7">
                    <div id="keyPieces" class="btn-group keyPiece pull-left" role="group">
                        <button type="button" class="btn btn-default" >2</button>
                        <button type="button" class="btn btn-default" >3</button>
                        <button type="button" class="btn btn-default" >4</button>
                        <button type="button" class="btn btn-default" >5</button>
                    </div>
                </div>
            </div>
            <br>
            <div class="row">
                <div class="col-lg-5">
                    <label class="pull-left">To Recovery</label>
                </div>
                <div class="col-lg-7">
                    <div id="piecesToRecovery" class="btn-group pull-left toRecovery" role="group">
                    </div>
                </div>
            </div>
            <br>
            <div id="shareDetails" class="row">

            </div>
            </br>
            <button id="recoverKeySubmit" class="btn btn-lg btn-primary btn-block" type="submit">SetUp Key Recovery</button>

        </form>

    </div> <!-- /container -->

</div>

<%--Footer--%>
<jsp:include page="footer.jsp" />

</body>
</html>