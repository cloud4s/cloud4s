<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html lang="en">
<head>

    <title>SignUp - Cloud4s</title>
    <link href='<c:url value="/css/login.css" />' rel="stylesheet" type="text/css"/>

    <script src="../../js/jquery-2.1.1.min.js"></script>


    <script>
        function setEnable(){
//            alert("hidden elemnet has been set ");
            document.getElementById("b_signup").disabled = false;
        }
        function myFunction(val) {
            document.getElementById("b_signup").disabled = true;
            var PassPhrase =val;
            var Bits = 1024;
            var RSAkey = cryptico.generateRSAKey(PassPhrase, Bits);
            var PublicKeyString = cryptico.publicKeyString(RSAkey);
//            alert("The input value has changed. The new value is: " + PublicKeyString);
            $('#publicKey').val(PublicKeyString);
            setEnable();
        }
    </script>

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

</head>

<body>

<%--Header--%>
<jsp:include page="header.jsp" />

<%--Content--%>
<div class="intro-header">
<div class="container login-box">

<<<<<<< HEAD
    <form class="form-signin" name='signUpForm' method="get" action="<c:url value='/saveuser' />" >
    <table>
        <tr>
            <td><b>Name</b></td>
            <td>
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-fw fa-user"></i></span>
                    <input type='text' name="inputName" class="form-control" placeholder="Name" required="" />
                </div>
            </td>
        </tr>
        <tr>
            <td><b>Email</b></td>
            <td>
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-fw fa-envelope"></i></span>
                    <input type='email' name="inputEmail" class="form-control" placeholder="Email" required="" />
                </div>
            </td>
        </tr>
        <tr>
            <td><b>Password</b></td>
            <td>
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-fw fa-lock"></i></span>
                    <input type='password' name="inputPassword" class="form-control" placeholder="Password" required="" />
                </div>
            </td>
        </tr>
        <tr>
            <td><b>Retype Password</b></td>
            <td>
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-fw fa-lock"></i></span>
                    <input type='password' name="inputName" class="form-control" placeholder="Password" required="" />
                </div>
            </td>
        </tr>
        <tr>
            <td><b>Encryption Key</b></td>
            <td>
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-fw fa-key"></i></span>
                    <input type='text' name="inputKey" class="form-control" placeholder="Master Key" required="" />
                </div>
                <label class="info-label" title="This key is the master key which is used to encrypt and decrypt your files"> ?</label>
            </td>
        </tr>

        <tr>
            <td colspan='2'><input name="submit" type="submit" value="Sign Up" class="btn btn-lg btn-primary btn-block" /></td>
        </tr>
    </table>

=======
    <form class="form-signin" method="get" action="<c:url value='/saveuser' />" >

        <label for="inputEmail" >Name</label>
        <input id="inputName" class="form-control" name="inputName" placeholder="Name" required="" autofocus="" type="text">
        <label for="inputEmail" >Email</label>
        <input id="inputEmail" class="form-control" name="inputEmail"placeholder="Email" required="" autofocus="" type="email">
        <label for="inputPassword" >Password</label>
        <input id="inputPassword" class="form-control" name="inputPassword" placeholder="Password" required="" type="password">
        <label for="inputPassword2" >Retype Password</label>
        <input id="inputPassword2" class="form-control" placeholder="Re-Password" required="" type="password">
        <label for="inputKey" >Encryption Key</label>
        <div>
            <input id="inputKey" class="form-control col-lg-8" name="inputKey" placeholder="Encryption Key" required="" type="password" onchange="myFunction(this.value)">
            <label id="inputKeyDescription" class="info-label" title="why encryption key"> ?</label>
            <input id="publicKey" class="form-control col-lg-8" name="publicKey" required=""  type="hidden" >
        </div>
        </br>
        <button id="b_signup" class="btn btn-lg btn-primary btn-block" type="submit" disabled>Sign up</button>
        <%--<input name="submit" type="submit"--%>
               <%--value="submit" class="btn btn-lg btn-primary btn-block" />--%>
>>>>>>> no message

    </form>

</div> <!-- /container -->
</div>

<%--Footer--%>
<jsp:include page="footer.jsp" />

</body>
</html>