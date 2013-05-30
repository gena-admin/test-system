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
      it { FactoryGirl.build(:choice, :title_uk => nil).should have(1).error_on(:title_uk) }
      it { FactoryGirl.build(:choice, :title_uk => '').should have(1).error_on(:title_uk) }
      it { FactoryGirl.build(:choice, :title_ru => nil).should have(1).error_on(:title_ru) }
      it { FactoryGirl.build(:choice, :title_ru => '').should have(1).error_on(:title_ru) }
      it { FactoryGirl.build(:choice, :title_en => nil).should have(1).error_on(:title_en) }
      it { FactoryGirl.build(:choice, :title_en => '').should have(1).error_on(:title_en) }
    end

    context 'is_correct' do
      it { FactoryGirl.build(:choice, :is_correct => nil).should have(1).error_on(:is_correct) }
      it { FactoryGirl.build(:choice, :is_correct => true).should be_valid }
      it { FactoryGirl.build(:choice, :is_correct => false).should be_valid }
    end
  end

  context '#title' do
    let(:choice) do
      FactoryGirl.build :choice,
                        :title_uk => 'Hello Uk',
                        :title_ru => 'Hello Ru',
                        :title_en => 'Hello En'
    end

    it { choice.title(:uk).should == 'Hello Uk' }
    it { choice.title(:ru).should == 'Hello Ru' }
    it { choice.title(:en).should == 'Hello En' }

    it 'should return ukrainian variant if locale set to ukrainian' do
      I18n.locale = :uk
      choice.title.should == 'Hello Uk'
    end

    it 'should return russian variant if locale set to russian' do
      I18n.locale = :ru
      choice.title.should == 'Hello Ru'
    end

    it 'should return english variant if locale set to english' do
      I18n.locale = :en
      choice.title.should == 'Hello En'
    end
  end
end
