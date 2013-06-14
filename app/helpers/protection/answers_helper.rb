module Protection::AnswersHelper
  def progress_bar_protection protection_quiz
    icons = protection_quiz.protection_answers.map {|protection_answer|
      answer_icon protection_answer
    }
    (Quiz::QUESTIONS_COUNT - protection_quiz.protection_answers.count).times do
      icons << answer_icon(nil)
    end
    icons.join(" ").html_safe
  end

  def answer_icon protection_answer
    return content_tag :i, '', :class => 'icon-circle icon-2x muted' if protection_answer.nil?
    return content_tag :i, '', :class => 'icon-circle icon-2x text-info' unless protection_answer.answered?
    if protection_answer.correct?
      icon_type = protection_answer.time_out? ? 'text-warning' : 'text-success'
      content_tag :i, '', :class => "icon-ok-sign icon-2x #{icon_type}"
    else
      icon_type = protection_answer.time_out? ? 'text-warning' : 'text-error'
      content_tag :i, '', :class => "icon-remove-sign icon-2x #{icon_type}"
    end
  end

  def initial_answer question
    result = question.protection_initial_positions.map { |position|
      "#{position.dx},#{position.dy}"
    }
    result.join('|')
  end
end
