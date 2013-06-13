module Protection::QuestionsHelper
  ROWS_COUNT = 6
  COLS_COUNT = 13

  def protection_question_to_matrix question
     matrix = Array.new(ROWS_COUNT) { Array.new(COLS_COUNT) }
     question.each do |position|
       matrix[position.dy - 1][position.dx + 6] = position
     end
     matrix
  end


end

