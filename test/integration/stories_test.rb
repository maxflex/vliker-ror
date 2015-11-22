require 'test_helper'

class StoriesTest < ActionDispatch::IntegrationTest

  setup do
    Capybara.current_driver = :webkit # :selenium by default
  end

  test "user_session_created" do
    # main page
    get root_path
    # user should exist now
    assert session[:user].present?
  end

  test "user inputs wrong urls" do
    visit root_path
    assert page.has_content? I18n.t('main.index.example_link')

    start_and_expect_error 'http://vk.com', I18n.t('errors.specify_address')
    start_and_expect_error Task::EXAMPLE_URLS.sample, I18n.t('errors.this_is_example')
    start_and_expect_error 'random string', I18n.t('errors.should_start_with_vk_com')
  end

  test "user inputs correct url" do
    visit root_path

    fill_in_url_and_start 'https://vk.com/vlikerhelp?z=photo316834465_374446185%2Falbum316834465_0%2Frev'
    # assert page.selector '#like-blocks'
  end


  private


    def fill_in_url_and_start(url)
      fill_in 'main-input', :with => url
      click_button 'start-button'
    end

    def start_and_expect_error(url, error)
      fill_in_url_and_start url
      assert page.has_content? error
    end

end
