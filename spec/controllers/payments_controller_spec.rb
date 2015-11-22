require 'rails_helper'

RSpec.describe PaymentsController, type: :controller do
  describe '#yandex' do
    before(:each) do
      @yandex_params = {
        price: 299,
        label: '5|http://vk.com/maxflex|1',
        amount: 300,
        sha1_hash: '01ec62152932ed5167212d44d668f56ed456afd1',
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
