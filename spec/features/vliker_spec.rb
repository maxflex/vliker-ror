require 'rails_helper'

RSpec.feature "VLiker", type: :feature do
  before do
    visit root_path
  end

  context "#URL", :js => true do
    it "displays an error" do
      expect(page).to have_content I18n.t('main.index.example_link')

      start_and_expect 'http://vk.com', I18n.t('errors.specify_address')
      start_and_expect Task::EXAMPLE_URLS.sample, I18n.t('errors.this_is_example')
      start_and_expect 'random string', I18n.t('errors.should_start_with_vk_com')
    end

    it "proceeds to blocks" do
      fill_in_url_and_start 'https://vk.com/vlikerhelp?z=photo316834465_374446185%2Falbum316834465_0%2Frev'
      expect(page).to have_css '#like-blocks'
    end

    it "doesnt proceed to blocks" do
      fill_in_url_and_start 'random string'
      expect(page).not_to have_css '#like-blocks'
    end
  end

  def fill_in_url_and_start(url)
    fill_in 'main-input', :with => url
    click_button 'start-button'
  end

  def start_and_expect(url, error)
    fill_in_url_and_start url
    expect(page).to have_content error
  end
end
