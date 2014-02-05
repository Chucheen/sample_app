/**
 * Created by jgutierrez on 31/01/14.
 */
$(document).ready(function(){
    $('#micropost-content').keyup(function(){
        $('#micropost-characters').text((140 - $('#micropost-content').val().length) + ' characters left');
    });
});
