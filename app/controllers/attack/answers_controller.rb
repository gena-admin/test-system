class Attack::AnswersController < ApplicationController
  before_filter :find_quiz
  before_filter :find_answer, :only => %w(edit update)

  def new
    @answer = @quiz.next_answer!
    redirect_to edit_attack_quiz_answer_path @quiz, @answer
  end

  def edit
    @answer.update_attribute :started_at, Time.now
  end

  def update
    @answer.choice_id = params[:answer][:choice_id]
    @answer.answered_at = Time.now
    @answer.save
  end

  private

  def find_quiz
    @quiz = Quiz.find params[:quiz_id]
  end

  def find_answer
    @answer = @quiz.answers.find params[:id]
  end
end
