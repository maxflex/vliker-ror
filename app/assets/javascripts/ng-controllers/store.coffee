angular
  .module "VLiker"
  .directive 'storeItems', ->
    restrict: 'E'
    templateUrl: 'directives/store-items.html'
  .controller "StoreCtrl", ($scope, $http, $timeout, goods) ->
      $scope.current_page = 1
      slider = undefined
      $scope.goods = goods

      $scope.payment_types = [
          id: 1
          name: 'Яндекс.Деньги'
          logo: 'yandexmoney'
          short: 'ym'
        ,
          id: 2
          name: 'WebMoney'
          logo: 'webmoney'
          short: 'wm'
        ,
          id: 3
          name: 'Visa QIWI Wallet'
          logo: 'kiwipurse'
          short: 'qiwi'
      ]

      $scope.$watch 'current_page', (newVal, oldVal) ->
        return if slider is undefined
        slider.goToSlide(newVal - 1)

      $scope.$watch 'order_url', (newVal, oldVal) ->
        return if newVal is undefined
        # Собираем строку (id товара|ссылка на заказ для яндекса|user id)
       	$scope.goodid_link_userid = "#{$scope.buying_good.id}|#{$scope.order_url}|#{$scope.user_id}"
        $scope.desc = "Покупка +#{$scope.buying_good.count} #{$scope.buying_good.good_type.title} на VLiker.ru"
        $scope.bas64_desc = Base64.encode $scope.desc

      $timeout ->
        slider = $('.store-items').bxSlider
          pager   : false
          controls: false

      $scope.buy = (good) ->
        $scope.buying_good = good
        $('#enter-link').modal 'show'
        return false

      $scope.proceedPurchase = ->
        $('#enter-link').modal 'hide'
        $('#payment-methods').modal 'show'
        return false

      $scope.proceedPayment = (payment_type) ->
        $("#form-#{payment_type.short}").submit()
        return false
