class SeedGoodTypes < ActiveRecord::Migration
  def up
    GoodType.create([
      {
        title: "«мне нравится»",
        price: 1,
        icon: "like",
        type_id: 128,
      },
      {
        title: "друзей",
        price: 0.1,
        icon: "friend",
        type_id: 131,
      },
      {
        title: "участников в группу",
        price: 0.08,
        icon: "group",
        type_id: 130,
      },
      {
        title: "«рассказать друзьям»",
        price: 0.1,
        icon: "share",
        type_id: 139,
      },
      {
        title: "комментариев",
        price: 1,
        icon: "comment",
        type_id: 139,
      },
      {
        title: "голосов к опросу",
        price: 1,
        icon: "poll",
        type_id: 139,
      },
    ])
  end

  def down
    GoodType.delete_all
    # Production PG version
    # ActiveRecord::Base.connection.reset_pk_sequence!(GoodType.table_name)

    # Development SQLite version
    ActiveRecord::Base.connection.execute("delete from sqlite_sequence where name='#{GoodType.table_name}'")
  end
end
