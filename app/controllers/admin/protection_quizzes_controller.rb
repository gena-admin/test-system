class Admin::ProtectionQuizzesController < Admin::ApplicationController
  before_filter :find_user
  before_filter :find_quiz, :only => %w(show destroy)
  before_filter :quiz_is_closed!, :only => 'destroy'

  def index
    @protection_quizzes = @user.protection_quizzes
  end

  def show
  end

  def destroy
    @protection_quizzes.close!
    redirect_to admin_user_protection_quizzes_path(@user)
  end

  private

  def find_user
   @user = User.find params[:user_id]
  end

  def find_quiz
    @protection_quiz = @user.protection_quizzes.find params[:id]
  end

  def quiz_is_closed!
    redirect_to admin_user_quizzes_path(@user) if @protection_quiz.closed?
  end
end
