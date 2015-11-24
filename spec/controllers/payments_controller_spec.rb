require 'rails_helper'

RSpec.describe PaymentsController, type: :controller do
  describe '#yandex' do
    before(:each) do
      @yandex_params = {
        "notification_type" =>"p2p-incoming",
        "amount"            =>"99.00",
        "datetime"          =>"2015-11-24T21:47:53Z",
        "codepro"           =>"false",
        "withdraw_amount"   =>"99.49",
        "sender"            =>"410012561510457",
        "sha1_hash"         =>"2f49af9ecc9e344506da531af27c9df3cc4f6824",
        "unaccepted"        =>"false",
        "operation_label"   =>"1de6ee87-0009-5000-8000-0000043bb2db",
        "operation_id"      =>"1003433746346138009",
        "currency"          =>"643",
        "label"             =>"2|http://vk.com/maxflex3|undefined"
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
