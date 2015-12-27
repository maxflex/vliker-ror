class MainController < ApplicationController
  def index
    @random_good = Good::sample
  end
end
