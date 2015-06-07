<%--
  Created by IntelliJ IDEA.
  User: hp
  Date: 12/3/2014
  Time: 5:37 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>

<head>
    <title>No Access - Cloud4s</title>
</head>

<body>
<%--Header--%>
<jsp:include page="header.jsp" />

<%--Body Content--%>
<div class="page403">
    <div>
        <c:choose>
            <c:when test="${empty username}">
                <h2>${message}</h2>
            </c:when>
            <c:otherwise>
                <h2>${username} <br/>${message}</h2>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<%--Footer--%>
<jsp:include page="footer.jsp" />

</body>
</html>
