<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html lang="en">
<head>

    <title>SignUp - Cloud4s</title>
    <link href='<c:url value="/css/login.css" />' rel="stylesheet" type="text/css"/>

</head>

<body>

<%--Header--%>
<jsp:include page="header.jsp" />

<%--Content--%>
<div class="intro-header">
<div class="container login-box">

    <form class="form-signin" name='signUpForm' method="get" action="<c:url value='/saveuser' />" >
    <table>
        <tr>
            <td><b>Name</b></td>
            <td>
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-fw fa-user"></i></span>
                    <input type='text' name="inputName" class="form-control" placeholder="Name" required="" />
                </div>
            </td>
        </tr>
        <tr>
            <td><b>Email</b></td>
            <td>
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-fw fa-envelope"></i></span>
                    <input type='email' name="inputEmail" class="form-control" placeholder="Email" required="" />
                </div>
            </td>
        </tr>
        <tr>
            <td><b>Password</b></td>
            <td>
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-fw fa-lock"></i></span>
                    <input type='password' name="inputPassword" class="form-control" placeholder="Password" required="" />
                </div>
            </td>
        </tr>
        <tr>
            <td><b>Retype Password</b></td>
            <td>
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-fw fa-lock"></i></span>
                    <input type='password' name="inputName" class="form-control" placeholder="Password" required="" />
                </div>
            </td>
        </tr>
        <tr>
            <td><b>Encryption Key</b></td>
            <td>
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-fw fa-key"></i></span>
                    <input type='text' name="inputKey" class="form-control" placeholder="Master Key" required="" />
                </div>
                <label class="info-label" title="This key is the master key which is used to encrypt and decrypt your files"> ?</label>
            </td>
        </tr>

        <tr>
            <td colspan='2'><input name="submit" type="submit" value="Sign Up" class="btn btn-lg btn-primary btn-block" /></td>
        </tr>
    </table>


    </form>

</div> <!-- /container -->
</div>

<%--Footer--%>
<jsp:include page="footer.jsp" />

</body>
</html>