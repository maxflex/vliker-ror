angular
  .module "VLiker"
  .controller "StatsCtrl", ($scope, $http) ->
      $http.post 'stats', {}
        .then (response) ->
          $scope.tasks = response.data
