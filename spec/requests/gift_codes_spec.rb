require 'rails_helper'

RSpec.describe "GiftCodes", type: :request do
  describe "GET /gift_codes" do
    it "works! (now write some real specs)" do
      get gift_codes_path
      expect(response).to have_http_status(200)
    end
  end
end
