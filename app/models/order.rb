class Order < ActiveRecord::Base
  include OrderExternal

  belongs_to :good
  belongs_to :user
  has_one :review

  def external_order
    external_login
    add_order_to_cart
    order
    update_status
    save
  end

  #
  # CRON: Update status
  #
  def self.update_statuses(count)
    @orders = Order.joins(:good).where(goods: {count: count}, done: false)
    if @orders.any?
      @orders.each do |order|
        order.external_login
        order.update_status
        order.save
      end
    end
  end

end
