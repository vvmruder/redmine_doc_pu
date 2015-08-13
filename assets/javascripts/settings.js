/**
 * Created by vvmruder on 13.08.15.
 */

$(document).ready(function () {
    /**
     * Methods to handle the clicks for check latex binary with the given path
     */
    $('#doc_pu_settings_latex_bin').bind("ajax:complete", function (evt, xhr, settings) {
        $("#result").html(xhr.responseText);
    }).on("click", function (event) {
        event.preventDefault(); // don't trigger default

        // get the value inside the text field
        var value = $("#latex_bin").val();
        var url = $(this).attr("href").split("?");
        if (url.length == 1) {
            $(this).attr("href", $(this).attr("href") + "?file=" + value);
        } else {
            url.pop();
            url.push('file=' + value);
            $(this).attr("href", url.join("?"));
        }
    });
    /**
     * Methods to handle the clicks for check make index binary with the given path
     */
    $('#doc_pu_settings_makeindex_bin').bind("ajax:complete", function (evt, xhr, settings) {
        $("#result").html(xhr.responseText);
    }).on("click", function (event) {
        event.preventDefault(); // don't trigger default

        // get the value inside the text field
        var value = $("#makeindex_bin").val();
        var url = $(this).attr("href").split("?");
        if (url.length == 1) {
            $(this).attr("href", $(this).attr("href") + "?file=" + value);
        } else {
            url.pop();
            url.push('file=' + value);
            $(this).attr("href", url.join("?"));
        }
    });
    /**
     * Methods to handle the clicks for finding the templates with the given path
     */
    $('#doc_pu_settings_test_template').bind("ajax:complete", function (evt, xhr, settings) {
        $("#result").html(xhr.responseText);
    }).on("click", function (event) {
        event.preventDefault(); // don't trigger default

        // get the value inside the text field
        var value = $("#template_dir").val();
        var url = $(this).attr("href").split("?");
        if (url.length == 1) {
            $(this).attr("href", $(this).attr("href") + "?file=" + value);
        } else {
            url.pop();
            url.push('file=' + value);
            $(this).attr("href", url.join("?"));
        }
    });
});