angular
  .module "VLiker"
  .controller "StatsCtrl", ($scope, $http) ->
      $http.post 'stats', {}
        .then (response) ->
          console.log response
          $scope.tasks = response.data.tasks
          $scope.orders = response.data.orders
          console.log response.data

      $scope.review = (order) ->
        $scope.review_order          = order
        $scope.review_order.order_id = order.id
        $('#leave-review').nifty 'show'

      $scope.leaveReview = ->
        $http.post 'reviews', $scope.review_order
          .then (response) ->
            $scope.review_order.review = response.data
            $('#leave-review').nifty 'hide'

      $scope.watchReview = (review) ->
        $scope.review = review
        $('#watch-review').nifty 'show'
