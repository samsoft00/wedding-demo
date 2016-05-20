// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require 'icheck'
//= require spinner
//= require review
//= require jquery_ujs
//= require turbolinks
//= require chosen-jquery
//= require refile
//= require_tree .
//= require vendor-js/bootstrap.min
//= require vendor-js/nav
//= require vendor-js/bootstrap-select
//= require vendor-js/owl.carousel.min
//= require vendor-js/slider
//= require vendor-js/thumbnail-slider
//= require vendor-js/testimonial
//= require vendor-js/jquery.sticky
//= require vendor-js/header-sticky
//= require jquery.multiple.select.min
//= require load-image.all.min
//= require cocoon
//= require summernote
//= require select2
//= require jquery.raty
//= require moment
//= require bootstrap-datetimepicker
//= require jquery.minicolors
//= require bootstrap-filestyle
//= require ImageSelect.jquery

$(function() {
  // limits the number of categories
  $('#categories').bind('cocoon:after-insert', function() {
    check_to_hide_or_show_add_link();
  });

  $('#categories').bind('cocoon:after-remove', function() {
    check_to_hide_or_show_add_link();
  });

  check_to_hide_or_show_add_link();

  function check_to_hide_or_show_add_link() {
    if ($('#categories .nested-fields').length == 2) {
      $('#add-category a').hide();
    } else {
      $('#add-category a').show();
    }
  }

})

  // function readURL(input) {
  //   if (input.files && input.files[0]) {
  //     var reader = new FileReader();

  //     reader.onload = function (e) {
  //       $('#img_prev')
  //         .attr('src', e.target.result)
  //         .width(150)
  //         .height(200);
  //     };

  //     reader.readAsDataURL(input.files[0]);
  //   }
  // }


  