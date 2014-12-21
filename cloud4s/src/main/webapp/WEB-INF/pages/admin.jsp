<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page session="true"%>
<html>
<body>

<c:if test="${pageContext.request.userPrincipal.name != null}">
    <h2>
        ${pageContext.request.userPrincipal.name}'s admin page.
    </h2>
</c:if>

</body>
</html>