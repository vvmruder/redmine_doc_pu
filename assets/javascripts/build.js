/**
 * Created by vvmruder on 13.08.15.
 */

$(document).ready(function () {
    /**
     * Method to handle the clicks for build document remotely
     */
    $('#button_build_doc_remote').bind("ajax:complete", function(evt, xhr, settings){
        var element = $("#log-result");
        element.html(xhr.responseText);
    });
    /**
     * Method to handle the clicks for clean document remotely
     */
    $('#button_clean_doc_remote').bind("ajax:complete", function(evt, xhr, settings){
        var element = $("#log-result");
        element.html(xhr.responseText);
    });
});