require 'rails_helper'

RSpec.describe MainController, type: :controller do
  describe '#index' do
    it 'creates a session user' do
      get :index
      expect(session[:user]).to be_present
    end
  end
end
