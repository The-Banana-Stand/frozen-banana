// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).on('turbolinks:load', function() {

    // // hide spinner
    // $(".spinner").hide();
    //
    //
    // $(document).on('ajax:before ajaxStart', function() {
    //     $(".spinner").show();
    // });
    //
    // // hide spinner on AJAX stop
    //
    // $(document).on('ajax:complete ajaxComplete', function() {
    //     $(".spinner").hide();
    // });

    $('.dashboard-popover').popover({delay: { "show": 300, "hide": 100 }, container: 'body', html: true });

    $('.setting-box').matchHeight({byRow: false});


    $('.time-picker').timepicker({
        'minTime': '5:00am',
        'maxTime': '9:00pm',
        forceRoundTime: true,
        timeFormat: 'h:i A'
    });

});
