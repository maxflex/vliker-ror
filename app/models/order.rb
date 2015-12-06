class Order < ActiveRecord::Base
  require "net/http"
  require "uri"

  belongs_to :good
  belongs_to :user

  before_save :place_external_order

  def place_external_order
    external_login
  end

  private
    def external_login
      uri = URI.parse 'http://smm-lab.xyz/'
      response = Net::HTTP::post_form(uri, {
        login: 'maxflex',
        pass: 'fuckyou',
      })
    end
end
