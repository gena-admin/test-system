# encoding: utf-8
require 'spec_helper'
require 'importer/attack'

describe Importer::Attack do
  context '002.xlsx' do
    before :all do
      @question = Importer::Attack.new(File.join Rails.root, 'questions', 'attack', '002.xlsx').import!
    end

    after :all do
      @question.destroy
    end

    it { @question.should be_valid }

    context 'video' do
      it 'should import video url' do
        @question.video_url.should == 'http://www.youtube.com/watch?v=iSuxV_ccT20'
      end

      it 'should import video stop second' do
        @question.sec.should == 3
      end
    end

    context 'question' do
      it 'should import ukrainian question title' do
        @question.title(:uk).should == "Завдання: оберіть найбільш вірогідний варіант продовження атаки із запропонованих:"
      end

      it 'should import russian question title' do
        @question.title(:ru).should == "Задание: изберите наиболее достоверный вариант продолжения атаки из предложенных:"
      end

      it 'should import english question title' do
        @question.title(:en).should == "Task: choose the most reliable variant of continuation of attack from offered:"
      end

      it 'should import ukrainian question hint' do
        @question.hint(:uk).should == "Примітка: на схемі гравець, що виконує другу передачу виділений жовтим кольором."
      end

      it 'should import russian question hint' do
        @question.hint(:ru).should == "Примечание: на схеме игрок, который выполняет вторую передачу выделенный желтым цветом."
      end

      it 'should import english question hint' do
        @question.hint(:en).should == "Note: on a chart player that executes the second  pass  distinguished by yellow."
      end
    end

    context 'choices' do
      it 'should import three choices' do
        @question.choices.length.should == 3
      end

      context 'first' do
        let(:choice) { @question.choices.first }

        it 'should import ukrainian choice title' do
          choice.title(:uk).should == 'Атака першим темпом «Зона»'
        end

        it 'should import russian choice title' do
          choice.title(:ru).should == 'Атака первым темпом "Зона"'
        end

        it 'should import english choice title' do
          choice.title(:en).should == 'The first time attack  in 3 number'
        end

        it 'should be incorrect' do
          choice.is_correct.should be_false
        end
      end

      context 'second' do
        let(:choice) { @question.choices.second }

        it 'should import ukrainian choice title' do
          choice.title(:uk).should == 'Висока передача в 4 номер'
        end

        it 'should import russian choice title' do
          choice.title(:ru).should == 'Высокая передача в 4 номер'
        end

        it 'should import english choice title' do
          choice.title(:en).should == 'A overhead  pass in 4 number'
        end

        it 'should be incorrect' do
          choice.is_correct.should be_false
        end
      end

      context 'third' do
        let(:choice) { @question.choices.third }

        it 'should import ukrainian choice title' do
          choice.title(:uk).should == 'Комбінація «Пайп»'
        end

        it 'should import russian choice title' do
          choice.title(:ru).should == 'Комбинация "Пайп"'
        end

        it 'should import english choice title' do
          choice.title(:en).should == 'Combination of "Pipe"'
        end

        it 'should be correct' do
          choice.is_correct.should be_true
        end
      end
    end

    context 'scheme' do
      it 'should import twelve positions' do
        @question.positions.length.should == 11
      end

      context 'green' do
        let(:position) { @question.positions[0] }

        it { position.dx.should == 2 }
        it { position.dy.should == 1 }
        it { position.color.should == '00FF00' }
        it { position.is_highlighted.should be_false }
      end

      context 'black' do
        let(:position) { @question.positions[1] }

        it { position.dx.should == -3 }
        it { position.dy.should == 2 }
        it { position.color.should == '000000' }
        it { position.is_highlighted.should be_false }
      end

      context 'red' do
        let(:position) { @question.positions[2] }

        it { position.dx.should == -1 }
        it { position.dy.should == 2 }
        it { position.color.should == 'FF0000' }
        it { position.is_highlighted.should be_false }
      end

      context 'highlighted' do
        let(:position) { @question.positions[6] }

        it { position.dx.should == 1 }
        it { position.dy.should == 4 }
        it { position.color.should == '00FF00' }
        it { position.is_highlighted.should be_true }
      end
    end
  end

end
