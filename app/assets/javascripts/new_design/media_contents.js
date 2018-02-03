$(function() {
    Dropzone.options.postForm = { // The camelized version of the ID of the form element

        // The configuration we've talked about above
        autoProcessQueue: false,
        uploadMultiple: true,
        parallelUploads: 100,
        maxFiles: 100,
        maxFilesize: 5,
        acceptedFiles: "image/*, application/pdf",
        dictDefaultMessage: "Select or drop images here to upload",
        paramName: 'post_images_attributes',
        clickable: [".post_form", ".btn-file-input"],

        // The setting up of the dropzone
        init: function() {
            var myDropzone = this;

            this.on("addedfile", function(file) {
                var _this = this;

                /* Maybe display some more file information on your page */
                var removeButton = Dropzone.createElement("<i data-dz-remove class='fa fa-times image-remove-icon'></i>");

                removeButton.addEventListener("click", function (e) {
                    e.preventDefault();
                    e.stopPropagation();

                    _this.removeFile(file);
                });
                file.previewElement.appendChild(removeButton);
            });

            // First change the button to actually tell Dropzone to process the queue.
            this.element.querySelector("button[type=submit]").addEventListener("click", function(e) {
                // Make sure that the form isn't actually being sent.
                console.log(myDropzone.files.length);
                if (myDropzone.files.length > 0) {
                    e.preventDefault();
                    e.stopPropagation();
                    $('#post_content').val($('#post-content').html());
                    $('#post-content').html('');
                    myDropzone.processQueue();
                }
            });

            // Listen to the sendingmultiple event. In this case, it's the sendingmultiple event instead
            // of the sending event because uploadMultiple is set to true.
            this.on("sendingmultiple", function() {
                // Gets triggered when the form is actually being sent.
                // Hide the success button or the complete form.
            });
            this.on("successmultiple", function(files, response) {
                // Gets triggered when the files have successfully been sent.
                // Redirect user or notify of success.

                this.removeAllFiles();
                $.ajax({
                    url: "/posts/view_activity",
                    data: {activity_id: response[0]['id']}
                });
            });
            this.on("errormultiple", function(files, response) {
                // Gets triggered when there was an error sending the files.
                // Maybe show form again, and notify user of error
            });
        }

    };
});