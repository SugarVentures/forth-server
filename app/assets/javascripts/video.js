$(document).ready(function() {
    function videoFile(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                $('#videoPreview').attr('src', e.target.result);
            }
            reader.readAsDataURL(input.files[0]);
        }
    }

    $("#video_file").change(function(){
        videoFile(this);
        $('#videoPreviewPlayer').show();
    });
});