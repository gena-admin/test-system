class Attack::QuizzesController < ApplicationController
  def create
    #TODO: Add checking of existing not finished tests
    ActiveRecord::Base.transaction do
      @quiz = Quiz.new
      @quiz.user = current_user
      @quiz.save
      redirect_to edit_attack_quiz_answer_path(@quiz, @quiz.next_answer!)
    end
  end
end
