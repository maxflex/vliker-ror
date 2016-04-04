require 'rails_helper'

RSpec.describe "gift_codes/index", type: :view do
  before(:each) do
    assign(:gift_codes, [
      GiftCode.create!(
        :good => nil,
        :code => "Code",
        :activated => false,
        :user => nil
      ),
      GiftCode.create!(
        :good => nil,
        :code => "Code",
        :activated => false,
        :user => nil
      )
    ])
  end

  it "renders a list of gift_codes" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Code".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
