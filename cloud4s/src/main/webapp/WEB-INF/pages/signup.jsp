<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html lang="en">
<head>

    <link rel="icon" href="http://getbootstrap.com/favicon.ico">

    <title>SignUp - Cloud4s</title>

</head>

<body>

<%--Header--%>
<jsp:include page="header.jsp" />

<%--Content--%>
<div class="intro-header">
<div class="container login-box">

    <form class="form-signin" method="get" action="<c:url value='/saveuser' />" >

        <label for="inputEmail" >Name</label>
        <input id="inputName" class="form-control" name="inputName" placeholder="Name" required="" autofocus="" type="text">
        <label for="inputEmail" >Email</label>
        <input id="inputEmail" class="form-control" name="inputEmail"placeholder="Email" required="" autofocus="" type="email">
        <label for="inputPassword" >Password</label>
        <input id="inputPassword" class="form-control" name="inputPassword" placeholder="Password" required="" type="password">
        <label for="inputPassword2" >Retype Password</label>
        <input id="inputPassword2" class="form-control" placeholder="Re-Password" required="" type="password">
        <label for="inputKey" >Encryption Key</label>
        <div>
            <input id="inputKey" class="form-control col-lg-8" name="inputKey" placeholder="Encryption Key" required="" type="password">
            <label id="inputKeyDescription" class="info-label" title="why encryption key"> ?</label>
        </div>
        </br>
        <button class="btn btn-lg btn-primary btn-block" type="submit">Sign up</button>
        <%--<input name="submit" type="submit"--%>
               <%--value="submit" class="btn btn-lg btn-primary btn-block" />--%>

    </form>

</div> <!-- /container -->
</div>

<%--Footer--%>
<jsp:include page="footer.jsp" />

</body>
</html>