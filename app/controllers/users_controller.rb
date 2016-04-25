class UsersController < ApplicationController
  def user_id
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

    respond_to do |format|
      format.json { render :json => user.id }
    end
  end

  def check_vip
    user = User.find(params[:id])
    respond_to do |format|
      if user.vip === true
        format.json { render :json => true }
      else
        format.json { render :json => false }
      end
    end

  end
end
