require 'rails_helper'

RSpec.describe PaymentsController, type: :controller do
  describe '#yandex' do
    before(:each) do
      @yandex_params = {
        price: 299
      }
    end

    it 'returns if price is less'
    it 'returns if hash is incorrect'

    it "returns 'HTTP 200 OK' if no errors" do
      post :yandex, @yandex_params
      expect(response.body).to eq('HTTP 200 OK')
    end

    it 'gets external info'
  end
end
