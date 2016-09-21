//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require redactor
$(function(){
  // Initialize Redactor
  $('.redactor').redactor({
    buttons: ['format', 'bold', 'italic', 'deleted', 'lists', 'link', 'horizontalrule'],
    plugins: ['wiki_save'],
    callbacks: {
      imageUploadError: function(json, xhr) {
        UnobtrusiveFlash.showFlashMessage(json.error.data[0], {type: 'notice'})
      }
    }
  });
  $('.redactor .redactor-editor').prop('contenteditable', true);

  $('[data-action="parti-home-slide"] a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
    var hash = $(e.target).attr('href');
    var $containers = $($(e.target).data('slide-target'));
    var $all_tab_panes = $($containers.find('.tab-pane'))
    var $target_tab_panes = $($containers.find('.tab-pane' + hash))
    $all_tab_panes.removeClass('active');
    $target_tab_panes.addClass('active');
  })
});
