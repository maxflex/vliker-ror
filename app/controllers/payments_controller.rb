class PaymentsController < ActionController::Base
  require 'digest/sha1'

  skip_before_action :verify_authenticity_token
  layout false

  def yandex
    secret_word = 'y5ueBJksgAjmqbZ6eBcIxUBs'
    order_data = params[:label].split '|'
    good = Good.find(order_data[0])

    # check sum
    return if params[:amount].to_i < good.price

    # hash generate
    hash = [
      params[:notification_type],
      params[:operand_id],
      params[:amount],
      params[:currency],
      params[:datetime],
      params[:sender],
      params[:codepro],
      secret_word,
      params[:label]
    ].join('&')

    # check hash
    # puts hash.colorize :yellow
    # puts Digest::SHA1.hexdigest(hash).colorize :red
    # puts params[:sha1_hash].colorize :green
    return if Digest::SHA1.hexdigest(hash) != params[:sha1_hash]

    order = Order.new(good_id: order_data[0], link: order_data[1])

    if !order_data[3].nil? && order_data[3].to_i > 0
      order.user_id = order_data[3]
    end

    order.save

    render text: 'HTTP 200 OK'
  end

  def webmoney
  end
end
