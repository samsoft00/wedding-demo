var init_submit_review, show_errors, show_message;

init_submit_review = function(){

	$("#new_review").on('ajax:before', function(event, data, status){
		//Loading Spinner if possible
		console.log("Loading Review Form...")
		show_spinner();
	});

	$("#new_review").on('ajax:after', function(event, data, status){
		//remove review form from DOM
		hide_spinner();
	});

	$("#new_review").on('ajax:success', function(event, data, status){
		console.log(data)
		//display Review to DOM or Notification message
		show_message(data);

		var $form = $(event.target)
		$form.get(0).reset();
		$form.find('review[rating]').
		$form.find("button[type='submit']").prop("disabled", true);

		// return false;
		hide_spinner();
		init_submit_review();
	});

	$("#new_review").on('ajax:error', function(event, data, status){
		//Display error message
		console.log(data)
		show_errors("Unable to create review, Select Rating and fill the text area below!");
		hide_spinner();
	});

}
 
show_errors = function(message){
	$("#error-msg").html('<div class="alert alert-warning"><a class="close" data-dismiss="alert">x</a><div id="flash_alert">' + message + '</div></div>');

	$('.alert').delay(7000).fadeOut(3000);
	// return false;
};

show_message = function(data){
	$("#review-status").prepend(data);//works
	//scroll to review post
}

$(document).ready(function(){
	init_submit_review();
})