//透過アニメーション
$(function(){
	$('a img').hover(
		function(){$(this).fadeTo(200, 0.6);},
		function(){$(this).fadeTo(200, 1.0);}
	);
});