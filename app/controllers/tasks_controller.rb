class TasksController < ApplicationController
  include UserAuth

  #
  # Start VLiker and get 6 tasks
  #
  def blocks
    # trying to find task by url
    url = Task.shorten_url(params[:url])

    @task = Task.find_by(url_short: url)

    # create new task if not found by url
    unless @task.present?
      @task = Task.new(url: params[:url], ip: request.remote_ip)
    end
    respond_to do |format|
      if @task.valid?
        # remember the current task in session
        session[:task] = @task.attributes

        logger.debug session[:user].to_yaml.colorize :blue
        logger.debug session[:task].to_yaml.colorize :red

        # get 6 new tasks for user to display
        @six_tasks = Task.get_new_tasks(session[:user], 6)

        begin
          # set the last seen id for the user
          session[:user]['last_seen_task'] = @six_tasks.max_by {|t| t.id}.id
        rescue NoMethodError
        end

        format.json {render :json => {tasks: @six_tasks, current_task: @task} }
        format.html {render :json => {tasks: @six_tasks, current_task: @task} }
      else
        format.html {render :json => @task.errors.full_messages, status: :unprocessable_entity}
        format.json {render :json => @task.errors.full_messages, status: :unprocessable_entity}
      end
    end
  end

  #
  # Get one new task
  #
  def get_new
    logger.debug params.to_yaml.colorize :blue
    logger.debug session[:user].to_yaml.colorize :red

    @new_task = Task.get_new_tasks(session[:user]).first()

    # update last seen task
    if !@new_task.nil?
      session[:user]['last_seen_task'] = @new_task.id if session[:user]['last_seen_task'] < @new_task.id
    end

    respond_to do |format|
      format.json {render :json => @new_task}
    end
  end

  #
  # Stop and add likes
  #
  def stop
    # validate likes
    valid_task_ids = Task.verify_likes params[:task_data]

    # if there is valid tasks
    if !valid_task_ids.nil? && valid_task_ids.length >= Rails.configuration.min_task_count
      logger.debug params[:task_data].to_yaml.colorize :green
      logger.debug valid_task_ids.to_yaml.colorize :blue

      # add likes to OTHERS
      Task.like_others valid_task_ids

      # report tasks
      Task.report params[:task_report_ids]

      # if user has not yet been created
      if session[:user]['id'].nil?
        user = User.new(session[:user])
        user.save
        session[:user] = user.attributes

        # save user id to cookie
        to_cookie(user.id)
      else
        user = User.find(session[:user]['id'])
      end

      logger.debug session[:task].to_yaml.colorize :blue

      # if task has not yet been saved in db
      if session[:task]['id'].blank?
        task = user.tasks.create(session[:task])
      else
        task = Task.find(session[:task]['id'])
      end

      # add likes to OWN task
      likes_count ||= 0

      if !valid_task_ids.nil?
        likes_count += valid_task_ids.length
      end

      if !params[:task_report_ids].nil?
        likes_count += params[:task_report_ids].length
      end

      task.add_needed(likes_count)

      # remember the last task so its offered instead of example url
      cookies[:last_task] = task.url
    end

    respond_to do |format|
      format.json {render :json => true}
    end
  end


  #
  # Stats
  #
  def stats
    user_id = session[:user]['id']
    if !user_id.nil?
      @tasks = Task::get_stats(user_id)
      @orders = Order::stats(user_id)
    end
  end

end
