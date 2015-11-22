class PaymentsController < ActionController::Base
  skip_before_action :verify_authenticity_token
  layout false

  def yandex
    render text: 'HTTP 200 OK'
  end

  def webmoney
  end
end
