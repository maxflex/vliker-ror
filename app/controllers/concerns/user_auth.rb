module UserAuth extend ActiveSupport::Concern
  # include ActiveSupport::Cookies
  require 'digest/md5'

  SALT = "32dg9823dldfg2o001-2134>?erj&*(&(*^";

  protected

  # create user first
  def create_and_login
    # reset_session
    if !session[:user].present?
      if !from_cookie
        session[:user] = User.new(ip: request.remote_ip).attributes
      end
    end
  end

  # user from cookie
  def from_cookie
    return false unless cookies[:u2token].present?
    # user id stored in cookies as a md5-hash
    # ending with the actual user id
    user_id = cookies[:u2token].from(32)
    user = User.find(user_id)
    if user
      session[:user] = user.attributes
      return true
    else
      return false
    end
  end

  # user to cookie
  def to_cookie(user_id)
    token = Digest::MD5.hexdigest(SALT + user_id.to_s + SALT)
    cookies[:u2token] = {
      value: token + user_id.to_s,
      expires: 1.year.from_now,
    }
  end

  #
  # Admin page is only accessible when cookies[:admin] is set
  #
  def admin_check
    if params[:controller] == "rails_admin/main" && !cookies[:admin].present?
      redirect_to main_app.root_path
    end
  end
end
