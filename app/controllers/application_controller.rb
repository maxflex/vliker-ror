class ApplicationController < ActionController::Base
  include UserAuth
  # Prevent CSRF attacks by raising an exception. Test
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :create_and_login
  after_action  :set_csrf_cookie_for_ng

  def pretty_type(object)
     render text: "<pre>" + object.to_yaml + "</pre>"
  end

  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  protected
    # In Rails 4.2 and above
    def verified_request?
      super || valid_authenticity_token?(session, request.headers['X-XSRF-TOKEN'])
    end

end
