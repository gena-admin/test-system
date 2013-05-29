module Attack::QuizzesHelper
  def correct_answers_bar quiz
    correct_answers = quiz.correct_answers.count
    correct_answers_part = (correct_answers * 100) / Quiz::QUESTIONS_COUNT

    content_tag(:strong, correct_answers) <<
    " (#{correct_answers_part}%)" <<
    content_tag(:div, { :class => 'progress progress-info' }, false) do
      content_tag :div, '', :class => 'bar', :style => "width: #{correct_answers_part}%"
    end
  end
end
