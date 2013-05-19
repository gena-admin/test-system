# encoding: utf-8
require 'spec_helper'
require 'importer/attack'

describe Importer::Attack do
  context 'attack_uk.xlsx' do
    before :all do
      @question = Importer::Attack.new(File.join File.dirname(__FILE__), 'attack_uk.xlsx').import!
    end

    it { @question.should be_valid }

    context 'video' do
      it 'should import video url' do
        @question.video_url.should == 'https://www.youtube.com/watch?v=cyaf4p9IvpE'
      end

      it 'should import video stop second' do
        @question.sec.should == 3
      end
    end

    context 'question' do
      it 'should import @question' do
        @question.title.should == "Завдання: оберіть найбільш вірогідний варіант продовження атаки із запропонованих:"
      end

      it 'should import @question hint' do
        @question.hint.should == "Примітка: на схемі гравець, що виконує другу передачу виділений жовтим кольором."
      end
    end

    context 'choices' do
      it 'should import three choices' do
        @question.choices.length.should == 3
      end

      context 'first' do
        let(:choice) { @question.choices.first }

        it 'should import correct title' do
          choice.title.should == 'Швидка передача в 2 номер'
        end

        it 'should be correct' do
          choice.is_correct.should be_true
        end
      end

      context 'second' do
        let(:choice) { @question.choices.second }

        it 'should import correct title' do
          choice.title.should == 'Висока передача в 4 номер'
        end

        it 'should be correct' do
          choice.is_correct.should be_false
        end
      end

      context 'third' do
        let(:choice) { @question.choices.third }

        it 'should import correct title' do
          choice.title.should == 'Атака першим темпом «Зона»'
        end

        it 'should be correct' do
          choice.is_correct.should be_false
        end
      end
    end

    context 'scheme' do
      it 'should import twelve positions' do
        @question.positions.length.should == 12
      end

      context 'red' do
        let(:position) { @question.positions[0] }

        it { position.dx.should == -3 }
        it { position.dy.should == 1 }
        it { position.color.should == 'FF0000' }
        it { position.is_highlighted.should be_false }
      end

      context 'highlighted' do
        let(:position) { @question.positions[4] }

        it { position.dx.should == 1 }
        it { position.dy.should == 2 }
        it { position.color.should == '00FF00' }
        it { position.is_highlighted.should be_true }
      end

      context 'black' do
        let(:position) { @question.positions[6] }

        it { position.dx.should == -4 }
        it { position.dy.should == 3 }
        it { position.color.should == '000000' }
        it { position.is_highlighted.should be_false }
      end

      context 'green' do
        let(:position) { @question.positions[9] }

        it { position.dx.should == 4 }
        it { position.dy.should == 4 }
        it { position.color.should == '00FF00' }
        it { position.is_highlighted.should be_false }
      end
    end
  end

  context 'attack_en.xlsx' do
    before :all do
      @question = Importer::Attack.new(File.join File.dirname(__FILE__), 'attack_en.xlsx').import!
    end

    it { @question.should be_valid }

    context 'video' do
      it 'should import video url' do
        @question.video_url.should == 'https://www.youtube.com/watch?v=hTVCyNns348'
      end

      it 'should import video stop second' do
        @question.sec.should == 3
      end
    end

    context 'question' do
      it 'should import @question' do
        @question.title.should == "Task: choose the most reliable variant of continuation of attack from offered:"
      end

      it 'should import @question hint' do
        @question.hint.should == "Note: on a chart player that executes the second  pass  distinguished by yellow."
      end
    end

    context 'choices' do
      it 'should import three choices' do
        @question.choices.length.should == 3
      end

      context 'first' do
        let(:choice) { @question.choices.first }

        it 'should import correct title' do
          choice.title.should == 'A fast pass in 1 number'
        end

        it 'should be correct' do
          choice.is_correct.should be_false
        end
      end

      context 'second' do
        let(:choice) { @question.choices.second }

        it 'should import correct title' do
          choice.title.should == 'The first time attack in 3 number'
        end

        it 'should be correct' do
          choice.is_correct.should be_true
        end
      end

      context 'third' do
        let(:choice) { @question.choices.third }

        it 'should import correct title' do
          choice.title.should == 'Setter second hit attack'
        end

        it 'should be correct' do
          choice.is_correct.should be_false
        end
      end
    end

    context 'scheme' do
      it 'should import twelve positions' do
        @question.positions.length.should == 12
      end

      context 'red' do
        let(:position) { @question.positions[0] }

        it { position.dx.should == -3 }
        it { position.dy.should == 1 }
        it { position.color.should == 'FF0000' }
        it { position.is_highlighted.should be_false }
      end

      context 'green' do
        let(:position) { @question.positions[1] }

        it { position.dx.should == 1 }
        it { position.dy.should == 1 }
        it { position.color.should == '00FF00' }
        it { position.is_highlighted.should be_false }
      end

      context 'black' do
        let(:position) { @question.positions[3] }

        it { position.dx.should == -5 }
        it { position.dy.should == 3 }
        it { position.color.should == '000000' }
        it { position.is_highlighted.should be_false }
      end

      context 'highlighted' do
        let(:position) { @question.positions[8] }

        it { position.dx.should == -2 }
        it { position.dy.should == 5 }
        it { position.color.should == 'FF0000' }
        it { position.is_highlighted.should be_true }
      end
    end
  end
end
