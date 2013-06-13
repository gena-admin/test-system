module Importer
  class Protection
    def initialize file_path
      @spreadsheet = Roo::Excelx.new file_path, nil, :ignore
      @protection_question = ProtectionQuestion.new
    end

    def import!
      ActiveRecord::Base.transaction do
        @spreadsheet.default_sheet = @spreadsheet.sheets.first
        import_video!
        import_question!
        import_hint!
        @protection_question.save!
        @spreadsheet.default_sheet = @spreadsheet.sheets.second
        import_schema! { @protection_question.protection_initial_positions.build }
        @spreadsheet.default_sheet = @spreadsheet.sheets.third
        import_schema! { @protection_question.protection_correct_positions.build }
      end
      @protection_question
    end

  private

    def import_video!
      @protection_question.video_url = @spreadsheet.row(7)[0]
      @protection_question.sec = @spreadsheet.row(1)[0][/\d+/].to_i
    end

    def import_question!
      @protection_question.title_uk = @spreadsheet.row(2)[0]
      @protection_question.title_ru = @spreadsheet.row(2)[1]
      @protection_question.title_en = @spreadsheet.row(2)[2]
    end

    def import_hint!
      @protection_question.hint_uk = @spreadsheet.row(6)[0]
      @protection_question.hint_ru = @spreadsheet.row(6)[1]
      @protection_question.hint_en = @spreadsheet.row(6)[2]
    end

    def import_schema!
      (1..6).each do |row_index|
        (1..13).each do |col_index|
          value = @spreadsheet.cell(row_index, col_index)
          unless value.blank?
            font = @spreadsheet.font(row_index, col_index)
            position =  yield
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
