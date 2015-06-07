<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html lang="en">
<head>

    <title>SignUp - Cloud4s</title>
    <link href='<c:url value="/css/login.css" />' rel="stylesheet" type="text/css"/>

    <script src="/js/jquery.js"></script>

    <!--AES sripts-->
    <script src="js/aes/aes.js"></script>
    <script src="js/aes/aes-ctr.js"></script>
    <script src="js/aes/aes-ctr-file.js"></script>
    <script src="js/aes/file-saver.js"></script>
    <script src="js/aes/mtl.js"></script>

    <script src="js/aes/prettify.js"></script>
    <script language="JavaScript" type="text/javascript" src="js/rsa/rsa_pack.js"></script>
    <script src="js/main.js"></script>

    <script>
        function setEnable(){
            document.getElementById("b_signup").disabled = false;
        }
        function setDisable(){
            document.getElementById("b_signup").disabled = true;
        }
        function myFunction(val) {
            console.log("Master Key :"+val);
            var MasterKey = val;
            var crypt = new JSEncrypt();
            var pvt = crypt.getPrivateKey();
            var pub = crypt.getPublicKey();
            var encryptedPvt = Aes.Ctr.encrypt(pvt,MasterKey,256);
            $('#privateKey').val(encryptedPvt);
            $('#publicKey').val(pub);
        }

        function insert_value(){
            var valBrowser = document.getElementById('inputKey').value;
            localStorage.setItem("cloud4s_"+document.getElementById('inputName').value, valBrowser);
        }

    </script>
</head>

<body>

<%--Header--%>
<jsp:include page="header.jsp" />

<%--Content--%>
<div class="intro-header">
<div class="container login-box">

    <form class="form-signin" method="get" action="<c:url value='/saveuser' />" >

        <label for="inputEmail" >Name</label><br>
        <label class="row" id="duplicateAlert" hidden="hidden" style="color: red;">*UserName already exist.</label>
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
            <input id="privateKey" class="form-control col-lg-8" name="privateKey" required=""  type="hidden" >
        </div>
        </br>
        <button id="b_signup" class="btn btn-lg btn-primary btn-block" type="submit" onclick="insert_value()" disabled>Sign up</button>

    </form>

</div> <!-- /container -->
</div>

<%--Footer--%>
<jsp:include page="footer.jsp" />
<script>
    $(document).ready(function(){
        $('#inputName').change(function(){

            $.ajax({
                type : "GET",
                url : "getAllUsers",
                success : function(response) {
                    var isDuplicate=false;

                    for(i=0; i<response.length; i++){
                        var value=$('#inputName').val();
                        var user=response[i];
                        if(user==value){
                            isDuplicate=true;
                            $('#duplicateAlert').show();
                            setDisable();
                            break;
                        }
                    }
                    if(!isDuplicate){
                        $('#duplicateAlert').hide();
                        setEnable();
                    }
                },
                error : function(e) {
                    console.log(JSON.stringify(e));
                    return [];
                }
            });
        });
    });
</script>
</body>
</html>