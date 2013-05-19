require 'spec_helper'

describe Attack::QuestionsController do
  let(:user) { FactoryGirl.create(:user) }

  before :each do
    sign_in user
  end


  describe "GET 'create'" do
    it "returns http success" do
      post 'create'
      response.should be_success
    end
  end

  describe "GET 'destroy'" do
    it "returns http success" do
      delete 'destroy', :id => 1
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show', :id => 1
      response.should be_success
    end
  end
end
