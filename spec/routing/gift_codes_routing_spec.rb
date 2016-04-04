require "rails_helper"

RSpec.describe GiftCodesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/gift_codes").to route_to("gift_codes#index")
    end

    it "routes to #new" do
      expect(:get => "/gift_codes/new").to route_to("gift_codes#new")
    end

    it "routes to #show" do
      expect(:get => "/gift_codes/1").to route_to("gift_codes#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/gift_codes/1/edit").to route_to("gift_codes#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/gift_codes").to route_to("gift_codes#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/gift_codes/1").to route_to("gift_codes#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/gift_codes/1").to route_to("gift_codes#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/gift_codes/1").to route_to("gift_codes#destroy", :id => "1")
    end

  end
end
