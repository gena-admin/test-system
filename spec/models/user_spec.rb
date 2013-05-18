require 'spec_helper'

describe User do

  it 'should create new user' do
    expect {
      FactoryGirl.create(:user)
    }.to change { User.count }.by 1
  end

  context 'validation' do
    context 'email' do
      it { FactoryGirl.build(:user, :email => nil).should have(1).error_on(:user) }
      it { FactoryGirl.build(:user, :email => '').should have(1).error_on(:user) }
      it { FactoryGirl.build(:user, :email => 'asxasxas').should have(1).error_on(:user) }
      it { FactoryGirl.build(:user, :email => '1111111').should have(1).error_on(:user) }

    end

    context 'password' do
      it { FactoryGirl.build(:user, :password => nil).should have(1).error_on(:user) }
      it { FactoryGirl.build(:user, :password => '').should have(1).error_on(:user) }
      it { FactoryGirl.build(:user, :password => 'sdc').should have(0).error_on(:user) }
      it { FactoryGirl.build(:user, :password => '22').should have(0).error_on(:user) }
    end
  end


  pending "add some test for format email and password length"

end
