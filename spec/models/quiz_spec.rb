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
end
