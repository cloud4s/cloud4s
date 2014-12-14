<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="sec"
          uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="DashBoard for Cloud4s">
    <meta name="author" content="Sameera">

    <title>Selection - Cloud4s</title>

    <link href='<c:url value="/css/main.css" />' rel="stylesheet" type="text/css"/>
    <link href='<c:url value="/css/bootstrap.min.css" />' rel="stylesheet" type="text/css"/>
    <link href='<c:url value="/css/landing-page.css" />' rel="stylesheet" type="text/css"/>
    <link href='<c:url value="/fonts/css/font-awesome.min.css" />' rel="stylesheet" type="text/css"/>

    <%--logout --%>
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
    </sec:authorize>

</head>

<body>
<%--Header--%>
<jsp:include page="header.jsp" />
<%--Content--%>
<div class="intro-header">

    <div class="container">
            <!-- User dropdown - top menu -->
            <%--<c:if test="${pageContext.request.userPrincipal.name != null}">--%>
                <%--<ul class="nav navbar-right top-nav">--%>
                    <%--<li class="dropdown">--%>
                        <%--<a href="#" onclick="collapseDropDown()" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user"></i>--%>
                                <%--${pageContext.request.userPrincipal.name}--%>
                            <%--<b class="caret"></b></a>--%>
                        <%--<ul id="dropDownMenu"  hidden="true">--%>
                            <%--<li>--%>
                                <%--<a href="#"><i class="fa fa-fw fa-user"></i> Profile</a>--%>
                            <%--</li>--%>
                            <%--<li>--%>
                                <%--<a href="#"><i class="fa fa-fw fa-envelope"></i> Inbox</a>--%>
                            <%--</li>--%>
                            <%--<li>--%>
                                <%--<a href="#"><i class="fa fa-fw fa-gear"></i> Settings</a>--%>
                            <%--</li>--%>
                            <%--<li class="divider"></li>--%>
                            <%--<li>--%>
                                <%--<a href="javascript:formSubmit()"><i class="fa fa-fw fa-power-off"></i> Log Out</a>--%>
                            <%--</li>--%>
                        <%--</ul>--%>
                    <%--</li>--%>
                <%--</ul>--%>
            <%--</c:if>--%>


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
