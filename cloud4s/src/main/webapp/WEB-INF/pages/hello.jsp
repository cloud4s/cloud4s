<%--
  Created by IntelliJ IDEA.
  User: hp
  Date: 12/3/2014
  Time: 5:39 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="sec"
          uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <title>Welcome - Cloud4s</title>

    <link href='<c:url value="/css/main.css" />' rel="stylesheet" type="text/css"/>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/sb-admin.css" rel="stylesheet">
    <link href="css/plugins/morris.css" rel="stylesheet">
    <link href="fonts/css/font-awesome.min.css" rel="stylesheet" type="text/css">


    <script src='<c:url value="/js/jquery-2.0.0.js" />' type="text/javascript"></script>
</head>

<body>
<div id="center-content">

<%--content--%>
<p class="large-heading">${message}</p>
<a href="/login"><input value="Login" class="btn btn-lg btn-primary" width="200px" /></a>

<sec:authorize access="hasRole('ROLE_USER')">
    <!-- For login user -->
    <c:url value="/j_spring_security_logout" var="logoutUrl" />
    <form action="${logoutUrl}" method="post" id="logoutForm">
        <input type="hidden" name="${_csrf.parameterName}"
               value="${_csrf.token}" />
    </form>
    <script>
        function formSubmit() {
            document.getElementById("logoutForm").submit();
        }
    </script>

    <c:if test="${pageContext.request.userPrincipal.name != null}">
        <h2>
            User : ${pageContext.request.userPrincipal.name} | <a
                href="javascript:formSubmit()"> Logout</a>
        </h2>
    </c:if>
    <a href="http://www.w3schools.com">Visit W3Schools.com!</a>

</sec:authorize>
    </div>
</body>
</html>