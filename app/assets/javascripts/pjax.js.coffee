jQuery ->
  $('.header .navbar .nav > li a').pjax('[data-pjax-container]')
  $('.tab-content .pagination a').pjax('[data-pjax-container]')
  $('.tabs-left > .nav-tabs > li a').pjax('[data-pjax-container]')
  $('.admin a').pjax('[data-pjax-container]')
  $('[data-pjax-container]').on 'pjax:timeout', -> return false