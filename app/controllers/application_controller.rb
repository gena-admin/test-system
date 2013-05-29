class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  before_filter :close_answer!
  before_filter :close_quiz!

  protected

  def authorize_admin!
    render_access_denied unless current_user.admin?
  end

  def render_access_denied
    render :file => "#{Rails.root}/public/401", :layout => false, :status => 401
  end

  #TODO: add tests
  def close_answer!
    if session[:answer_id]
      answer = Answer.find session[:answer_id]
      answer.close!
      session[:answer_id] = nil
      redirect_to new_attack_quiz_answer_path(answer.quiz)
    end
  end

  #TODO: add tests
  def close_quiz!
    if session[:quiz_id]
      quiz = Quiz.find session[:quiz_id]
      quiz.close!
      session[:quiz_id] = nil
      redirect_to attack_quiz_path(quiz)
    end
  end
end
