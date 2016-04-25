angular
  .module "VLiker"
  .controller "StatsCtrl", ($scope, $http) ->
      $http.post 'stats', {}
        .then (response) ->
          console.log response
          $scope.tasks = response.data.tasks
          $scope.orders = response.data.orders
          console.log response.data
          getUserId()

      $scope.review = (order) ->
        $scope.review_order          = order
        $scope.review_order.order_id = order.id
        $('#leave-review').nifty 'show'

      $scope.stop = (task) ->
        user = getUserId()
        console.log 'user>>>', user
        $http.post 'tasks/stop_task',
          url: task.url
        .success (response) ->
            console.log 'response>>>>', response

      $scope.leaveReview = ->
        $http.post 'reviews', $scope.review_order
          .then (response) ->
            $scope.review_order.review = response.data
            $('#leave-review').nifty 'hide'

      $scope.watchReview = (review) ->
        $scope.review = review
        $('#watch-review').nifty 'show'

      getUserId = ->
        $http.get 'user_id'
          .then (response) ->
            $scope.user_id = response.data
            console.log '$scope.user_id>>>', $scope.user_id
