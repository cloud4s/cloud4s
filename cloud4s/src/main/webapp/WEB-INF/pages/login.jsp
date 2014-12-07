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

    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/sb-admin.css" rel="stylesheet">
    <link href="css/plugins/morris.css" rel="stylesheet">
    <link href="fonts/css/font-awesome.min.css" rel="stylesheet" type="text/css">

</head>
<body onload='document.loginForm.username.focus();'>

<%--<h1>Spring Security Login Form (Database Authentication)</h1>--%>

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
            <tr>
                <td>UserName:</td>
                <td><input type='text' name='username' class="form-control" placeholder="Email" required="" autofocus=""></td>
            </tr>
            <tr>
                <td>Password:</td>
                <td><input type='password' name='password' class="form-control" placeholder="Password" required="" /></td>
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

</body>
</html>