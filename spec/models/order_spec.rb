require 'rails_helper'

# ОЧИСТИТЬ КОРЗИНУ ПЕРЕД ВЫПОЛНЕНИЕМ ТЕСТОВ

RSpec.describe Order, type: :model do
  context "#external" do
    before (:each) do
      @order = Order.first
    end

    it 'logins external service' do
      @order.external_login
      expect(@order.cookie).to be_present
      puts @order.cookie.colorize :blue
    end

    it 'adds order to cart' do
      # если раскоментить, то будет добавлять в корзину акканту
      # иначе просто добавить в корзину гостя, тоже работает
      # @order.external_login
      @order.add_order_to_cart
      expect(@order.external_id).to be > 0
    end

    it 'updates order status' do
      @order.add_order_to_cart
      @order.update_status
      expect(@order.external_done).to eq(0)
      expect(@order.external_need).to eq(@order.good.count)
    end
  end
end
