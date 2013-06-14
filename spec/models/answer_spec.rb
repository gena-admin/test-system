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

  it 'should create new answer with started_at initiated from created_at' do
    answer = FactoryGirl.create(:answer)
    answer.started_at.should == answer.created_at
  end

  context 'validation' do
    context 'question' do
      it { FactoryGirl.build(:answer, :question => nil).should have(1).error_on(:question) }
      it { FactoryGirl.build(:answer, :question_id => 0).should have(1).error_on(:question) }
    end

    context 'choice' do
      it { FactoryGirl.build(:answer, :choice_id => 0).should have(1).error_on(:choice) }
      it { FactoryGirl.build(:answer, :choice => FactoryGirl.create(:choice)).should have(1).error_on(:choice) }
    end
  end

  context '#correct?' do
    it { FactoryGirl.build(:answer).should_not be_correct }
    it { FactoryGirl.build(:answer_with_incorrect_choice).should_not be_correct }
    it { FactoryGirl.build(:answer_with_correct_choice).should be_correct }
  end

  context '#time_out?' do
    let(:now) { Time.now }

    it { FactoryGirl.build(:answer, :started_at => now, :answered_at => now + 1).should_not be_time_out }
    it { FactoryGirl.build(:answer, :started_at => now, :answered_at => now + 100).should be_time_out }
  end

  context '#spent_time' do
    #TODO: All calculation based on question factory set video sec to 3 and time for page load is 1
    let(:now) { Time.now }

    it { FactoryGirl.build(:answer, :started_at => now, :answered_at => now + 8).spent_time.should == 2 }
  end

  context '#closed?' do
    it { FactoryGirl.build(:answer, :answered_at => nil).should_not be_closed }
    it { FactoryGirl.build(:answer).should be_closed }
  end

  context 'scopes' do
    context 'correct' do
      before :each do
        3.times {
          FactoryGirl.create(:answer_with_correct_choice)
        }
        FactoryGirl.create(:answer_with_incorrect_choice)
      end

      it { Answer.correct.should have(3).records }
    end

    context 'opened/closed' do
      before :each do
        3.times {
          FactoryGirl.create(:answer, :answered_at => nil)
        }
        FactoryGirl.create(:answer)
      end

      it { Answer.should have(4).records }
      it { Answer.opened.should have(3).records }
      it { Answer.closed.should have(1).records }
    end
  end
end
