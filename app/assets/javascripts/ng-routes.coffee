angular.module 'VLiker'
  .config (['$routeProvider', ($routeProvider) ->
    $routeProvider.when '/',
      controller : 'MainCtrl'
      menu       : false
    .when '/wall',
      templateUrl: 'assets/wall.html'
      controller : 'WallCtrl'
      menu       : 1
    .when '/stats',
      templateUrl: 'assets/stats.html'
      controller : 'StatsCtrl'
      menu       : 2
    .when '/store',
      templateUrl: 'assets/store.html'
      controller : 'MainCtrl'
      menu       : 3
    .when '/instr',
      templateUrl: 'assets/construction.html'
      menu       : 4
    .when '/start',
      templateUrl: 'assets/blocks.html'
      controller : 'BlocksCtrl'
    .otherwise
      redirectTo : '/'
  ])
