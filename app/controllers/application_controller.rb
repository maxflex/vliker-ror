class ApplicationController < ActionController::Base
  include UserAuth
  # Prevent CSRF attacks by raising an exception. Test
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :create_and_login
  before_action :admin_check
  before_action :set_locale

  after_action  :set_csrf_cookie_for_ng

  protected
    def set_csrf_cookie_for_ng
      cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
    end

    # In Rails 4.2 and above
    def verified_request?
      super || valid_authenticity_token?(session, request.headers['X-XSRF-TOKEN'])
    end

    # Only admin page in English
    def set_locale
      if params[:controller] == "rails_admin/main"
        I18n.locale = :en
      else
        I18n.locale = :ru
      end
    end
end
