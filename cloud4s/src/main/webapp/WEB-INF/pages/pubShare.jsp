<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="en">

<head>
    <title>Public Share</title>
    <script src='<c:url value="/js/jquery.js" />' type="text/javascript"></script>
    <script src='<c:url value="/js/jquery-ui.js" />' type="text/javascript"></script>
    <!--AES sripts-->
    <script src="js/aes/aes.js"></script>
    <script src="js/aes/aes-ctr.js"></script>
    <script src="js/aes/aes-ctr-file.js"></script>
    <script src="js/aes/file-saver.js"></script>
    <script src="js/aes/mtl.js"></script>
    <script src="js/aes/prettify.js"></script>
    <%-----------------------------%>
    <!--RSA scripts-->
    <script language="JavaScript" type="text/javascript" src="js/rsa/rsa_pack.js"></script>
    <%---------------------------%>

    <%--Can be requied--%>
    <script src="js/FileSaver.js"></script>
</head>

<body>

<%--Header--%>
<jsp:include page="header.jsp" />

<%--Content--%>
<div class="intro-header">

    <div class="container login-box">
        <div class="row">
            <div class="col-lg-4"><label>Enter your Key</label></div>
            <div class="col-lg-8">
                <textarea id="secretKey" type="text" style="width: 93%; height: 80px;" placeholder="Your Secret key"></textarea>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-4"><label>Select File to decrypt</label></div>
            <div class="col-lg-8">
                <span class="btn btn-default btn-file">
                    Download
                    <input id="decryptBtn" onclick="decryptFileAndDownload()" type="submit">
                </span>
            </div>
        </div>

        <%--<button class="btn btn-lg btn-primary btn-block" href="${fileUrl}"--%>
                <%--onclick="decryptFileAndDownload()">Download</button>--%>
    </div>
</div>
<div>
    <input id="fileName" type="text" value="${fileName}">
    <input id="fileUrl" type="text" value="${fileUrl}">
    <input id="enFileKey" type="text" value="${enFileKey}">

</div>

        <button class="btn btn-lg btn-primary btn-block" onclick="decryptFileAndDownload()">Download</button>
    </div>

</div>


<%--Footer--%>
<jsp:include page="footer.jsp" />
<script>

    function decryptFileAndDownload(){//decrypt the downloaded file..
        var encryptedKey= ($('#enFileKey').val());//set encrpted file key from the received url..
        var secretkey = ($('#secretKey').val());//set secret key entered by the receiver..
        var fileName = $('#fileName').val().trim();//set the file name from the received url..
        var fileURL= $('#fileUrl').val().trim();//set the dropbox url from the received url..

        $.ajax({
            type : "Get",
            url : "getPublicShareFileContent",
            dataType : "json",
            cache : false ,
            contentType : 'application/json; charset=utf-8',
            data : "fileUrl=" + fileURL,
            success : function(response) {
                var enfileContent = response["fileContent"];
                // Decrypt with the private key...
                var decrypt = new JSEncrypt();
                decrypt.setPrivateKey(secretkey);
                var fileKey = decrypt.decrypt(encryptedKey.replace(/ /g, '+'));
                console.log("encryptedKey :"+encryptedKey);
                console.log("secretkey :"+secretkey);
                console.log("Decrypted File key : "+fileKey);
                if((fileKey != null)&& (fileKey != false) ){
                    saveFile(enfileContent,fileName,fileKey);
                }
            },
            error : function(e) {
                console.log(JSON.stringify(e));
            }
        });
    }

    function saveFile(data,fileName,fileKey){
        var filename = fileName.replace(/\.encrypted$/,'');//remove the extention '.ecrypted' from file name..
        var decryptedData = Aes.Ctr.decrypt(data,fileKey,256);//decrypte file content from file key..
        console.log("Decrypted data: "+decryptedData);
        // convert single-byte character stream to ArrayBuffer bytestream
        var contentBytes = new Uint8Array(decryptedData.length);
        for (var i=0; i<decryptedData.length; i++) {
            contentBytes[i] = decryptedData.charCodeAt(i);
        }
        var blob = new Blob([contentBytes], {type: 'application/octet-stream'});//create the blob..
        saveAs(blob, filename);
    }
    $(document).ready(function(){

    });

    function decryptFileAndDownload(){
        //those fileURL and decryptedKey should be send via publicShare controller in maincontroller
        //var fileURL=
        //var decryptedKey=

    }
</script>
</body>

</html>