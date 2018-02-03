//= require jquery
//= require jquery_ujs
//= require new_design/bindWithDelay.js
//= require new_design/scroll
//= require new_design/countdown.min
//= require new_design/datepicker
//= require new_design/easypiechart.min
//= require new_design/flickity.min
//= require new_design/granim.min
//= require new_design/isotope.min
//= require new_design/jquery.steps.min
//= require new_design/lightbox.min
//= require new_design/parallax
//= require new_design/scripts
//= require new_design/smooth-scroll.min
//= require new_design/twitterfetcher.min
//= require new_design/typed.min
//= require new_design/ytplayer.min
//= require jquery.datetimepicker
//= require bootstrap-datepicker
//= require dropzone
//= require new_design/media_contents


// for ajax request spining

$( document ).ready(function() {

    // hide spinner
    $(".spinner").hide();
    $(".ajax-load-logo").show();


    // show spinner on AJAX start
    $(document).ajaxStart(function(){
        $(".spinner").show();
        $(".ajax-load-logo").hide();
    });

    // hide spinner on AJAX stop
    $(document).ajaxStop(function(){
       $(".spinner").hide();
        $(".ajax-load-logo").show();
      //  $(".spinner").delay(3000).hide(0);
    });

});

// for Turbolinks gem

$(document).on("page:fetch", function(){
    $(".spinner").show();
});

$(document).on("page:receive", function(){
    $(".spinner").hide();
});




$(document).ready(function () {
    if ($("#endless-scroll .pagination").size() > 0) {
        $(".pagination").hide();
        $("#endless-scroll").removeClass("hidden");
        $(window).bindWithDelay("scroll", function () {
            var url = $("a.next_page").attr("href");
            if (url && $(window).scrollTop() > $(document).height() - $(window).height() - 50) {
                $.getScript(url);
            }
        }, 150);
    }

    $('#post-content').html($('#post_content').val());

    //$('.input-mentionable').atwho({at: '@', data: $('#mentionable-data').data('content'), insertTpl: '<a href="/users/${id}">${name}</a>', displayTpl: '<li data-id="${id}"><span>${name}</span></li>', limit: 15});

    $('.post_form').submit(function () {
        $('#post_content').val($('#post-content').html());
        $('#post-content').html('');
    });

    //$('.sent-post').click(function () {
    //    $('#post_content').val($('#post-content').html());
    //    $('#post-content').html('');
    //});
});


$(document).ready(function() {
    $('#new_comment').submit(function() {
        $('#comment_text').val($('#comment-text').html());
        $('#comment-text').html('');
    });
});

var readURL = function(input, preview) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
            $(preview).parent().removeClass('hidden');
            $(preview).attr('src', e.target.result);
        };
        reader.readAsDataURL(input.files[0]);
    }
};

$(document).ready(function(){

    var preview = "#img-preview > img";

    $("#post-attachment").click(function(){
        $("#post_attachments").click();
    });

    $('#post_attachments').change(function(){
        readURL(this, preview);
        $('.profile-camera').hide();
    });

});

$(document).ready(function () {
    $("#event_event_datetime").datetimepicker({format: 'Y/m/d H:i'});
    //$("#user_dob").datetimepicker({timepicker: false, format: 'Y/m/d', maxDate: '0'});
});