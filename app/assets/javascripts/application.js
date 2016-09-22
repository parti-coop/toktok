//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require redactor2_rails/config
//= require redactor
//= require redactor2_rails/langs/ko
//= require cocoon
$(function(){
  $('[data-action="parti-home-slide"] a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
    var hash = $(e.target).attr('href');
    var $containers = $($(e.target).data('slide-target'));
    var $all_tab_panes = $($containers.find('.tab-pane'))
    var $target_tab_panes = $($containers.find('.tab-pane' + hash))
    $all_tab_panes.removeClass('active');
    $target_tab_panes.addClass('active');
  })
});
