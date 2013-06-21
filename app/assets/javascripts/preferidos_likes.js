$(document).ready(function(){
	//NICESCROLLS
	//$(".main-container").niceScroll({cursorcolor:"#16A085",cursorwidth: "6px"});
	//$(".product-desc").hover(function(){
	//	$(this).niceScroll({cursorcolor:"#ffffff",cursorwidth: "2px"});
	//});
	
	//LIKES-DISLIKES
	$(".like-btn").click(function(){
		var likediv = $(this).children(".like");
		if(likediv.attr("id") != null){
			var id = likediv.attr("id");
			$.post("/like",{collection_id: id })
			
			likediv.removeClass("like").addClass("no-like");
			likediv.html("No me gusta");
		}else{
			var likediv = $(this).children(".no-like");
			var id = likediv.attr("id");
			
			$.post("/dislike",{collection_id: id })
			$(this).children(".no-like").removeClass("no-like").addClass("like");
			$(this).children(".like").html('Me gusta <i class="icon-star icon-white"></i>');
		}
	});
});