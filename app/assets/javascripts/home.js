$(document).ready(function() {
    $( "#trans" ).hover(
        function() {
            $( this ).css("background-color","#D9453C");
        }, function() {

            $( this ).css("background-color","#4CAE4C");
        }
    );
    $( "#sett" ).hover(
        function() {
            $( this ).css("background-color","#D9453C");
        }, function() {

            $( this ).css("background-color","#4CAE4C");
        }
    );
    $( "#white" ).hover(
        function() {
            $( this ).css("background-color","#D9453C");
        }, function() {

            $( this ).css("background-color","#4CAE4C");
        }
    );

});
function btn_click(){
    document.getElementById('inp2').disabled = false;
    document.getElementById('inp1').disabled = false;
    document.getElementById('inp3').disabled = false;
}