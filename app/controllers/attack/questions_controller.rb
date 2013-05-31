require 'importer/attack'

class Attack::QuestionsController < Attack::ApplicationController
  before_filter :authorize_admin!
  before_filter :find_question, :only => [:show, :destroy]

  def index
    @questions = Question.all
  end

  def create
    #puts params[:file].methods.join("\n")
    question = Importer::Attack.new(params[:file].path).import!
    flash[:success] = t('controllers.questions.create.success')
    redirect_to attack_question_path question
  rescue Exception => e
    Rails.logger.error e.message
    Rails.logger.error '=' * 200
    Rails.logger.error e.backtrace.join "\n"
    flash[:success] = t('controllers.questions.create.error')
    redirect_to attack_questions_path
  end

  def show

  end

  def destroy
      @question.destroy
      flash[:success] = t('controllers.questions.destroy.success')
      redirect_to attack_questions_path
  end

  protected

  def find_question
    @question = Question.find_by_id(params[:id])
    if @question.nil?
      flash[:error] = t('controllers.questions.before_filter.not_found')
      redirect_to attack_questions_path
    end
  end
end
