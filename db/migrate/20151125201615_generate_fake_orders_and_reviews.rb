class GenerateFakeOrdersAndReviews < ActiveRecord::Migration
  def up
    Review.delete_all
    Order.delete_all
    ActiveRecord::Base.connection.reset_pk_sequence!(Review.table_name)
    ActiveRecord::Base.connection.reset_pk_sequence!(Order.table_name)
    seed_orders
    seed_reviews
  end

  def down
    Review.delete_all
    Order.delete_all
    ActiveRecord::Base.connection.reset_pk_sequence!(Review.table_name)
    ActiveRecord::Base.connection.reset_pk_sequence!(Order.table_name)
  end

  private

    def seed_orders
      Order.create([
          {
            id: 1,
            link: 'http://vk.com/phuket_svadba',
            good_id: 9,
            date_done: DateTime.new(2015, 11, 10, 22, 30, 0),
            done: true,
          },
          {
            id: 2,
            link: 'https://vk.com/id213588529',
            good_id: 8,
            date_done: DateTime.new(2015, 11, 13, 18, 0, 0),
            done: true,
          },
          {
            id: 3,
            link: 'https://vk.com/escfan',
            good_id: 9,
            date_done: DateTime.new(2015, 11, 20, 15, 18, 0),
            done: true,
          },
          {
            id: 4,
            link: 'https://vk.com/vystoni',
            good_id: 2,
            date_done: DateTime.new(2015, 11, 25, 11, 12, 0),
            done: true,
          },
          {
            id: 5,
            link: 'http://vk.com/photo-18978562_366077303',
            good_id: 7,
            date_done: DateTime.new(2015, 11, 29, 17, 49, 0),
            done: true,
          },
          {
            id: 6,
            link: 'https://vk.com/id8468668',
            good_id: 2,
            date_done: DateTime.new(2015, 12, 1, 18, 12, 0),
            done: true,
          },
          {
            id: 7,
            link: 'https://vk.com/club54529206',
            good_id: 3,
            date_done: DateTime.new(2015, 12, 2, 11, 0, 0),
            done: true,
          },
      ])
    end

    def seed_reviews
      Review.create([
          {
            order_id: 1,
            text: 'Все круто , за сутки накрутили 1100 , живых целехоньких!!! респект',
            hidden: 0,
          },
          {
            order_id: 2,
            text: 'Отличный сервис! Хорошее качество по низкой цене. Очень доволен услугами!',
            hidden: 0,
          },
          {
            order_id: 3,
            text: 'Спасибо за 1000 подписчиков )))всем советую vliker',
            hidden: 0,
          },
          {
            order_id: 4,
            text: 'Хороший сайт. Очень приемлемые цены и качество работы!',
            hidden: 0,
          },
          {
            order_id: 5,
            text: 'Была история, мне предложили сделать сайт убеждая что звонки будут, я согласился, отдал за это 24 000 с раскруткой свои знакомым, до мая 2014 года был один звонок создался он в конце сентября 2013. Тут  выполнили заказ,  потом люди  выходят из группы, 20% теряется, но что Вы написали правда, меня это устроило, Я доволен!',
            hidden: 0,
          },
          {
            order_id: 6,
            text: 'Хороший сайт, удобен в использовании, есть возможность добавлять как маленькое так и большое кол-во лайков и т.д. Отличная поддержка, любые недочёты в работе решаются быстро и без проблем!',
            hidden: 0,
          },
          {
            order_id: 7,
            text: 'Очень благодарю вас за такой крутой сайт, вы молодцы! Так держать!!!',
            hidden: 0,
          },
      ])
    end
end
