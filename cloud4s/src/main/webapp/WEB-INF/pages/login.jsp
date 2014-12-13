<%--
  Created by IntelliJ IDEA.
  User: hp
  Date: 12/3/2014
  Time: 5:39 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page session="true"%>
<html>
<head>
    <title>SignIn - Cloud4s</title>
    <link href='<c:url value="/css/login.css" />' rel="stylesheet" type="text/css"/>
    <link href='<c:url value="/css/bootstrap.css" />' rel="stylesheet" type="text/css"/>
    <link href='<c:url value="/css/main.css" />' rel="stylesheet" type="text/css"/>
    <link href='<c:url value="/css/landing-page.css" />' rel="stylesheet" type="text/css"/>

    <link href="css/bootstrap.css" rel="stylesheet">

    <link href="fonts/css/font-awesome.min.css" rel="stylesheet" type="text/css">

</head>
<body onload='document.loginForm.username.focus();'>
<jsp:include page="header.jsp" />
<%--<h1>Spring Security Login Form (Database Authentication)</h1>--%>
<div class="intro-header">

<div id="login-box" class="container">

    <h4>Cloud4S Logging</h4>

    <c:if test="${not empty error}">
        <div class="error">${error}</div>
    </c:if>
    <c:if test="${not empty msg}">
        <div class="msg">${msg}</div>
    </c:if>

    <form class="form-signin" name='loginForm' action="<c:url value='/j_spring_security_check' />" method='POST'>

        <table>
            <%--<tr style="border-bottom: 1px solid #000000">--%>
            <tr>
                <td><b>User Name</b></td>
                <td>
                    <div class="input-group">
                        <span class="input-group-addon glyphicon-user"></span>
                        <input type='text' name='username' class="form-control" placeholder="Email" required="" autofocus="">
                    </div>
                </td>
            </tr>
            <tr>
                <td><b>Password</b></td>
                <td>
                    <div class="input-group">
                        <span class="input-group-addon glyphicon-lock"></span>
                        <input type='password' name='password' class="form-control" placeholder="Password" required="" />
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="checkbox">
                        <label> <input value="remember-me" type="checkbox"> Remember</label>
                    </div>
                </td>
            </tr>
            <tr>
                <td colspan='2'><input name="submit" type="submit"
                                       value="submit" class="btn btn-lg btn-primary btn-block" /></td>
            </tr>

        </table>

        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

    </form>
</div>

</div>
</body>
</html>