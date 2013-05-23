module Attack::QuestionsHelper
  ROWS_COUNT = 6
  COLS_COUNT = 13

  def choice_class choice
    'success' if choice.is_correct
  end

  def question_to_matrix question
     matrix = Array.new(ROWS_COUNT) { Array.new(COLS_COUNT) }
     question.positions.each do |position|
       matrix[position.dy - 1][position.dx + 6] = position
     end
     matrix
  end

  def position_style position
    return if position.nil?
    style = "color:##{position.color};"
    style << "background-color: yellow" if position.is_highlighted
    style
  end
end

