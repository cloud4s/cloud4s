<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html lang="en">

<head>
    <title>Public Share</title>
</head>

<body>

<%--Header--%>
<jsp:include page="header.jsp" />

<%--Content--%>
<div class="intro-header">

    <div class="container login-box">

        <button class="btn btn-lg btn-primary btn-block" onclick="decryptFileAndDownload()">Download</button>
    </div>

</div>

<%--Footer--%>
<jsp:include page="footer.jsp" />
<script>
    $(document).ready(function(){

    });

    function decryptFileAndDownload(){
        //those fileURL and decryptedKey should be send via publicShare controller in maincontroller
        //var fileURL=
        //var decryptedKey=

    }
</script>
</body>

</html>