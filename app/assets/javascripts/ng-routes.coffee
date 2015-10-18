angular.module 'VLiker'
  .config (['$routeProvider', ($routeProvider) ->
    $routeProvider.when '/',
      controller : 'MainCtrl'
      menu       : false
    .when '/wall',
      templateUrl: "<%= asset_path('wall.html') %>"
      controller : 'WallCtrl'
      menu       : 1
    .when '/stats',
      templateUrl: "<%= asset_path('stats.html') %>"
      controller : 'StatsCtrl'
      menu       : 2
    .when '/store',
      templateUrl: "<%= asset_path('store.html') %>"
      controller : 'MainCtrl'
      menu       : 3
    .when '/instr',
      templateUrl: "<%= asset_path('construction.html') %>"
      menu       : 4
    .when '/start',
      templateUrl: "<%= asset_path('blocks.html') %>"
      controller : 'BlocksCtrl'
    .otherwise
      redirectTo : '/'
  ])
