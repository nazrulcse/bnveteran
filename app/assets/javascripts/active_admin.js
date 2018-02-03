//= require active_admin/base
//= require bootstrap-sprockets

//= require active_bootstrap_skin
//= require active_admin/base
//= require tinymce

$(document).ready(function() {
    tinyMCE.init({
        mode: 'textareas'
    });
});

$(document).ready(function() {

element = $("#current_user_logo")
obj = element.find("a")
href = obj.attr('href')
append_place = $("#current_user")
append_place.after("<img src="+href+" height='40'>")
element.remove()

});
