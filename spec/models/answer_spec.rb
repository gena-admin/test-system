require 'spec_helper'

describe Answer do
  it 'should create new answer' do
    expect {
      FactoryGirl.create(:answer)
    }.to change{ Answer.count }.by 1
  end

  it 'should create new answer with choice' do
    expect {
      FactoryGirl.create(:answer_with_choice)
    }.to change{ Answer.count }.by 1
  end

  context 'validation' do
    context 'question' do
      it { FactoryGirl.build(:answer, :question => nil).should have(1).error_on(:question) }
      it { FactoryGirl.build(:answer, :question_id => 0).should have(1).error_on(:question) }
    end
  end
end
