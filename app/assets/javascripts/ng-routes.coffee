angular.module 'VLiker'
  .config (['$routeProvider', ($routeProvider) ->
    $routeProvider.when '/',
      controller : 'MainCtrl'
      menu       : false
    .when '/wall',
      templateUrl: 'wall.html'
      controller : 'WallCtrl'
      menu       : 1
    .when '/stats',
      templateUrl: 'stats.html'
      controller : 'StatsCtrl'
      menu       : 2
    .when '/store',
      templateUrl: 'store.html'
      controller : 'StoreCtrl'
      menu       : 3
      resolve    :
        goods: ($q, $http) ->
          defer = $q.defer()
          $http.get 'goods/all', {}
            .then (response) ->
              defer.resolve(response.data)
          defer.promise
    .when '/store/reviews',
      templateUrl: 'reviews.html'
      controller : 'ReviewsCtrl'
      menu       : 3
    .when '/instr',
      templateUrl: 'instr.html'
      menu       : 4
    .when '/start',
      templateUrl: 'blocks.html'
      controller : 'BlocksCtrl'
    .otherwise
      redirectTo : '/'
  ])
