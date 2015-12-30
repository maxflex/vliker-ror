class MainController < ApplicationController
  def index
    @random_good = Good::sample
    @notification_count = Notification::count(session[:user]['id'])
  end
end
