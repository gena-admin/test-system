class SessionsController < Devise::SessionsController
  skip_before_filter :close_answer!, :except => 'destroy'
  skip_before_filter :close_quiz!, :except => 'destroy'
  before_filter :clear_session

  private

  def clear_session
    session[:answer_id] = nil
    session[:quiz_id] = nil
  end
end
