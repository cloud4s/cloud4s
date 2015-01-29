<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html lang="en">

<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="Sign up for cloud4s">
    <meta name="author" content="Sameera">
    <link rel="icon" href="http://getbootstrap.com/favicon.ico">

    <title>DropBox Authentication</title>

    <link href="css/bootstrap.css" rel="stylesheet">
    <link href="css/main.css" rel="stylesheet">

    <script>

        setInterval(loadUrl(),1000);
        function loadUrl(){

            var url=document.getElementById('TokenUrl').value;
            if(url!="null") {
//                alert(url);
                var win = window.open(url, '_blank');
                win.focus();
            }
        }
    </script>

</head>

<body onload="loadUrl()">

<%--Header--%>
<jsp:include page="header.jsp" />

<%--Content--%>
<div class="intro-header">

    <div class="container login-box">

        <form class="form-signin" method="get" action="<c:url value='/dash' />" >

            <input id="inputkey" class="form-control" name="inputkey" placeholder="Key" required="" autofocus="" type="text">
            <button class="btn btn-lg btn-primary btn-block" type="submit">Go Dashboard</button>

        </form>
        <input id="TokenUrl" class="form-control" name="TokenUrl" value="${TokenUrl}" required="" autofocus="" type="hidden" >
        <%--<label>${TokenUrl}</label>--%>
        <%--<title>${TokenUrl}</title>--%>
    </div>

</div>

<%--Footer--%>
<jsp:include page="footer.jsp" />

</body>

</html>