angular.module 'VLiker'
  .controller "MainCtrl", ($scope, $http, $location, $rootScope, setMenu) ->
    $scope.goExample = (event) ->
      $scope.url = $(event.target).text().trim()
      $scope.example_clicked = true

    # Ajax animation control
    $scope.$watch 'start_loading', (newVal, oldVal) ->
      return if newVal is undefined
      switch newVal
        when true then ajaxStart()
        when false then ajaxEnd()

    $scope.start = ->
      $scope.start_loading = true
      $http.post 'blocks',
        url: $scope.url
      .then (response) ->
        $scope.url_error = ''
        startAnimation()
        $scope.tasks         = response.data.tasks
        $scope.current_task  = response.data.current_task
        $location.path 'start'
      , (response) ->
        $scope.url_error = response.data[0]
      .finally ->
        $scope.start_loading = false

    $scope.setMenu = setMenu
