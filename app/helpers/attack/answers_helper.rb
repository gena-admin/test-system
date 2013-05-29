module Attack::AnswersHelper
  def progress_bar quiz
    icons = quiz.answers.map {|answer|
      answer_icon answer
    }
    (Quiz::QUESTIONS_COUNT - quiz.answers.count).times do
      icons << answer_icon(nil)
    end
    icons.join(" ").html_safe
  end

  def answer_icon answer
    return content_tag :i, '', :class => 'icon-circle icon-2x muted' if answer.nil?
    return content_tag :i, '', :class => 'icon-circle icon-2x text-info' unless answer.answered?
    if answer.correct?
      icon_type = answer.time_out? ? 'text-warning' : 'text-success'
      content_tag :i, '', :class => "icon-ok-sign icon-2x #{icon_type}"
    else
      icon_type = answer.time_out? ? 'text-warning' : 'text-error'
      content_tag :i, '', :class => "icon-remove-sign icon-2x #{icon_type}"
    end
  end
end
