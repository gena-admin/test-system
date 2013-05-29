class Attack::QuizzesController < ApplicationController
  skip_before_filter :close_quiz!, :only => 'destroy'

  before_filter :find_quiz, :only => %w(show destroy)

  def create
    #TODO: Add checking of existing not finished tests
    ActiveRecord::Base.transaction do
      @quiz = Quiz.new
      @quiz.user = current_user
      @quiz.save
      answer = @quiz.next_answer!
      session[:quiz_id] = @quiz.id
      session[:answer_id] = answer.id
      redirect_to edit_attack_quiz_answer_path(@quiz, answer)
    end
  end

  def show
  end

  def destroy
    @quiz.close!
    session[:quiz_id] = nil
    redirect_to attack_quiz_path(@quiz)
  end

  private

  def find_quiz
    @quiz = Quiz.find params[:id]
  end
end
