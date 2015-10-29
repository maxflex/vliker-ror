require 'test_helper'

class StoriesTest < ActionDispatch::IntegrationTest

  setup do
    Capybara.current_driver = :selenium # :selenium by default
  end

  test "user_session_created" do
    # main page
    get root_path
    # user should exist now
    assert session[:user].present?
  end

  test "start vliker" do
    # Capybara.default_max_wait_time = 30
    visit root_path
    assert page.has_content? 'Например'

    fill_in 'main-input', :with => 'http://vk.com/'
    click_button 'start-button'

    assert page.has_content? I18n.t('errors.specify_address')
  end

end
