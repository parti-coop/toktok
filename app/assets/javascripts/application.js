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
//= require jquery.waypoints
//= require waypoints/sticky.js

UnobtrusiveFlash.flashOptions['timeout'] = 3000;

function scroll_to_anchor(anchor_id){
    var tag = $(anchor_id);
    $('html,body').animate({scrollTop: tag.offset().top},'fast');
}

$(function(){
  $('.action-congressman-select').select2();
  $('.action-mention').on('click', function(e) {
    e.preventDefault();
    var $target = $(e.currentTarget);
    var to = $target.data('mention-to');
    var form_control = $target.data('mention-form-control');
    var form_placeholder = $target.data('mention-form-placeholder');

    $(form_control).closest('form').show();
    $(form_placeholder).hide();

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

  $('.owl-carousel').owlCarousel({
    autoWidth: true,
    dots: false,
    margin: 10,
  })

  $('.action-show').on('click', function(e) {
    var $elm = $(e.currentTarget);
    var $target = $($elm.data('show-target'));
    $target.show();
    var focus_id = $elm.data('show-focus');
    $focus = $(focus_id);
    $focus.focus();
    if($elm.data('show-self-hide')) {
      $elm.hide();
    }
  });

  new Waypoint.Sticky({
    element: $('#project-participations-stuckable'),
    stuckClass: 'unstuck',
    offset: 'bottom-in-view'
  });
});
