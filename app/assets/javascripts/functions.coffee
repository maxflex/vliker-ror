# Скорость анимаций
@animation_speed = 300

# Иконки
@CIRCLE_ICON_PATH = 'assets/circles/fullcolor/'

# Angular scope for debugging
@ang_scope = null


###*
# Получить иконку.
#
###

@getIcon = (icon_name) ->
  '<img src=\'' + CIRCLE_ICON_PATH + icon_name + '.png\' class=\'circle-icon\'>'

###*
# Вставить glyphicon.
#
###

@glyphIcon = (class_name) ->
  '<span class=\'glyphicon glyphicon-' + class_name + '\'></span>'

###*
# Анимация перевода вверх (меню).
#
###

@topAnimation = () ->
  console.log 'top_animation'
  $('#animation-block, #likes-iframe').slideUp animation_speed
  showContent()
  $('body').css 'overflow-y': 'visible'
  $('.footer').addClass('animated fadeOutDown').one 'webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', ->
    $(this).removeClass 'animated fadeOutDown navbar-fixed-bottom'

###*
# Анимация перевода вниз (меню).
#
###

@downAnimation = (callback) ->
  $('#animation-block, #likes-iframe').slideDown animation_speed
  $('body').css 'overflow-y': 'hidden'
  hideContent()
  $('.footer').addClass('navbar-fixed-bottom animated fadeInUp').one 'webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', ->
    $(this).removeClass 'animated fadeInUp'
    if callback isnt undefined
      callback()


  #$("#row-buttons").delay(50).animate({"top" : "-375px"}, 350)

###*
# Анимация начала накрутки.
#
###

@startAnimation = ->
  showContent()
  $('#row-ads, #row-logo, #row-example, #row-menu, #likes-iframe').slideUp animation_speed

###*
# Анимация конца накрутки.
#
###

@stopAnimation = (callback) ->
  $('#row-ads, #row-logo, #row-example, #row-menu, #likes-iframe').slideDown animation_speed
  hideContent()
  if callback isnt undefined
    callback()

###*
# Анимация загрузки (начало и конец).
#
# @access public
# @return void
###

@ajaxStart = ->
  NProgress.start()

@ajaxEnd = ->
  NProgress.done()

###*
# Открыть ссылку в новой вкладке.
#
###

@openInNewTab = (url) ->
  window.open url, '_blank'

###*
# Показать контент.
#
###

@showContent = (content) ->
  $('#row-content').show()

###*
# Скрыть контент.
#
###

@hideContent = ->
  $('#row-content').fadeOut animation_speed

###*
# Является ли переменная валидным JSON-объектом?
#
###

@toJSON = (object) ->
  IS_JSON = true
  try
    return $.parseJSON(object)
  catch err
    return false

###*
	 * Нотифай с сообщением об ошибке.
	 *
###

@notifyError = (message) ->
  $.notify {
    'message': message
    icon: 'glyphicon glyphicon-remove'
  },
    type: 'danger'
    allow_dismiss: false
    placement:
      from: 'bottom'
      align: 'center'
    animate:
      enter: 'animated shake'
      exit: 'animated fadeOutUp'

###*
# Нотифай с сообщением об успехе.
#
###
@notifySuccess = (message) ->
  $.notify {
    'message': message
    icon: 'glyphicon glyphicon-ok'
  },
    type: 'success'
    allow_dismiss: false
    placement:
      from : 'bottom'
      align: 'center'
    animate:
      enter: 'animated fadeInDown'
      exit: 'animated fadeOutUp'

###*
 * Capture application scope
###
$(document).on 'ready page:load', ->
  console.log 1111
  @ang_scope = angular.element('[ng-app=VLiker]').scope()
