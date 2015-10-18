# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
angular
  .module 'VLiker', ['ngRoute', 'ngAnimate', 'ng-rails-csrf']
  .filter 'range', ->
    return (input, total) ->
    	total = parseInt total
    	for i in [0...total] by 1
    		input.push i
    	input
  .run ($rootScope) ->
    $rootScope.$on '$routeChangeStart', (event, next, prev) ->
      $rootScope.menu = next.$$route.menu
      # top animation only if current menu is sent and previous isn't
      # (animate only if going from main page)
      topAnimation() if $rootScope.menu and (prev is undefined or not prev.$$route.menu)
  .factory 'setMenu', ($rootScope, $location) ->
    (menu_id) ->
      console.log "going to menu #{menu_id}"
      $rootScope.menu_hover = []
      if $rootScope.menu is menu_id
        $rootScope.menu = false
        $location.path '/'
        downAnimation()
        return false
      else
        $rootScope.menu = menu_id
        switch menu_id
          when 1
            $location.path 'wall'
          when 2
            $location.path 'stats'
          when 3
            $location.path 'store'
          when 4
            $location.path 'instr'
  .directive 'vliker', ->
    restrict: 'EA'
    scope:
      tasks: '='
    link: (scope, element, attrs) ->
      React.render React.createElement(VLiker, {tasks: scope.tasks}), element[0]
  # .directive 'vlikerBlock', ->
  #   restrict: 'EA'
  #   scope:
  #     task: '='
  #   link: (scope, element, attrs) ->
  #     React.render React.createElement(VlikerBlock, {task: scope.task}), element[0]
