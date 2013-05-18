require 'spec_helper'

describe Group do
  it 'should create new group' do
    expect {
      FactoryGirl.create(:group)
    }.to change { Group.count }.by 1
  end
end
