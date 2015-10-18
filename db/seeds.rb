# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all
User.create(ip: '192.168.0.1')

Task.delete_all
Task.create([
  {
    user_id: 1,
    url: 'https://vk.com/wall1_1',
    need: 50,
    ip: '192.168.0.1',
    active: true
  },
  {
    user_id: 1,
    url: 'https://vk.com/wall1_2',
    need: 30,
    ip: '192.168.0.2',
    active: true
  },
  {
    user_id: 1,
    url: 'https://vk.com/wall1_3',
    need: 25,
    ip: '192.168.0.3',
    active: true
  },
  {
    user_id: 1,
    url: 'https://vk.com/wall1_4',
    need: 24,
    ip: '192.168.0.4',
    active: true
  },
  {
    user_id: 1,
    url: 'https://vk.com/wall1_5',
    need: 102,
    ip: '192.168.0.5',
    active: true
  },
  {
    user_id: 1,
    url: 'https://vk.com/wall1_6',
    need: 26,
    ip: '192.168.0.6',
    active: true
  },
  {
    user_id: 1,
    url: 'https://vk.com/wall1_7',
    need: 102,
    ip: '192.168.0.5',
    active: true
  },
  {
    user_id: 1,
    url: 'https://vk.com/wall1_8',
    need: 26,
    ip: '192.168.0.6',
    active: true
  },
  {
    user_id: 1,
    url: 'https://vk.com/wall1_9',
    need: 102,
    ip: '192.168.0.5',
    active: true
  },
  {
    user_id: 1,
    url: 'https://vk.com/wall1_10',
    need: 26,
    ip: '192.168.0.6',
    active: true
  },
])
