require 'spec_helper'

describe Quiz do
  it 'should create new quiz' do
    expect {
      FactoryGirl.create(:quiz)
    }.to change{ Quiz .count }.by 1
  end

  context 'validation' do
    context 'user' do
      it { FactoryGirl.build(:quiz, :user => nil).should have(1).error_on(:user) }
      it { FactoryGirl.build(:quiz, :user_id => 0).should have(1).error_on(:user) }
    end
  end
end
