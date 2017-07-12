// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).on('turbolinks:load', function() {

    // hide spinner
    $(".spinner").hide();


    // show spinner on AJAX start
    $(document).ajaxStart(function(){
        $(".spinner").show();
        delay(5000);
    });

    // hide spinner on AJAX stop
    $(document).ajaxStop(function(){
        $(".spinner").delay(3000).hide();
    });

});