class SeedGoods < ActiveRecord::Migration
  def up
    Good.create([
        #
        # 100 PAGE
        #
        {
          good_type_id: GoodType::LIKE,
          price: 99,
          page: 1,
          count: 100,
        },
        {
          good_type_id: GoodType::FRIEND,
          price: 99,
          page: 1,
          count: 100,
        },
        {
          good_type_id: GoodType::GROUP,
          price: 99,
          page: 1,
          count: 100,
        },
        {
          good_type_id: GoodType::SHARE,
          price: 99,
          page: 1,
          count: 100,
        },
        {
          good_type_id: GoodType::COMMENT,
          price: 99,
          page: 1,
          count: 100,
        },
        {
          good_type_id: GoodType::POLL,
          price: 99,
          page: 1,
          count: 100,
        },
        #
        # 1 000 PAGE
        #
        {
          good_type_id: GoodType::LIKE,
          price: 390,
          page: 2,
          count: 1000,
        },
        {
          good_type_id: GoodType::FRIEND,
          price: 390,
          page: 2,
          count: 1000,
        },
        {
          good_type_id: GoodType::GROUP,
          price: 390,
          page: 2,
          count: 1000,
        },
        {
          good_type_id: GoodType::SHARE,
          price: 390,
          page: 2,
          count: 1000,
        },
        {
          good_type_id: GoodType::COMMENT,
          price: 390,
          page: 2,
          count: 1000,
        },
        {
          good_type_id: GoodType::POLL,
          price: 390,
          page: 2,
          count: 1000,
        },
        #
        # 10 000 PAGE
        #
        {
          good_type_id: GoodType::LIKE,
          price: 2990,
          page: 3,
          count: 10000,
        },
        {
          good_type_id: GoodType::FRIEND,
          price: 2990,
          page: 3,
          count: 10000,
        },
        {
          good_type_id: GoodType::GROUP,
          price: 2990,
          page: 3,
          count: 10000,
        },
        {
          good_type_id: GoodType::SHARE,
          price: 2990,
          page: 3,
          count: 10000,
        },
        {
          good_type_id: GoodType::COMMENT,
          price: 2990,
          page: 3,
          count: 10000,
        },
        {
          good_type_id: GoodType::POLL,
          price: 2990,
          page: 3,
          count: 10000,
        },
    ])
  end

  def down
    Good.delete_all
    # Production PG version
    ActiveRecord::Base.connection.reset_pk_sequence!(Good.table_name)

    # Development SQLite version
    # ActiveRecord::Base.connection.execute("delete from sqlite_sequence where name='#{Good.table_name}'")
  end
end
