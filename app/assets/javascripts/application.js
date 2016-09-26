//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require redactor2_rails/config
//= require redactor
//= require redactor2_rails/langs/ko
//= require cocoon
//= require unobtrusive_flash
//= require unobtrusive_flash_bootstrap
//= require select2.full
//= require select2/ko.js

UnobtrusiveFlash.flashOptions['timeout'] = 3000;

$(function(){
  $('.action-congressman-select').select2();
  $('.action-mention').on('click', function(e) {
    e.preventDefault();
    var $target = $(e.currentTarget);
    var to = $target.data('mention-to');
    var form_control = $target.data('mention-form-control');

    var value = $(form_control).val();
    if(to) {
      $(form_control).val('@' + to + ' ' + value);
    }
    $(form_control).focus();
  });
});
