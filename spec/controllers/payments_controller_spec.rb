require 'rails_helper'

RSpec.describe PaymentsController, type: :controller do
  describe '#yandex' do
    before(:each) do
      # @yandex_params = {
      #   "notification_type" => "p2p-incoming",
      #   "amount"            => "99.00",
      #   "datetime"          => "2015-11-24T21:47:53Z",
      #   "codepro"           => "false",
      #   "withdraw_amount"   => "99.49",
      #   "sender"            => "410012561510457",
      #   "sha1_hash"         => "2f49af9ecc9e344506da531af27c9df3cc4f6824",
      #   "unaccepted"        => "false",
      #   "operation_label"   => "1de6ee87-0009-5000-8000-0000043bb2db",
      #   "operation_id"      => "1003433746346138009",
      #   "currency"          => "643",
      #   "label"             => "2|http://vk.com/maxflex3|undefined"
      # }
      @yandex_params = {"notification_type"=>"card-incoming", "amount"=>"98.93", "datetime"=>"2016-01-01T14:18:39Z", "codepro"=>"false", "withdraw_amount"=>"100.95", "sender"=>"", "sha1_hash"=>"1eea905f361ccadefe0f87898316253270a550e4", "unaccepted"=>"false", "operation_label"=>"1e189e35-0002-5000-8033-92bfb193f089", "operation_id"=>"504973119502024012", "currency"=>"643", "label"=>"2|https://vk.com/id317483531|29836"}
    end

    it "returns 'HTTP 200 OK' if no errors" do
      post :yandex, @yandex_params
      expect(response.body).to eq('HTTP 200 OK')
    end
  end
end
