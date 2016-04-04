require 'rails_helper'

RSpec.describe "gift_codes/show", type: :view do
  before(:each) do
    @gift_code = assign(:gift_code, GiftCode.create!(
      :good => nil,
      :code => "Code",
      :activated => false,
      :user => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Code/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(//)
  end
end
