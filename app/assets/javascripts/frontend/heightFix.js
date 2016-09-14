$(document).ready(function(){
function jqUpdateSize(){
    // Fixed height
		if($(window).width()>991){
			var height = $(window).height();
			alert
			$('#side-links').css('height',(height-$('header.header').height()-29));
			$('#emails').css('height',(height-($('#emails').offset().top)-20));
		}
		else{
		$('#side-links').css('height','auto');
		}
};
jqUpdateSize()
$(window).resize(function(e) {
    jqUpdateSize()
});
});
