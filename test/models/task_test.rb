require 'test_helper'

class TaskTest < ActiveSupport::TestCase

  test "url should be valid" do
    task = Task.new

    # blank url
    assert task.invalid?
    assert_equal [I18n.t('errors.blank_url')], task.errors[:base]

    # example url sent
    task.url = Task::EXAMPLE_URLS.at(0)
    assert task.invalid?
    assert_equal [I18n.t('errors.this_is_example')], task.errors[:base]

    # url should start with http://vk.com/
    task.url = 'http://google.com'
    assert task.invalid?
    assert_equal [I18n.t('errors.should_start_with_vk_com')], task.errors[:base]

    task.url = 'http://vk.com/'
    task.invalid?
    assert_not_equal [I18n.t('errors.should_start_with_vk_com')], task.errors[:base]

    # url should have the target params after vk.com
    assert_equal [I18n.t('errors.specify_address')], task.errors[:base]
    task.url = 'https://vk.com/wall155662180_4692'

    assert task.valid?, task.errors.full_messages
  end
  
  test "url shortened correctly" do
    task = Task.new(url: 'https://vk.com/vlikerhelp?z=photo316834465_374446185%2Falbum316834465_0%2Frev')
    assert_equal task.url, 'http://vk.com/photo316834465_374446185'
    assert_equal task.url_original, 'https://vk.com/vlikerhelp?z=photo316834465_374446185%2Falbum316834465_0%2Frev'
    assert_equal task.url_short, 'photo316834465_374446185'
  end
  # test "the truth" do
  #   assert true
  # end
end
