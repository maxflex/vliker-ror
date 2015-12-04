angular
  .module "VLiker"
  .run (amMoment) ->
    amMoment.changeLocale 'ru'
  .factory "Review", ($resource) ->
    $resource '/reviews/:id'
  .controller "ReviewsCtrl", ($scope, $http, $timeout, Review) ->
    loadReviewsAnimation = ->
      # initial review load
      $scope.LoadedReviews = Review.query ->
        current_review = 0
        $scope.Reviews = []
        loading_reviews_animation_interval = setInterval ->
          $scope.Reviews.push $scope.LoadedReviews[current_review]
          $scope.$apply()
          current_review++
          clearInterval(loading_reviews_animation_interval) if current_review is $scope.LoadedReviews.length
        , 100

    loadReviewsAnimation()
