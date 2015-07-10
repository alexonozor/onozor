# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
 if $('#questions')
  if $('.pagination').length
    $(window).scroll ->
      url = $('.pagination .next_page').attr('href')
      if url && $(window).scrollTop() > $(document).height() - $(window).height() - 50
        $('.pagination').fadeIn(500000).html("Fetching more questions...").addClass('flow')
        $.getScript(url)
    $(window).scroll()


jQuery ->
  $('.help-toggle').click ->
    $('.editing-help').slideToggle('fast')



jQuery ->
  $('.question-title').focus ->
    $('.error-holder').addClass('has-error')

jQuery ->
  $('.post_form').focus ->
    $('.editing-help').slideDown('slow')


jQuery ->
  $('.question-title').keydown ->
    if this.value.length >= 10
      $('.error-holder').removeClass('has-error')
    else
      $('.error-holder').addClass('has-error')


jQuery ->
  $(document).ajaxStart ->
    $('.posting').show()
  $(document).ajaxComplete ->
    $('.posting').hide()




