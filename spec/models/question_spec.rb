require 'spec_helper'

describe Question do
  it 'should create new question' do
    expect {
      FactoryGirl.create(:question)
    }.to change { Question.count }.by 1
  end

  context 'validation' do
    context 'title' do
      it { FactoryGirl.build(:question, :title_en => nil).should have(1).error_on(:title_en) }
      it { FactoryGirl.build(:question, :title_en => '').should have(1).error_on(:title_en) }
      it { FactoryGirl.build(:question, :title_ru => nil).should have(1).error_on(:title_ru) }
      it { FactoryGirl.build(:question, :title_ru => '').should have(1).error_on(:title_ru) }
      it { FactoryGirl.build(:question, :title_uk => nil).should have(1).error_on(:title_uk) }
      it { FactoryGirl.build(:question, :title_uk => '').should have(1).error_on(:title_uk) }
    end

    context 'hint' do
      it { FactoryGirl.build(:question, :hint_en => nil).should have(1).error_on(:hint_en) }
      it { FactoryGirl.build(:question, :hint_en => '').should have(1).error_on(:hint_en) }
      it { FactoryGirl.build(:question, :hint_ru => nil).should have(1).error_on(:hint_ru) }
      it { FactoryGirl.build(:question, :hint_ru => '').should have(1).error_on(:hint_ru) }
      it { FactoryGirl.build(:question, :hint_uk => nil).should have(1).error_on(:hint_uk) }
      it { FactoryGirl.build(:question, :hint_uk => '').should have(1).error_on(:hint_uk) }
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

  context '#title' do
    let(:question) do
      FactoryGirl.build :question,
                        :title_uk => 'Hello Uk',
                        :title_ru => 'Hello Ru',
                        :title_en => 'Hello En'
    end

    it { question.title(:uk).should == 'Hello Uk' }
    it { question.title(:ru).should == 'Hello Ru' }
    it { question.title(:en).should == 'Hello En' }

    it 'should return ukrainian variant if locale set to ukrainian' do
      I18n.locale = :uk
      question.title.should == 'Hello Uk'
    end

    it 'should return russian variant if locale set to russian' do
      I18n.locale = :ru
      question.title.should == 'Hello Ru'
    end

    it 'should return english variant if locale set to english' do
      I18n.locale = :en
      question.title.should == 'Hello En'
    end
  end

  context '#hint' do
    let(:question) do
      FactoryGirl.build :question,
                        :hint_uk => 'Hello Uk',
                        :hint_ru => 'Hello Ru',
                        :hint_en => 'Hello En'
    end

    it { question.hint(:uk).should == 'Hello Uk' }
    it { question.hint(:ru).should == 'Hello Ru' }
    it { question.hint(:en).should == 'Hello En' }

    it 'should return ukrainian variant if locale set to ukrainian' do
      I18n.locale = :uk
      question.hint.should == 'Hello Uk'
    end

    it 'should return russian variant if locale set to russian' do
      I18n.locale = :ru
      question.hint.should == 'Hello Ru'
    end

    it 'should return english variant if locale set to english' do
      I18n.locale = :en
      question.hint.should == 'Hello En'
    end
  end
end
