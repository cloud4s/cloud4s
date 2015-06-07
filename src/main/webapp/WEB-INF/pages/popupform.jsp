<%--
  Created by IntelliJ IDEA.
  User: hp
  Date: 12/7/2014
  Time: 12:13 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Popup contact form</title>
    <link href="/css/elements.css" rel="stylesheet">
    <script src="/js/popup.js"></script>
</head>
<!-- Body Starts Here -->
<body id="body" style="overflow:hidden;">
<div id="abc">
    <!-- Popup Div Starts Here -->
    <div id="popupContact">
        <!-- Contact Us Form -->
        <form action="#" id="form" method="post" name="form">
            <img id="close" src="images/3.png" onclick ="div_hide()">
            <h2>Contact Us</h2>
            <hr>
            <input id="name" name="name" placeholder="Name" type="text">
            <input id="email" name="email" placeholder="Email" type="text">
            <textarea id="msg" name="message" placeholder="Message"></textarea>
            <a href="javascript:check_empty()" id="submit">Send</a>
        </form>
    </div>
    <!-- Popup Div Ends Here -->
</div>
<!-- Display Popup Button -->
<h1>Click Button To Popup Form Using Javascript</h1>
<button id="popup" onclick="div_show()">Popup</button>
</body>
<!-- Body Ends Here -->
</html>
