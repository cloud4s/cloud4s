<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="sec"
          uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="en">

<head>

    <title>DashBoard - Cloud4s</title>

    <link href='<c:url value="/css/dashboard.css" />' rel="stylesheet" type="text/css"/>

    <script src="js/dashboard.js"></script>

    <!--AES sripts-->
    <script src="js/aes/jquery.js"></script>
    <script src="js/aes/aes.js"></script>
    <script src="js/aes/aes-ctr.js"></script>
    <script src="js/aes/aes-ctr-file.js"></script>
    <script src="js/aes/file-saver.js"></script>
    <script src="js/aes/mtl.js"></script>
    <script src="js/aes/prettify.js"></script>

    <!--RSA scripts-->
    <script src="js/rsa/aes.js"></script>
    <script src="js/rsa/rsa.js"></script>
    <script src="js/rsa/api.js"></script>
    <script src="js/rsa/cryptico.js"></script>
    <script src="js/rsa/cryptico.min.js"></script>
    <script src="js/rsa/hash.js"></script>
    <script src="js/rsa/jsbn.js"></script>
    <script src="js/rsa/random.js"></script>
    <script src="js/rsa/jsencrypt.js"></script>

    <sec:authorize access="hasRole('ROLE_USER')">
        <c:url value="/upload" var="uploadUrl" />
        <form action="${uploadUrl}" method="get" id="uploadForm">
            <input id="fileName" name="fileName" type="hidden" value=""/>
        </form>
    </sec:authorize>

</head>

<body onload="harshikaAjax()">
<%--Header--%>
<jsp:include page="header.jsp" />
<%--Body Content--%>
<div class="intro-header">

    <div class="container">
        <%--<a href="javascript:formSubmit()"><i class="fa fa-fw fa-power-off"></i> Log Out</a>--%>

        <!-- Sidebar Menu Items  -->
        <div class="collapse navbar-collapse navbar-ex1-collapse">
            <ul class="nav navbar-nav side-nav">
                <li>
                    <input name="password-file" id="password-encrpt" value="1234" type="text" hidden="hidden">
                        <span class="btn btn-default btn-file">
                            Upload
                            <input name="src-file" id="src-file" onchange="encryptFile(this.files[0])" type="file">
                        </span>

                </li>
                <li class="active">
                    <a href="dashboard.html"><i class="fa fa-fw fa-dashboard"></i> My Files</a>
                </li>
                <li>
                    <a href="dashboard.html"><i class="fa fa-fw fa-bar-chart-o"></i> Shared</a>
                </li>

            </ul>
        </div>

    </nav>

    <!--Content Area-->
    <div id="page-wrapper">
        <div class="container-fluid">
            <!-- Bread Crumb -->
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header" style="border-bottom: none"> My Files</h1>

                </div>
            </div>
        </div>
    </div>
    <%--list display--%>
    <div class="table-responsive">
    <table id="table" name="table" class="table table-hover table-striped table-condensed">
        <%--<tr>--%>
            <%--<td>Name</td>--%>
            <%--<td>Icon</td>--%>
            <%--<td>Path</td>--%>
        <%--</tr>--%>
    </table>
    </div>
    <%--<div>--%>
        <%--<a href="#" class="btn btn-info btn-lg"><span class="fa fa-download"></span> Search</a>--%>
    <%--</div>--%>
    <%----%>
</div>

</div>
<%--Footer--%>
<jsp:include page="footer.jsp" />

</body>

</html>
<%--
  Created by IntelliJ IDEA.
  User: hp
  Date: 12/4/2014
  Time: 8:25 PM
  To change this template use File | Settings | File Templates.
--%>

