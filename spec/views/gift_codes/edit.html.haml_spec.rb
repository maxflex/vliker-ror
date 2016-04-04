require 'rails_helper'

RSpec.describe "gift_codes/edit", type: :view do
  before(:each) do
    @gift_code = assign(:gift_code, GiftCode.create!(
      :good => nil,
      :code => "MyString",
      :activated => false,
      :user => nil
    ))
  end

  it "renders the edit gift_code form" do
    render

    assert_select "form[action=?][method=?]", gift_code_path(@gift_code), "post" do

      assert_select "input#gift_code_good_id[name=?]", "gift_code[good_id]"

      assert_select "input#gift_code_code[name=?]", "gift_code[code]"

      assert_select "input#gift_code_activated[name=?]", "gift_code[activated]"

      assert_select "input#gift_code_user_id[name=?]", "gift_code[user_id]"
    end
  end
end
