class Attack::AnswersController < ApplicationController
  skip_before_filter :close_answer!, :only => %w(edit update)
  skip_before_filter :close_quiz!

  before_filter :find_quiz
  before_filter :find_answer, :only => %w(edit update)

  def new
    redirect_to finish_attack_quiz_path(@quiz) if @quiz.full?
    @answer = @quiz.next_answer!
    session[:answer_id] = @answer.id
    redirect_to edit_attack_quiz_answer_path @quiz, @answer
  end

  def edit
    @answer.update_attribute(:started_at, Time.now) unless @answer.answered?
  end

  def update
    unless @answer.answered?
      @answer.choice_id = params[:answer][:choice_id] if params[:answer]
      @answer.close!
      session[:answer_id] = nil
    end
    render :text => 'done'
  end

  private

  def find_quiz
    @quiz = Quiz.find params[:quiz_id]
    if @quiz.nil?
      redirect_to root_path
    else
      redirect_to attack_quiz_path(@quiz) if @quiz.closed?
    end
  end

  def find_answer
    @answer = @quiz.answers.find params[:id]
  end
end
