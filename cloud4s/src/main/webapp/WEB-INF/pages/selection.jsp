<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="sec"
          uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="en">

<head>

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
        </div>
    </div>
    </div>

<%--Footer--%>
<jsp:include page="footer.jsp" />

</body>

</html>
