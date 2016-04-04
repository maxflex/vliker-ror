require 'rails_helper'

RSpec.describe GiftCode, type: :model do
  it 'generates random code' do
    code = GiftCode::generate
    puts code
    expect(code.length).to eq(6)
    expect(code).to match(/[0-9A-Z]{6}/)
  end

end
