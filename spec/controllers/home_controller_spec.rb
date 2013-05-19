require 'spec_helper'

describe HomeController do
  let(:user) { FactoryGirl.create(:user) }

  before :each do
    sign_in user
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

end
