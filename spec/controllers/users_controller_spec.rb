require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  context "#store" do
    it "creates a new user" do
      user_count_before_create = User.count
      # creating a user
      get :user_id, format: :json

      user_count_after_create = User.count

      # now there's should be 1 more user
      expect(user_count_after_create - user_count_before_create ).to eq(1)
    end

    it "doesn't create a new user, if exists" do
      session[:user] = User.first.attributes

      user_count_before_create = User.count
      # creating a user
      get :user_id, format: :json

      user_count_after_create = User.count

      # now there's should be 1 more user
      expect(user_count_after_create - user_count_before_create ).to eq(0)
    end

    it "returns new user ID" do
      get :user_id, format: :json
      expect(response.body.to_i).to eq(User.last.id)
    end

    it "returns existing user ID" do
      session[:user] = User.first.attributes
      get :user_id, format: :json
      expect(response.body.to_i).to eq(User.first.id)
    end

  end
end
