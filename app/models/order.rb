class Order < ActiveRecord::Base
  include OrderExternal

  belongs_to :good
  belongs_to :user

  def external_order
    external_login
    add_order_to_cart
    order
    update_status
    save
  end

end
