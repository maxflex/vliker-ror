# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Task.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!(Task.table_name)

User.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!(User.table_name)

User.create(ip: '213.184.130.66')

Task.create([
  {
    user_id: 1,
    url: 'https://vk.com/id283230003?z=photo283230003_382855474%2Fphotos283230003',
    need: 10,
    ip: '192.168.0.1',
    active: true
  },
  {
    user_id: 1,
    url: 'http://vk.com/dobberman96?w=wall168628612_1410%2Fall',
    need: 10,
    ip: '192.168.0.2',
    active: true
  },
  {
    user_id: 1,
    url: 'http://vk.com/id303413484?z=photo303413484_380748921%2Fphotos303413484',
    need: 10,
    ip: '192.168.0.3',
    active: true
  },
  {
    user_id: 1,
    url: 'https://vk.com/danilova_vd?z=photo311551377_387199818%2Falbum311551377_0%2Frev',
    need: 10,
    ip: '192.168.0.4',
    active: true
  },
  {
    user_id: 1,
    url: 'http://vk.com/photo240622449_377784141',
    need: 10,
    ip: '192.168.0.5',
    active: true
  },
  {
    user_id: 1,
    url: 'http://vk.com/klepicov15?z=photo184066602_383751152%2Fphotos184066602',
    need: 10,
    ip: '192.168.0.6',
    active: true
  },
  {
    user_id: 1,
    url: 'https://vk.com/id240622449?z=photo240622449_335534859%2Falbum240622449_0%2Frev',
    need: 10,
    ip: '192.168.0.5',
    active: true
  },
  {
    user_id: 1,
    url: 'http://vk.com/bmmary?z=photo3528500_385952167%2Falbum3528500_0%2Frev',
    need: 10,
    ip: '192.168.0.6',
    active: true
  },
  {
    user_id: 1,
    url: 'http://vk.com/wall34377350_4609',
    need: 10,
    ip: '192.168.0.5',
    active: true
  },
  {
    user_id: 1,
    url: 'http://vk.com/id314915717?z=photo314915717_382876399%2Falbum314915717_0%2Frev',
    need: 10,
    ip: '192.168.0.6',
    active: true
  },
])
