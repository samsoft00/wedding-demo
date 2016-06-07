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
		var tempSelector = $('#template_selector');

		iframe.attr('src', template.demo_website);
		tempSelector.attr('href', 'http://go_to_next_url.com?template_id='+template.id);
		templateFrame.css("display", "block");
		$('body').addClass('template-preview-open');
		
		// console.log(template.demo_website);

	});

})