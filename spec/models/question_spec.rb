require 'spec_helper'

describe Question do
  it 'should create new question' do
    expect {
      FactoryGirl.create(:question)
    }.to change { Question.count }.by 1
  end

  context 'validation' do
    context 'title' do
      it { FactoryGirl.build(:question, :title => nil).should have(1).error_on(:title) }
      it { FactoryGirl.build(:question, :title => '').should have(1).error_on(:title) }
    end

    context 'hint' do
      it { FactoryGirl.build(:question, :hint => nil).should have(1).error_on(:hint) }
      it { FactoryGirl.build(:question, :hint => '').should have(1).error_on(:hint) }
    end

    context 'sec' do
      it { FactoryGirl.build(:question, :sec => nil).should have(1).error_on(:sec) }
      it { FactoryGirl.build(:question, :sec => 0).should have(1).error_on(:sec) }
      it { FactoryGirl.build(:question, :sec => -1).should have(1).error_on(:sec) }
    end

    context 'url' do
      it { FactoryGirl.build(:question, :video_url => nil).should have(1).error_on(:video_url) }
      it { FactoryGirl.build(:question, :video_url => '').should have(1).error_on(:video_url) }
      it { FactoryGirl.build(:question, :video_url => 'http://youtube.com/watch?v=n').should have(1).error_on(:video_url) }
    end
  end
end
