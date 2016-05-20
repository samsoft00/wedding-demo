$(document).on("upload:start", "form", function(e) {
  $(this).find("input[type=submit]").attr("disabled", true)
});

$(document).on("upload:success", "form", function(e) {
	if(!$(this).find("input.uploading").length) {
  	$(this).find("input[type=submit]").removeAttr("disabled")
	}

	// div[class^="tocolor-"]
	$('form [name="slider[pictures_attributes]"]').on('change', function(){
		console.log($(this));	
	});
	// $("#image").html("<img />").attr(src: "/attachment/cache/fill/50/50/#{image_id}/image")
});

// $(document).on("upload:complete", "form", function(e) {
//   if(!$(this).find("input.uploading").length) {
//     $(this).find("input[type=submit]").removeAttr("disabled")
//   }
// });