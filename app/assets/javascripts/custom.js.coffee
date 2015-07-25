clickLink = document.getElementById 'menu-icon'
sidebar = document.getElementById 'mobile-sidebar'

if clickLink
  clickLink.addEventListener 'click', (e) ->
    e.preventDefault()
    if sidebar.style.left is '-70%'
      sidebar.style.left = 0
    else
      sidebar.style.left = '-70%'

$('.close-notice').click (e)->
  e.preventDefault()
  $('.notice').slideUp 'slow'

$("#user-menu-trigger").click (e)->
  e.preventDefault()
  $("#user-options-for-custom-navbar").fadeToggle()

$("#categories-trigger").click (e)->
  e.preventDefault()
  $("#categories-container").fadeToggle()

$('#sign-up-click-scroll').click (e)->
  e.preventDefault()
  $('body').animate { scrollTop: 0 }, 50000

$(".share-button").click (e)->
  e.preventDefault()
  $(this).parent().next().fadeToggle()

ready = ->
  if clickLink
    clickLink.click()

$(document).ready(ready)
$(document).on('page:load', ready)