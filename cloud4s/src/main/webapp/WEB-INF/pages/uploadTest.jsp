<%--
  Created by IntelliJ IDEA.
  User: hp
  Date: 1/27/2015
  Time: 8:44 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Upload Test</title>
    <script src="../../js/dropzone.js"></script>
    <link href='<c:url value="/css/dropzone.css" />' rel="stylesheet" type="text/css"/>
    <link href='<c:url value="/css/bootstrap.min.css" />' rel="stylesheet" type="text/css"/>
    <script>
        $(document).ready(function() {

            $(".file-dropzone").on('dragover', handleDragEnter);
            $(".file-dropzone").on('dragleave', handleDragLeave);
            $(".file-dropzone").on('drop', handleDragLeave);

            function handleDragEnter(e) {

                this.classList.add('drag-over');
            }

            function handleDragLeave(e) {

                this.classList.remove('drag-over');
            }

            // "dropzoneForm" is the camel-case version of the form id "dropzone-form"
            Dropzone.options.dropzoneForm = {

                url : "fileupload", // not required if the <form> element has action attribute
                autoProcessQueue : false,
                uploadMultiple : true,
                maxFilesize : 256, // MB
                parallelUploads : 100,
                maxFiles : 100,
                addRemoveLinks : true,
                previewsContainer : ".dropzone-previews",

                // The setting up of the dropzone
                init : function() {

                    var myDropzone = this;

                    // first set autoProcessQueue = false
                    $('#upload-button').on("click", function(e) {

                        myDropzone.processQueue();
                    });

                    // customizing the default progress bar
                    this.on("uploadprogress", function(file, progress) {

                        progress = parseFloat(progress).toFixed(0);

                        var progressBar = file.previewElement.getElementsByClassName("dz-upload")[0];
                        progressBar.innerHTML = progress + "%";
                    });

                    // displaying the uploaded files information in a Bootstrap dialog
                    this.on("successmultiple", function(files, serverResponse) {
                        showInformationDialog(files, serverResponse);
                    });
                }
            }


            function showInformationDialog(files, objectArray) {

                var responseContent = "";

                for (var i = 0; i < objectArray.length; i++) {

                    var infoObject = objectArray[i];

                    for ( var infoKey in infoObject) {
                        if (infoObject.hasOwnProperty(infoKey)) {
                            responseContent = responseContent + " " + infoKey + " -> " + infoObject[infoKey] + "<br>";
                        }
                    }
                    responseContent = responseContent + "<hr>";
                }

                // from the library bootstrap-dialog.min.js
                BootstrapDialog.show({
                    title : '<b>Server Response</b>',
                    message : responseContent
                });
            }

        });
    </script>
</head>
<body>
<div class="container">
    <div class="panel panel-default">
        <div class="panel-heading text-center">
            <h3>Spring MVC + Dropzone.js Example</h3>
        </div>
        <div class="panel-body">
            <div>
                <form id="dropzone-form" class="dropzone"
                      enctype="multipart/form-data" action="fileupload">

                    <div class="dz-default dz-message file-dropzone text-center well col-sm-12">
                        <span class="glyphicon glyphicon-paperclip"></span> <span>
                                                       To attach files, drag and drop here</span><br>
                        <span>OR</span><br>
                        <span>Just Click</span>
                    </div>

                    <!-- this is were the previews should be shown. -->
                    <div class="dropzone-previews"></div>
                </form>
                <hr>

                <button id="upload-button" class="btn btn-primary">
                    <span class="glyphicon glyphicon-upload"></span> Upload
                </button>
                <a class="btn btn-primary pull-right" href="list"> <span
                        class="glyphicon glyphicon-eye-open"></span> View All Uploads
                </a>
            </div>
        </div>
    </div>
</div>

</body>
</html>
