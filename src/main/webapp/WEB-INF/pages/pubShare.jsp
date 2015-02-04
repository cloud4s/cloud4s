<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="sec"
          uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="en">

<head>
    <title>Public Share</title>
    <!--AES sripts-->
    <script src="js/aes/aes.js"></script>
    <script src="js/aes/aes-ctr.js"></script>
    <script src="js/aes/aes-ctr-file.js"></script>
    <script src="js/aes/file-saver.js"></script>
    <script src="js/aes/mtl.js"></script>
    <script src="js/aes/prettify.js"></script>
    <!--RSA scripts-->
    <script src="js/rsa/jsencrypt.min.js"></script>

    <%--Can be requied--%>
    <script src="js/FileSaver.js"></script>
</head>

<body onload="downloadEncryptedFile()">

<%--Header--%>
<jsp:include page="header.jsp" />

<%--Content--%>
<div class="intro-header">

    <div class="container login-box">

        <button class="btn btn-lg btn-primary btn-block" href="${fileUrl}"
                onclick="decryptFileAndDownload()">Download</button>
    </div>

</div>
<div>
    <input id="fileName" type="text" value="${fileName}">
    <input id="fileUrl" type="text" value="${fileUrl}">
    <input id="enFileKey" type="text" value="${enFileKey}">
    <textarea id="secretKey" type="text" placeholder="Your Secret key"></textarea>
</div>

<%--Footer--%>
<jsp:include page="footer.jsp" />
<script>

    function downloadEncryptedFile(){
        var fileURL= $('#fileUrl').val().trim();
        window.open(fileURL);
    }

    function decryptFileAndDownload(){
        var encryptedKey= $('#enFileKey').val().trim().replace(/\s+/g,'');
        var secretkey = $('#secretKey').val().trim().replace(/\s+/g,'');
        var fileName = $('#fileName').val().trim().replace(/\s+/g,'');

        // Decrypt with the private key...
        var decrypt = new JSEncrypt();
        decrypt.setPrivateKey(secretkey);
        var fileKey = decrypt.decrypt(encryptedKey);
        console.log("encryptedKey :"+encryptedKey);
        console.log("secretkey :"+secretkey);
        console.log("Decrypted File key : "+fileKey);
        publicFileDownload(fileKey,fileName);
    }

    function publicFileDownload(fileKey,filename){
        alert("Public file download : "+filename);
        $.ajax({
            url:'getFile.html',
            type:"GET",
            contentType: "application/json; charset=utf-8",
            data: "filename=" +filename, //Stringified Json Object
            async: false, //Cross-domain requests and dataType: "jsonp" requests do not support synchronous operation
            cache: false, //This will force requested pages not to be cached by the browser
            processData:false, //To avoid making query String instead of JSON
            success: function(data){
                var json = JSON.parse(data);
                saveDownloadFile(fileKey,data.replace(/\s+/g,''),filename);
            }});
    }

    function saveDownloadFile(fileKey,data,fileName){
        var filename = fileName.replace(/\.encrypted$/,'');
        var decryptedData = Aes.Ctr.decrypt(data,fileKey,256);
        alert("File Name :"+fileName);
        // convert single-byte character stream to ArrayBuffer bytestream
        var contentBytes = new Uint8Array(decryptedData.length);
        for (var i=0; i<decryptedData.length; i++) {
            contentBytes[i] = decryptedData.charCodeAt(i);
        }
        var blob = new Blob([contentBytes], { type: 'application/octet-stream' });
        saveAs(blob, filename);
    }

</script>
</body>

</html>