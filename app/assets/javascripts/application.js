//= require jquery
//= require jquery_ujs
//= require owl.carousel
//= require bootstrap
//= require redactor2_rails/config
//= require redactor
//= require redactor2_rails/langs/ko
//= require cocoon
//= require unobtrusive_flash
//= require unobtrusive_flash_bootstrap
//= require select2.full
//= require select2/ko.js
//= require rails-timeago
//= require locales/jquery.timeago.ko
//= require jquery.validate

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

  $(document).click(function (event) {
    var clickover = $(event.target);
    var opened = $(".navbar-collapse").hasClass("navbar-collapse");
    opened = opened && $(".navbar-collapse").hasClass("in");
    if (opened === true && !clickover.hasClass("navbar-toggle")) {
        $("button.navbar-toggle").click();
    }
  });

<<<<<<< 8d15a2f3134fedf9e1d1e8001a6876217ef85bcd
  $('.action-validate').validate({
    ignore: ':hidden:not(.redactor)',
    errorPlacement: function(error, element) {
      return true;
    },
    highlight: function(element, errorClass, validClass) {
      $(element).closest('.form-group').addClass('field_with_errors');
    },
    unhighlight: function(element, errorClass, validClass) {
      $(element).closest('.form-group').removeClass('field_with_errors');
    }
  });
});
