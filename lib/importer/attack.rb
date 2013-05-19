module Importer
  class Attack
    def initialize file_path
      @spreadsheet = Roo::Excelx.new file_path, nil, :ignore
      @question = Question.new
    end

    def import!
      ActiveRecord::Base.transaction do
        @spreadsheet.default_sheet = @spreadsheet.sheets.first
        import_video!
        import_question!
        import_hint!
        @question.save!
        import_choices!
        @spreadsheet.default_sheet = @spreadsheet.sheets.second
        import_schema!
      end
      @question
    end

  private

    def import_video!
      @question.video_url = @spreadsheet.row(7)[0]
      @question.sec = @spreadsheet.row(1)[0][/\d+/].to_i
    end

    def import_question!
      @question.title = @spreadsheet.row(2)[0]
    end

    def import_choices!
      (3..5).each { |i|
        choice = @question.choices.build
        value = @spreadsheet.cell(i, 1)
        choice.title = value.split('.')[1].strip
        choice.is_correct = value.include? '+'
        choice.save!
      }
    end

    def import_hint!
      @question.hint = @spreadsheet.row(6)[0]
    end

    def import_schema!
      (1..6).each do |row_index|
        (1..13).each do |col_index|
          value = @spreadsheet.cell(row_index, col_index)
          unless value.blank?
            font = @spreadsheet.font(row_index, col_index)
            position = @question.positions.build
            position.dx = col_index - 7
            position.dy = row_index
            if font.bold?
              position.color = '000000'
            else
              position.color = position.dx > 0 ? '00FF00' : 'FF0000'
            end
            position.is_highlighted = font.underline?
            position.save!
          end
        end
      end
    end
  end
end
