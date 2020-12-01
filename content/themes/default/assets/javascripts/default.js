//= require jquery
//= require jquery_ujs
//= require vendor/timeago

$(function() {
  $('time').timeago();

  $('#all_services_checkbox').change(function (){
    if (this.checked) {
      $('.subscribePage__checkbox').prop('checked', false);
      $('.subscribePage__services').hide();
    } else {
      $('.subscribePage__services').show();
    }
  });
});
