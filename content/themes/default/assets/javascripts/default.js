//= require jquery
//= require jquery_ujs
//= require vendor/timeago

$(function() {
  $('time').timeago();

  $('#js-allServicesCheckbox').change(function (){
    if (this.checked) {
      $('.subscribePage__checkbox').prop("checked", false);
      $('.subscribePage__services').hide();
    } else {
      $('.subscribePage__services').show();
    }
  });

  $('.js-serviceGroupCheckbox').change(function () {
    $(this).parents().eq(2)
      .find("ul")
      .children()
      .find("input[type=checkbox]")
      .prop('checked', $(this).prop("checked"));
  });

  $('.subscribePage__checkboxList').on("change", ":checkbox", function () {
    let checkboxGroup = $(this).parents().eq(2);
    let allServices = checkboxGroup.find("input[type=checkbox]").length
    let checkedServices = checkboxGroup.find("input[type=checkbox]:checked").length;
    if (!checkedServices) {
      checkboxGroup.parent().find(".js-serviceGroupCheckbox").prop("checked", false);
    } else if (allServices === checkedServices) {
      checkboxGroup.parent().find(".js-serviceGroupCheckbox").prop("checked", true);
    }
  });
});
