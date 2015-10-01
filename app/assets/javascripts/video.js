$(document).ready(function() {
    $("#video_file").change(function(){
        $('#videoPreviewPlayer').show();
            var myPlayer = videojs('videoPreviewPlayer').ready(function () {
            var filename = $('#video_file').get(0).files[0].name;
            var fileUrl = URL.createObjectURL($('#video_file').get(0).files[0]);
            var fileType = $('#video_file').get(0).files[0].type;
            //console.log(filename);
            this.src({ type: fileType, src: fileUrl });
            this.load();
            this.play();
        });
    });

});


