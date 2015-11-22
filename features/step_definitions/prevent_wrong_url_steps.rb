Given /^the url is "(.*)"$/ do |url|
  set_speed(:slow)
  visit root_path
  fill_in 'main-input', :with => url
end

When /^I submit the url$/ do
  set_speed(:slow)
  click_button 'start-button'
end

Then /^the error message should be$/ do |error|
  set_speed(:slow)
  expect(page).to have_content(error)
end
