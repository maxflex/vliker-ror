angular.module 'VLiker'
  .controller "MainCtrl", ($scope, $http, $location, $rootScope, setMenu) ->
    $scope.goExample = (event) ->
      $scope.url = $(event.target).text().trim()
      $scope.example_clicked = true

    $scope.start = ->
      $http.post 'blocks',
        url: $scope.url
      .then (response) ->
        $scope.url_error = ''
        startAnimation()
        $scope.tasks        = response.data.tasks
        $scope.current_task = response.data.current_task
        $location.path 'start'
        console.log response
      , (response) ->
        $scope.url_error = response.data[0]

    $scope.setMenu = setMenu
