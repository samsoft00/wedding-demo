$(function(){
	//Close Template Displat iFrame
	$('#close-template').on('click', function(e){
		e.preventDefault();
		
		var templateFrame = $('#template-preview');
		templateFrame.css("display", "none").addClass('template-preview-close');
		$('body').removeClass('template-preview-open');
	});

	$('.thumbnail-template').on('click', function(e){
		e.preventDefault();
		var divIframe = $('#iframe-preview');
		var template = $(this).data('template');
		var iframe = divIframe.find('iframe');

		var templateFrame = $('#template-preview');
		iframe.attr('src', template.demo_website);
		templateFrame.css("display", "block");
		$('body').addClass('template-preview-open');
		
		// console.log(template.demo_website);

	});

})