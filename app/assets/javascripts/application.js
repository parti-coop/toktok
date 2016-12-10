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
//= require jquery.typewatch
//= require validate/accept
//= require jquery.waypoints
//= require waypoints/sticky.js
//= require jssocials
//= require kakao
//= require jquery.webui-popover

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

$.hotline_apply = function($base, query, callback) {
  $.each($base.find(query), function(i, elm){
    callback(elm);
  });
}

$.parse$ = function(str) {
  return $($.parseHTML($.trim(str)));
}

var hotline_partial = function(partial) {
  var $partial = $.parse$(partial);
  hotline_prepare($partial);

  return $partial;
}

var hotline_prepare = function($base) {

  $.hotline_apply($base, '[data-action="toktok-popover"]', function(elm) {
    var $elm = $(elm);
    if ($elm.attr('data-project-now-step') == 'gathering') {
      $('[data-project-status="matching"]').webuiPopover();
      $('[data-project-status="running"]').webuiPopover();
    } else if ($elm.attr('data-project-now-step') == 'matching') {
      $('[data-project-status="running"]').webuiPopover();
    }
  });

  $.hotline_apply($base, '[data-action="toktok-social-popover"]', function(elm) {
    $(elm).webuiPopover();
  });


  $.hotline_apply($base, '[data-action="toktok-share"]', function(elm) {
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

  $.hotline_apply($base, '.action-congressman-select', function(elm) {
    $(elm).select2();
  });

  $.hotline_apply($base, '.action-mention', function(elm) {
    $(elm).on('click', function(e) {
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
  });

  $.hotline_apply($base, '.action-mention-before-paticipation', function(elm) {
    $(elm).on('click', function(e) {
      $('.tab-content #gathering').addClass('active')
      UnobtrusiveFlash.showFlashMessage('참여 후에 의원을 호출할 수 있습니다. 먼저 이 프로젝트에 참여 해 주세요!')
    });
  });

  $.hotline_apply($base, '.action-validate', function(elm) {
    $(elm).validate({
      ignore: ':hidden:not(.redactor)',
      errorPlacement: function(error, element) {
        console.log(element.attr('id') );
        if(element.attr('id') == 'proposal_image') {
          $(error).addClass('control-label').html('이미지 파일을 올려 주세요.');
          element.after(error);
        }
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

  $.hotline_apply($base, '.owl-carousel', function(elm) {
    $(elm).owlCarousel({
      autoPlay: true,
      slideSpeed : 500,
      singleItem: true,
      navigation: true,
      autoHeight : true,
      navigationText: ["&lt;","&gt;"]
    })
  });

  $.hotline_apply($base, '.action-show', function(elm) {
    $(elm).on('click', function(e) {
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
  });

  $.hotline_apply($base, '#project-participations-stuckable', function(elm) {
    if($(elm).length) {
      new Waypoint.Sticky({
        element: $('#project-participations-stuckable'),
        stuckClass: 'unstuck',
        offset: 'bottom-in-view'
      });
    }
  });

  $.hotline_apply($base, '[data-action="hotline-filter-projects"]', function(elm) {
    $(elm).each(function(i, elm) {
      var $elm = $(elm);
      $elm.on('click', function(e) {
        var search_input = $(this).data('search-input');
        var sort = $(this).data('search-sort');
        var $elm = $(this);

        $('.projects-all-loading').show();
        $('.projects-all-list').hide();
        $.ajax({
          url: '/projects/search.js',
          type: "get",
          data:{
            keyword: $(search_input).val(),
            sort: sort
          },
          complete: function(xhr) {
            $('.projects-all-loading').hide();
            $('.projects-all-list').show().trigger('hotline-home-searched');
          },
        });
        return false;
      });
    });
  });

  $.hotline_apply($base, '[data-action="hotline-search-projects"]', function(elm) {
    $(elm).each(function(i, elm) {
      var sort = $(elm).data('search-sort');
      var options = {
        callback: function (value) {
          $('.projects-all-loading').show();
          $('.projects-all-list').hide();
          $.ajax({
            url: '/projects/search.js',
            type: "get",
            data:{
              keyword: value,
              sort: $(sort).val()
            },
            complete: function(xhr) {
              $('.projects-all-loading').hide();
              $('.projects-all-list').show().trigger('hotline-home-searched');
            },
          });
        },
        wait: 500,
        highlight: true,
        allowSubmit: false,
        captureLength: 2
      }
      $(elm).typeWatch( options );
    });
  });

  $.hotline_apply($base, '#checkBefore', function(elm) {
    $(elm).on('show.bs.modal', function (e) {
      var button = $(e.relatedTarget); // Button that triggered the modal
      var recipient = '큐ㅅ'; // Extract info from data-* attributes
      // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
      // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
      var modal = $(this);
      modal.find('.modal-title').text('New message to ' + recipient);
    });


  });

  $.hotline_apply($base, '[data-action="hotline-before-submit-form-validation"]', function(elm) {
    var $elm = $(elm);
    var $form = $(elm);
    var $submit = $('#before-submit-button');
    $submit.prop('disabled', true);
    $submit.addClass('disabled');

    $form.validate({
      ignore: ':hidden:not(.validate)',
      errorPlacement: function(error, element) {
        return true;
      }
    });

    $elm.find(':input').on('input', function(e) {
      if($form.valid()) {
        $submit.prop('disabled', false);
        $submit.removeClass('disabled');
      } else {
        $submit.prop('disabled', true);
        $submit.addClass('disabled');
      }
    });

    $elm.find(':input').on('change', function(e) {
      if($form.valid()) {
        $submit.prop('disabled', false);
        $submit.removeClass('disabled');
      } else {
        $submit.prop('disabled', true);
        $submit.addClass('disabled');
      }
    });

    $submit.on('click', function(e) {
      if($form.valid() == false) {
        alert('필수 입력항목을 모두 입력해야합니다');
      }
    });
  });
};


$(function(){
  hotline_prepare($('body'));
  $(document).click(function (event) {
    var clickover = $(event.target);
    var opened = $(".navbar-collapse").hasClass("navbar-collapse");
    opened = opened && $(".navbar-collapse").hasClass("in");
    if (opened === true && !clickover.hasClass("navbar-toggle")) {
        $("button.navbar-toggle").click();
    }
  });
});
