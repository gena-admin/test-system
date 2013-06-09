class Admin::QuizzesController < Admin::ApplicationController
  before_filter :find_user
  before_filter :find_quiz, :only => 'show'

  def index
    @quizzes = @user.quizzes
  end

  def show
  end

  private

  def find_user
   @user = User.find params[:user_id]
  end

  def find_quiz
    @quiz = @user.quizzes.find params[:id]
  end
end
