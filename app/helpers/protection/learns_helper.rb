module Protection::LearnsHelper
  def position_class dx, correct_position
    result = ''
    result << 'volley-net ' if dx == 6
    result << 'incorrect' if correct_position.nil?
  end
end
