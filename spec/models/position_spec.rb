require 'spec_helper'

describe Position do
  it 'should create new position' do
    expect {
      FactoryGirl.create(:position)
    }.to change { Position.count }.by 1
  end

  context 'validation' do
    context 'question' do
      it { FactoryGirl.build(:position, :question => nil).should have(1).error_on(:question) }
      it { FactoryGirl.build(:position, :question_id => 0).should have(1).error_on(:question) }
    end

    context 'alignment' do
      it { FactoryGirl.build(:position, :alignment => nil).should have(1).error_on(:alignment) }
      it { FactoryGirl.build(:position, :alignment => '').should have(1).error_on(:alignment) }
      it { FactoryGirl.build(:position, :alignment => 'middle').should have(1).error_on(:alignment) }
    end

    context 'color' do
      it { FactoryGirl.build(:position, :color => nil).should have(1).error_on(:color) }
      it { FactoryGirl.build(:position, :color => '').should have(1).error_on(:color) }
    end

    context 'dx' do
      it { FactoryGirl.build(:position, :dx => -7).should have(1).error_on(:dx) }
      it { FactoryGirl.build(:position, :dx =>  7).should have(1).error_on(:dx) }
    end

    context 'dy' do
      it { FactoryGirl.build(:position, :dy => 0).should have(1).error_on(:dy) }
      it { FactoryGirl.build(:position, :dy => 7).should have(1).error_on(:dy) }
    end

    context 'is_highlighted' do
      it { FactoryGirl.build(:position, :is_highlighted => nil).should have(1).error_on(:is_highlighted) }
      it { FactoryGirl.build(:position, :is_highlighted => false).should be_valid }
    end
  end
end
