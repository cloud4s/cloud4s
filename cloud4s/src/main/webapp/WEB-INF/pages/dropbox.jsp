<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html lang="en">

<head>

    <link rel="icon" href="http://getbootstrap.com/favicon.ico">

    <title>DropBox Authentication</title>

</head>

<body>

<%--Header--%>
<jsp:include page="header.jsp" />

<%--Content--%>
<div class="intro-header">

    <div class="container login-box">

        <form class="form-signin" method="get" action="<c:url value='/dash' />" >

            <input id="inputkey" class="form-control" name="inputkey" placeholder="Key" required="" autofocus="" type="text">
            <button class="btn btn-lg btn-primary btn-block" type="submit">Go Dashboard</button>

        </form>

    </div>

</div>

<%--Footer--%>
<jsp:include page="footer.jsp" />

</body>

</html>