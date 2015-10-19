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
      templateUrl: 'construction.html'
      menu       : 3
    .when '/instr',
      templateUrl: 'construction.html'
      menu       : 4
    .when '/start',
      templateUrl: 'blocks.html'
      controller : 'BlocksCtrl'
    .otherwise
      redirectTo : '/'
  ])
