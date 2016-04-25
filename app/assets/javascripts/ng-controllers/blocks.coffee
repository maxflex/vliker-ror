angular
  .module "VLiker"
  .constant "CONFIG",
    CORE_ENGINE: '0x000'
  .constant "STATES",
    ME: 'ME'
    MD: 'MD'
    WB: 'WB'
    WF: 'WF'
    MM: 'MM'
  .value 'TS', null
  .controller "BlocksCtrl", (CONFIG, TS, STATES, setMenu, $scope, $window, $http, $location, $timeout) ->
    $scope.task_data = []
    $scope.task_report_ids = []
    $scope.div_blocked = false
    $scope.reportTaskCount = 0
    userVip = false;

    $scope.checkVip = ->
      $http.get 'user_id'
        .then (response) ->
          $scope.user_id = response.data
          $http.post 'check_vip',
            id: $scope.user_id
          .then (response) ->
            response.data


    $window.onfocus = ->
      # activate the window
      $scope.div_blocked = false

      # if task was clicked
      if $scope.last_clicked_task
        # check if the task had not already yet been added to the task_data
        if _.findWhere($scope.task_data, {id: $scope.last_clicked_task.id}) is undefined
          # add task to the server array
          $scope.task_data.push
            id: $scope.last_clicked_task.id
            ce: CONFIG.CORE_ENGINE
            ts: new Date().getTime() - TS
          # increase likes-count
          $scope.current_task.need++
      $scope.$apply()

    $window.onblur = ->
      # VLiker should be inactive unless window.focus
      $scope.div_blocked = true

      if $scope.last_clicked_task
        # remember current time
        TS = new Date().getTime()

    ###*
     * Main task click handle
    ###
    $scope.taskClick = (task_index) ->
      task = $scope.tasks[task_index]
      $scope.last_clicked_task = task
      $window.open task.url
      $http.post('get_new').then (response) ->
        $scope.tasks[task_index] = response.data

    ###
    * Реклама группы
    ###
    $scope.group_clicked = if localStorage.getItem('group_clicked') is 'true' then true else false
    $scope.groupClick = ->
      # load task to the block
      localStorage.setItem 'group_clicked', true
      $scope.group_clicked = true
      $('#group-ad').nifty 'show'

    $scope.goGroup = ->
      $window.open 'https://vk.com/vliker_obmen'
      $('#group-ad').nifty 'hide'
      # загружаем в 4 слот задачу
      $http.post('get_new').then (response) ->
        $scope.tasks[4] = response.data

    ###*
     * Report task
    ###
    $scope.reportTask = ->
      userVip = $scope.checkVip()
      console.log $scope.task_report_ids
      if $scope.last_clicked_task
        if $scope.taskReported()
          notifySuccess 'Вы уже оставили жалобу на эту ссылку'
        else
          if $scope.reportTaskCount > 2 && userVip == false
            notifyError 'Вы можете оставить не более 3х жалоб'
          else
            if $scope.reportTaskCount > 10
              notifyError 'Вы можете оставить не более 10ти жалоб'
            else
              $scope.task_report_ids.push($scope.last_clicked_task.id)
              $scope.task_data.pop()
              notifySuccess 'Жалоба оставлена!'
              $scope.reportTaskCount++
      else
        notifyError 'Невозможно оставить жалобу – вы еще ничего не лайкнули'


    $scope.taskReported = ->
      return false if not $scope.last_clicked_task
      _.contains($scope.task_report_ids, $scope.last_clicked_task.id)

    ###*
     * Stop
    ###
    $scope.stopConfirm = ->
      likes_count = $scope.task_data.length + $scope.task_report_ids.length

      # should be at least 3 likes
      if likes_count < 3
        bootbox.alert getIconCaution() + 'Поставьте хотя бы 3 лайка, чтобы завершить накрутку'
        return

      bootbox.confirm
        message: getIconHeart() + 'Вам будет накручено <span class=\'text-success\'><b>+' + likes_count + '</b>' + glyphIcon('heart glyphicon-middle') + '</span><div class=\'hint-text\'>' + 'Убедитесь, что ваша странца открыта для всех, чтобы пользователи смогли поставить Вам лайк' + '</div>'
        buttons:
          confirm: label: 'Завершить'
          cancel:
            label: 'Продолжить накрутку'
            className: 'btn-default opacity-hover high-opacity pull-left'
        callback: (result) ->
          # если нажали "завершить", то накручиваем лайки
          if result is true
            # остановить накрутку и перейти в статистику
            $scope.stop()

    $scope.setMenu = setMenu

    $scope.stop = ->
      ajaxStart()
      $http.post 'stop',
        task_data      : $scope.task_data
        task_report_ids: $scope.task_report_ids
      .then (response) ->
        ajaxEnd()
        stopAnimation ->
          $timeout ->
            $scope.setMenu(2)
          , 700
