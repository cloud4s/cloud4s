<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html lang="en"><head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="Sign up for cloud4s">
    <meta name="author" content="Sameera">
    <link rel="icon" href="http://getbootstrap.com/favicon.ico">

    <title>DropBox Authentication</title>

    <link href="css/bootstrap.css" rel="stylesheet">
    <link href="css/main.css" rel="stylesheet">

</head>

<body>

<div class="container">


    <form class="form-signin" method="get" action="<c:url value='/dashboard' />" >

        <label for="inputkey" >Key</label>
        <input id="inputkey" class="form-control" name="inputkey" placeholder="Key" required="" autofocus="" type="text">

        <button class="btn btn-lg btn-primary btn-block" type="submit">Enter</button>
        <%--<input name="submit" type="submit"--%>
        <%--value="submit" class="btn btn-lg btn-primary btn-block" />--%>

    </form>

</div> <!-- /container -->
<script>

</script>
</body></html>