class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  before_filter :close_answer!
  before_filter :close_quiz!
  before_filter :set_locale

  protected

  def set_locale
    I18n.locale = current_user.locale if current_user
  end

  def authorize_admin!
    render_access_denied unless current_user.admin?
  end

  def render_access_denied
    render :file => "#{Rails.root}/public/401", :layout => false, :status => 401
  end

  #TODO: add tests
  def close_answer!
    if session[:answer_id]
      if session[:quiz_type] == :attack
        answer = Answer.find session[:answer_id]
      else
        answer = ProtectionAnswer.find session[:answer_id]
      end
      answer.close!
      session[:answer_id] = nil
      if session[:quiz_type] == :attack
        redirect_to new_attack_quiz_answer_path(answer.quiz)
      else
        redirect_to new_protection_quiz_answer_path(answer.protection_quiz)
      end
    end
  end

  #TODO: add tests
  def close_quiz!
    if session[:quiz_id]
      if session[:quiz_type] == :attack
        quiz = Quiz.find session[:quiz_id]
      else
        quiz = ProtectionQuiz.find session[:quiz_id]
      end
      quiz.close!
      session[:quiz_id] = nil
      session[:quiz_type] = nil
      if session[:quiz_type] == :attack
        redirect_to attack_quiz_path(quiz)
      else
        redirect_to protection_quiz_path(quiz)
      end
    end
  end
end
