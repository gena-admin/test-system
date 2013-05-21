require 'spec_helper'

describe User do
  context '#admin?' do
    it { FactoryGirl.build(:user, :email => 'surzhkoyevhen@gmail.com').should be_admin }
    it { FactoryGirl.build(:user, :email => 'gena.admin@gmail.com').should be_admin }
  end
end
