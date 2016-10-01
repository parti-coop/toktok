//= require jquery
//= require jquery_ujs
//= require owl.carousel
//= require bootstrap
//= require redactor2_rails/config
//= require redactor
//= require redactor2_rails/langs/ko
//= require redactor/alignment
//= require redactor/video
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
//= require jssocials
//= require kakao

UnobtrusiveFlash.flashOptions['timeout'] = 300000;

function scroll_to_anchor(anchor_id){
    var tag = $(anchor_id);
    $('html,body').animate({scrollTop: tag.offset().top},'fast');
}

Kakao.init('e75d813957d26c4c8a00535facb7b071');

$.is_blank = function (obj) {
  if (!obj || $.trim(obj) === "") return true;
  if (obj.length && obj.length > 0) return false;

  for (var prop in obj) if (obj[prop]) return false;
  return true;
}

var prepare_social_share = function($base) {
  $base.find('[data-action="toktok-share"]').each(function(i, elm) {
    var $elm = $(elm);

    var url = $elm.data('share-url');
    var sitename = $elm.data('share-sitename');
    var text = $elm.data('share-text');
    var share = $elm.data('share-provider');
    var logo = $elm.data('share-logo');
    var css = $elm.data('share-css');
    if ($.is_blank(share)) return;
    var image_url = $elm.data('share-image');
    var image_width = $elm.data('share-image-width');
    var image_height = $elm.data('share-image-height');

    switch(share) {
    case 'kakao-link':
      Kakao.Link.createTalkLinkButton({
        container: elm,
        label: text,
        image: {
          src: image_url,
          width: image_width,
          height: image_height
        },
        webLink: {
          text: sitename + '에서 보기',
          url: url
        }
      });
    break
    case 'kakao-story':
      $elm.on('click', function(e) {
        Kakao.Story.share({
          url: url,
          text: text
        });
      });
    break
    default:
      $elm.jsSocials({
        showCount: false,
        showLabel: false,
        shares: [{share: share, logo: logo, css: css}],
        text: text,
        url: url
      });
    }
  });
}

$(function(){
  $('.action-congressman-select').select2();
  prepare_social_share($('html'));
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

  if($('#project-participations-stuckable').length) {
    new Waypoint.Sticky({
      element: $('#project-participations-stuckable'),
      stuckClass: 'unstuck',
      offset: 'bottom-in-view'
    });
  }
});
