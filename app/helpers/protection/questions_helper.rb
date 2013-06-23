module Protection::QuestionsHelper
  ROWS_COUNT = 6
  COLS_COUNT = 13

  def positions_to_matrix positions
     matrix = Array.new(ROWS_COUNT) { Array.new(COLS_COUNT) }
     positions.each do |position|
       matrix[position.dy - 1][position.dx + 6] = position
     end
     matrix
  end


end

