<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="sec"
          uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="en">

<head>

    <script src="../../js/jstorage.js"></script>
    <title>Selection - Cloud4s</title>

</head>

<body>
<%--Header--%>
<jsp:include page="header.jsp" />
<%--Content--%>
<div class="intro-header">

    <div class="container">
        <div class="row">

            <%--images.................--%>
            <a href="/dropbox"><img class="img-thumbnail img-adjust" src="/img/dropbox.png" alt="Drop Box"></a>
            <a href=""><img class="img-thumbnail img-adjust" src="/img/drive.png"  alt="Drive"></a>
            <a href=""><img class="img-thumbnail img-adjust" src="/img/skydrive.png" alt="Sky Drive"></a>
            <a href=""><img class="img-thumbnail img-adjust"src="/img/amazone.png" alt="Drop Box advanced"></a>
                <td colspan='2'><input name="submit" type="submit"  hidden="hidden"
                                       value="submit" class="btn btn-lg btn-primary btn-block" onclick="get_value()"/></td>

        </div>
    </div>
    </div>
<div id="abc">
    <!-- Popup Div Starts Here -->
    <div id="popupContact">
        <!-- Contact Us Form -->
        <form action="#" id="form"  name="form">
            <img id="close" src="/img/3.png" onclick ="div_hide()">
            <h5>Your key is missing in browser! Please enter the key</h5>

            <hr>
            <input id="inputName" name="inputName" placeholder="Name" type="text" value="${pageContext.request.userPrincipal.name}">
            <input id="inputKey" name="inputKey" placeholder="Key" type="text">
            <h5>-------------------------------</h5>

            <button class="btn btn-lg btn-primary btn-block"  onclick="insert_value()">Save</button>
        </form>
    </div>
    <!-- Popup Div Ends Here -->
</div>
<%--Footer--%>
<jsp:include page="footer.jsp" />

</body>

</html>
