<%--
  Created by IntelliJ IDEA.
  User: sameera
  Date: 12/13/2014
  Time: 1:54 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>

    <link rel="icon" href="/img/favicon.ico">

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="DashBoard for Cloud4s">
    <meta name="author" content="Sameera">

    <link href='<c:url value="/css/main.css" />' rel="stylesheet" type="text/css"/>
    <link href='<c:url value="/css/bootstrap.min.css" />' rel="stylesheet" type="text/css"/>
    <link href='<c:url value="/fonts/css/font-awesome.min.css" />' rel="stylesheet" type="text/css"/>




</head>

<script>
    function get_value(){
        var key = localStorage.getItem("${pageContext.request.userPrincipal.name}");
        alert(key);
        if (key!=null){
            return key;
        }
        else{
            div_show();
            var val = $('inputKey').value;
            return val;
        }
    }

    function insert_value(){
        var key = $('inputName').value,
                val = $('inputKey').value;
        localStorage.setItem(key, val);

    }
</script>
<body>
<sec:authorize access="hasRole('ROLE_USER')">
    <!-- For login user -->
    <c:url value="/j_spring_security_logout" var="logoutUrl" />
    <form action="${logoutUrl}" method="post" id="logoutForm">
        <input type="hidden" name="${_csrf.parameterName}"
               value="${_csrf.token}" />
    </form>

    <script>
        function logOut() {
            $('#logoutForm').submit();
        }

    </script>

</sec:authorize>
<!-- Navigation -->
<nav class="navbar navbar-default navbar-fixed-top navbar-custom" role="navigation">
    <div class="container">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="/#" style="color: #ffffff"><img src="/img/cloud_globe.png" style="height: 60px; margin-top: -15px;"></a>
        </div>
        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav navbar-right navbar-custom">

                <li style="display:${pageContext.request.userPrincipal.name == null ? 'none' : 'block'};">
                    <a href="/dash">DashBoard</a>
                </li>
                <li id="serviceTab">
                    <a href="/#secA">Services</a>
                </li>
                <li id="contactTab">
                    <a href="/#secB">Contact</a>
                </li>
               <li style="display:${pageContext.request.userPrincipal.name == null ? 'none' : 'block'}; margin-top: 15px">
                    ${pageContext.request.userPrincipal.name}
               </li>
                <li style="display:${pageContext.request.userPrincipal.name == null ? 'none' : 'block'}">
                    <a href="javascript:logOut()">Logout</a>
                </li>

            </ul>
        </div>
        <!-- /.navbar-collapse -->
    </div>
    <!-- /.container -->
</nav>



</body>
</html>
