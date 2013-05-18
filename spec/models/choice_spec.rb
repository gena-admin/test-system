require 'spec_helper'

describe Choice do
  it 'should create new choice' do
    expect {
      FactoryGirl.create(:choice)
    }.to change { Choice.count }.by 1
  end

  context 'validation' do
    context 'question' do
      it { FactoryGirl.build(:choice, :question => nil).should have(1).error_on(:question) }
      it { FactoryGirl.build(:choice, :question_id => 0).should have(1).error_on(:question) }
    end

    context 'title' do
      it { FactoryGirl.build(:choice, :title => nil).should have(1).error_on(:title) }
      it { FactoryGirl.build(:choice, :title => '').should have(1).error_on(:title) }
    end

    context 'is_correct' do
      it { FactoryGirl.build(:choice, :is_correct => nil).should have(1).error_on(:is_correct) }
      it { FactoryGirl.build(:choice, :is_correct => true).should be_valid }
      it { FactoryGirl.build(:choice, :is_correct => false).should be_valid }
    end
  end
end
