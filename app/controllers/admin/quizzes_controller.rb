class Admin::QuizzesController < Admin::ApplicationController
  before_filter :find_user
  before_filter :find_quiz, :only => %w(show destroy)
  before_filter :quiz_is_closed!, :only => 'destroy'

  def index
    @quizzes = @user.quizzes
  end

  def show
  end

  def destroy
    @quiz.close!
    redirect_to admin_user_quizzes_path(@user)
  end

  private

  def find_user
   @user = User.find params[:user_id]
  end

  def find_quiz
    @quiz = @user.quizzes.find params[:id]
  end

  def quiz_is_closed!
    redirect_to admin_user_quizzes_path(@user) if @quiz.closed?
  end
end
