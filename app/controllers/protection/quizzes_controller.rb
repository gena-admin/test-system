class Protection::QuizzesController < Protection::ApplicationController
  skip_before_filter :close_quiz!, :only => 'destroy'

  before_filter :find_quiz, :only => %w(show destroy)

  def create
    #TODO: Add checking of existing not finished tests
    ActiveRecord::Base.transaction do
      @protection_quiz = ProtectionQuiz.new
      @protection_quiz.user = current_user
      @protection_quiz.save
      answer = @protection_quiz.next_answer!
      session[:quiz_id] = @protection_quiz.id
      session[:answer_id] = answer.id
      session[:quiz_type] = :protection
      redirect_to edit_protection_quiz_answer_path(@protection_quiz, answer)
    end
  end

  def show
  end

  def index
    @protection_quizzes = current_user.protection_quizzes
  end

  def destroy
    @protection_quiz.close!
    session[:quiz_id] = nil
    session[:quiz_type] = nil
    redirect_to protection_quiz_path(@protection_quiz)
  end

  private

  def find_quiz
    @protection_quiz = current_user.protection_quizzes.find params[:id]
  end
end
