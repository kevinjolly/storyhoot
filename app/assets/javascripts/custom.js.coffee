clickLink = document.getElementById 'menu-icon'
sidebar = document.getElementById 'mobile-sidebar'

if clickLink
  clickLink.addEventListener 'click', (e) ->
    e.preventDefault()
    if sidebar.style.left is '-70%'
      sidebar.style.left = 0
    else
      sidebar.style.left = '-70%'

ready = ->
  if clickLink
    clickLink.click()

  $('.close-notice').click ->
    $('.notice').slideUp 'slow'


  # Don't exactly know how this works
  $(document).off('click', '#about-link').on 'click', '#about-link', ->
    event.stopImmediatePropagation()
    $('html, body').animate({
        scrollTop: $( $.attr(this, 'href') ).offset().top
    }, 400)
    false

$("#user-menu-trigger").click ->
  $("#user-options-for-custom-navbar").fadeToggle()
  false

$("#categories-trigger").click ->
  $("#categories-container").fadeToggle()
  false

$('#sign-up-click-scroll').click ->
  $('body').animate { scrollTop: 0 }, 50000
  false

$(".share-button").click ->
  $(this).parent().next().fadeToggle()
  false

$(document).ready(ready)
$(document).on('page:load', ready)