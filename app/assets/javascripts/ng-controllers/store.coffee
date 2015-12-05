angular
  .module "VLiker"
  .directive 'storeItems', ->
    restrict: 'E'
    templateUrl: 'directives/store-items.html'
  .controller "StoreCtrl", ($scope, $http, $timeout, goods) ->
      $scope.current_page = 1
      slider = undefined
      $scope.goods = goods

      # PC — оплата со счета в Яндекс.Деньгах
      # AC — оплата с банковской карты
      $scope.payment_mode = 'AC'

      $scope.payment_types = [
          id: 1
          name: 'Яндекс.Деньги'
          logo: 'yandexmoney'
          short: 'ym'
        ,
          id: 2
          name: 'Оплата картой'
          logo: 'creditcard'
          short: 'ym'
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
        $('.store-jumbotrons').bxSlider
          controls: false
          auto    : true
          pause   : 10 * 1000

      # comission is to be paid by payee
      # https://money.yandex.ru/doc.xml?id=526991
      $scope.calculateSum = (sum) ->
        # a — коэффициент комиссии. При переводе из кошелька — 0,005, при переводе с карты — 0,02.
        a = if $scope.payment_mode is 'PC' then .005 else .02
        sum + sum * (a / (1 + a))

      $scope.buy = (good) ->
        $scope.buying_good = good
        $('#enter-link').modal 'show'
        return false

      $scope.proceedPurchase = ->
        $('#enter-link').modal 'hide'
        $('#payment-methods').modal 'show'
        return false

      $scope.proceedPayment = (payment_type) ->
        # Яндекс деньги. Оплата картой или ЯД?
        if payment_type.id is 1
          $scope.payment_mode = 'PC'
        if payment_type.id is 2
          $scope.payment_mode = 'AC'

        $timeout ->
          $("#form-#{payment_type.short}").submit()
        return false
