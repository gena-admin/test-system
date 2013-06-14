class Protection::AnswersController < Protection::ApplicationController
  skip_before_filter :close_answer!, :only => %w(edit update)
  skip_before_filter :close_quiz!

  before_filter :find_quiz
  before_filter :close_quiz_if_full!, :only => 'new'
  before_filter :find_answer, :only => %w(edit update)

  def new
    @protection_answer = @protection_quiz.next_answer!
    session[:answer_id] = @protection_answer.id
    redirect_to edit_protection_quiz_answer_path @protection_quiz, @protection_answer
  end

  def edit
    @protection_answer.update_attribute(:started_at, Time.now) unless @protection_answer.answered?
  end

  def update
    unless @protection_answer.answered?

      if params[:protection_answered_positions]
        @protection_answer.positions = params[:protection_answered_positions].split('|').map {|i| i.split(',')}
      end
      @protection_answer.close!
      @protection_answer.save
      session[:answer_id] = nil
    end
    render :text => 'done'
  end

  private

  def find_quiz
    @protection_quiz = ProtectionQuiz.find params[:quiz_id]
    if @protection_quiz.nil?
      redirect_to root_path
    elsif @protection_quiz.closed?
      redirect_to protection_quiz_path(@protection_quiz)
    end
  end

  def find_answer
    @protection_answer = @protection_quiz.protection_answers.find params[:id]
  end

  def close_quiz_if_full!
    redirect_to finish_protection_quiz_path(@protection_quiz) if @protection_quiz.full?
  end
end
