<%--
  Created by IntelliJ IDEA.
  User: udeshi-p
  Date: 12/13/2014
  Time: 1:54 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

</head>
<body>
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
            <a class="navbar-brand" href="/#">Welcome</a>
        </div>
        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav navbar-right">

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
                    <a href="javascript:formSubmit()">Logout</a>
                </li>

            </ul>
        </div>
        <!-- /.navbar-collapse -->
    </div>
    <!-- /.container -->
</nav>
</body>
</html>
