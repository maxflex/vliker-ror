angular
  .module('VLiker')
  .controller 'WallCtrl', ($scope) ->
    angular.element(document).ready ->
      # Comments iframe
      comments_iframe = $(".comments-iframe")

      # Ad soon as iframe loads
      comments_iframe.on "load", ->
      	$(window).on "scroll", ->
      		scrolled =  ($(window).scrollTop() + $(window).height()) / $(document).height()
      		if scrolled > 0.8
      			comments_iframe.height(comments_iframe.height() + 300);
