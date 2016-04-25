angular
  .module "VLiker"
  # .directive 'scrolled', ->
  #   (scope, elm, attr) ->
  #     raw = elm[0]
  #     elm.bind 'VLiker', ->
  #       if raw.scrollTop + raw.offsetHeight >= raw.scrollHeight
  #         scope.$apply attr.scrolled
  #       return
  #     return
  .run (amMoment) ->
    amMoment.changeLocale 'ru'
  .factory "Review", ($resource) ->
    $resource '/reviews/:id'
  # .factory "Waypoint", () ->
  #   new Waypoint()
  .controller "ReviewsCtrl", ($scope, $http, $timeout, Review) ->
    $scope.limit = 1
    $scope.offset = 0
    $scope.class_even = "from-me fadeInRight"
    $scope.Reviews = []
    $scope.load = false

    $scope.loadMore = ->
      # console.log "loadMore"
      last = $scope.Reviews[$scope.Reviews.length - 1]
      if $scope.load
        $scope.loadReview()
        $scope.load = false



    # $scope.loadMore = function() {
    #   var last = $scope.Reviews[$scope.Reviews.length - 1];
    #
    # $http.get '/reviews/getReviews',
    #   limit: $scope.limit
    #   offset: $scope.offset
    # .then (response) ->
    #   angular.forEach response.data.reviews, (review, key) ->
    #     $scope.Reviews = $scope.Reviews.concat(review)
    #     # $scope.Reviews.push review
    # };

    $scope.loadReview = ->
      console.log 'loadReview'
      $http.post '/reviews/getReviews',
        limit: $scope.limit
        offset: $scope.offset
      .then (response) ->
        angular.forEach response.data, (review, key) ->
          $scope.Reviews.push review
          $scope.offset = $scope.offset + $scope.limit
        $scope.load = true
        console.log 'responce>>>', response
        # console.log '$scope.Reviews', $scope.Reviews

    $scope.loadReview()

    # waypoint = Waypoint(
    #   element: $('#comments')
    #   handler: (direction) ->
    #     notify 'I am 20px from the top of the window'
    #   offset: 20)

    # $scope.loadReview()

    # $scope.testfunc = ->
    #   console.log "it work!"

    # waypoints = $('.footer').waypoint(handler: ->
    #   console.log 'new'
    # )
    # waypoints = $('.footer').waypoint((() ->
    #   $scope.offset += $scope.limit
    #   $scope.loadReview()
    # ), offset: '25%')




    # loadReviewsAnimation = ->
    #   # initial review load
    #   $scope.LoadedReviews = Review.query ->
    #     current_review = 0
    #     $scope.Reviews = []
        # loading_reviews_animation_interval = setInterval ->
        #   $scope.Reviews.push $scope.LoadedReviews[current_review]
    #       $scope.$apply()
    #       current_review++
    #       clearInterval(loading_reviews_animation_interval) if current_review is $scope.LoadedReviews.length
    #     , 100
    #
    # loadReviewsAnimation()
