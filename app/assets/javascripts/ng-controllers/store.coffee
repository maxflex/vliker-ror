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
        false

      $scope.proceedPurchase = ->
        $('#enter-link').modal 'hide'
        $('#payment-methods').modal 'show'
        false

      $scope.proceedPayment = (payment_type) ->
        # Создаем пользователя только после того, как он нажал "купить"
        if !$scope.user_id then getUserId() else updateFormParams()
        # Если оплата Яндексом, определяем метод оплаты (карта или яд)
        if payment_type.id in [1..2] then setYandexMethod(payment_type.id)
        postForm(payment_type.short)



      #### ФУНКЦИИ ГЕНЕРАЦИИ ПЛАТЕЖА ####



      updateFormParams = ->
        # Собираем строку (id товара|ссылка на заказ для яндекса|user id)
       	$scope.goodid_link_userid = "#{$scope.buying_good.id}|#{$scope.order_url}|#{$scope.user_id}"
        $scope.desc = "Покупка +#{$scope.buying_good.count} #{$scope.buying_good.good_type.title} на VLiker.ru"
        $scope.bas64_desc = Base64.encode $scope.desc

      getUserId = ->
        $http.get 'user_id'
          .then (response) ->
            $scope.user_id = response.data
            updateFormParams()

      setYandexMethod = (payment_type_id) ->
        # Яндекс деньги. Оплата картой или ЯД?
        switch payment_type_id
          when 1 then $scope.payment_mode = 'PC'
          when 2 then $scope.payment_mode = 'AC'

      postForm = (short)->
        # не отправляем форму пока не получим user_id
        $timeout ->
          if !$scope.user_id
            postForm(short)
          else
            $("#form-#{short}").submit()
