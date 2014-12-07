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

    <title>DashBoard - Cloud4s</title>

    <link href='<c:url value="/css/main.css" />' rel="stylesheet" type="text/css"/>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/sb-admin.css" rel="stylesheet">
    <link href="css/plugins/morris.css" rel="stylesheet">
    <link href="fonts/css/font-awesome.min.css" rel="stylesheet" type="text/css">

    <script src='<c:url value="/js/dropdown.js" />' type="text/javascript"></script>
    <script src='<c:url value="/js/jquery-2.0.0.js" />' type="text/javascript"></script>
    <script src='<c:url value="/js/bootstrap-filestyle-0.1.0.js" />' type="text/javascript"></script>

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

    <script src="js/main.js"></script>

    <sec:authorize access="hasRole('ROLE_USER')">
        <!-- For login user -->
        <c:url value="/j_spring_security_logout" var="logoutUrl" />
        <form action="${logoutUrl}" method="post" id="logoutForm">
            <input type="hidden" name="${_csrf.parameterName}"
                   value="${_csrf.token}" />
        </form>
        <script>
            function formSubmit() {
                $('#logoutForm').submit();
            }
        </script>

    </sec:authorize>


</head>

<body>

<div id="wrapper">

    <!-- Navigation -->
    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
        </div>

        <!-- User dropdown - top menu -->
    <c:if test="${pageContext.request.userPrincipal.name != null}">
        <ul class="nav navbar-right top-nav">
            <li class="dropdown">
                <a href="#" onclick="collapseDropDown()"><i class="fa fa-user"></i>
                 ${pageContext.request.userPrincipal.name}
                 <b class="caret"></b></a>
                <ul id="dropDownMenu"  hidden="true">
                    <li>
                        <a href="#"><i class="fa fa-fw fa-user"></i> Profile</a>
                    </li>
                    <li>
                        <a href="#"><i class="fa fa-fw fa-envelope"></i> Inbox</a>
                    </li>
                    <li>
                        <a href="#"><i class="fa fa-fw fa-gear"></i> Settings</a>
                    </li>
                    <li class="divider"></li>
                    <li>
                        <a href="javascript:formSubmit()"><i class="fa fa-fw fa-power-off"></i> Log Out</a>
                    </li>
                </ul>
            </li>
        </ul>
    </c:if>
        <!-- Sidebar Menu Items  -->
        <div class="collapse navbar-collapse navbar-ex1-collapse">
            <ul class="nav navbar-nav side-nav">
                <li>
                    <input name="password-file" id="password-encrpt" value="1234" type="text" hidden="hidden">

                    <input name="src-file" id="src-file" onchange="encryptFile(this.files[0])" type="file" value="Upload" class="btn btn-lg btn-primary">
                        <%--<input id="uploadButton" value="Upload" class="btn btn-lg btn-primary" width="150px"/>--%>

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
                    <h1 class="page-header"> My Files</h1>
                    <ol class="breadcrumb">
                        <li class="active">
                            <i class="fa fa-dashboard"></i> My Files
                        </li>
                    </ol>
                </div>
            </div>

            <!--File Manager-->
            <div class="row">
                <div class="col-lg-3 col-md-6">
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-xs-3">
                                    <i class="fa fa-comments fa-5x"></i>
                                </div>
                            </div>
                        </div>
                        <a href="#">
                            <div class="panel-footer">
                                <span class="pull-left">Folder 1</span>
                                <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                <div class="clearfix"></div>
                            </div>
                        </a>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="panel panel-green">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-xs-3">
                                    <i class="fa fa-tasks fa-5x"></i>
                                </div>
                            </div>
                        </div>
                        <a href="#">
                            <div class="panel-footer">
                                <span class="pull-left">Folder 2</span>
                                <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                <div class="clearfix"></div>
                            </div>
                        </a>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="panel panel-yellow">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-xs-3">
                                    <i class="fa fa-shopping-cart fa-5x"></i>
                                </div>
                            </div>
                        </div>
                        <a href="#">
                            <div class="panel-footer">
                                <span class="pull-left">Folder 3</span>
                                <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                <div class="clearfix"></div>
                            </div>
                        </a>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="panel panel-red">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-xs-3">
                                    <i class="fa fa-support fa-5x"></i>
                                </div>
                            </div>
                        </div>
                        <a href="#">
                            <div class="panel-footer">
                                <span class="pull-left">Folder 4</span>
                                <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                <div class="clearfix"></div>
                            </div>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


</body>

</html>
<%--
  Created by IntelliJ IDEA.
  User: hp
  Date: 12/4/2014
  Time: 8:25 PM
  To change this template use File | Settings | File Templates.
--%>

