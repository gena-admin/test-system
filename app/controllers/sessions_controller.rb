class SessionsController < Devise::SessionsController
  skip_before_filter :close_answer!
  skip_before_filter :close_quiz!
  before_filter :clear_session

  private

  def clear_session
    session[:answer_id] = nil
    session[:quiz_id] = nil
  end
end
