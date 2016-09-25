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
  $('[data-action="hotlinekr-congressman-select"]').select2();
});
