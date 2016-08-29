$(document).ready(function(){
function jqUpdateSize(){
    // Fixed height
		if($(window).width()>991){
			var height = $(window).height();
			$('.content_height').css('height',(height-44-(parseInt($('header.header').height())+parseInt($('div.footer').height()))));
		}
};
jqUpdateSize()
$(window).resize(function(e) {
    jqUpdateSize()
});
});
