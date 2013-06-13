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

  context '#next_question!' do
    let(:quiz) { FactoryGirl.create(:quiz) }

    context 'for one available question' do
      let!(:question) { FactoryGirl.create(:question) }
      let(:answer) { quiz.next_answer! }

      it { answer.quiz.should == quiz }
      it { answer.question.should == question }
    end

    context 'for one available question and with one answer' do
      let!(:question) { FactoryGirl.create(:question) }
      before { FactoryGirl.create(:answer, :quiz => quiz) }
      let(:answer) { quiz.next_answer! }

      it { answer.quiz.should == quiz }
      it { answer.question.should == question }
    end

    context 'for one available question and with one answer' do
      let!(:questions) do
        result = []
        5.times { result << FactoryGirl.create(:question) }
        result
      end
      let(:answer) { quiz.next_answer! }

      it { answer.quiz.should == quiz }
      it { questions.should include answer.question }
    end
  end

  context '#correct_answers' do
    let(:quiz) { FactoryGirl.create(:quiz) }

    before :each do
      2.times {
        FactoryGirl.create(:answer_with_incorrect_choice, :quiz => quiz)
      }
      2.times {
        FactoryGirl.create(:answer)
      }
      FactoryGirl.create(:answer_with_correct_choice, :quiz => quiz)
    end

    it { Answer.should have(5).records }
    it { quiz.answers.should have(3).record }
    it { quiz.correct_answers.should have(1).record }
    it { quiz.correct_answers.count.should == 1}
  end

  context '#ang_anser_time' do
    #TODO: All calculation based on question factory set video sec to 3 and time for page load is 1
    let(:now) { Time.now }
    let(:quiz) { FactoryGirl.create(:quiz) }

    before :each do
      FactoryGirl.create(:answer_with_correct_choice, :quiz => quiz, :started_at => now, :answered_at => now + 7)
      FactoryGirl.create(:answer_with_correct_choice, :quiz => quiz, :started_at => now, :answered_at => now + 8)
      FactoryGirl.create(:answer_with_correct_choice, :quiz => quiz, :started_at => now, :answered_at => now + 9)
    end

    it { quiz.avg_answer_time.should == 2 }
  end

  context '#close!' do
    let(:quiz) { FactoryGirl.create(:quiz) }

    before :each do
      FactoryGirl.create(:answer, :quiz => quiz)
      FactoryGirl.create(:answer, :answered_at => nil, :quiz => quiz)
      FactoryGirl.create(:answer, :quiz => quiz)
      quiz.reload
    end

    it 'Should close each opened answer' do
      Answer.any_instance.should_receive(:close!)
      quiz.close!
    end
  end
end
