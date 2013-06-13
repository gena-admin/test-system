require 'importer/protection'

class Protection::QuestionsController < Protection::ApplicationController
  before_filter :authorize_admin!
  before_filter :find_question, :only => [:show, :destroy]

  def index
    @protection_questions = ProtectionQuestion.all
  end

  def create
    #puts params[:file].methods.join("\n")
    protection_question = Importer::Protection.new(params[:file].path).import!
    flash[:success] = t('controllers.questions.create.success')
    redirect_to protection_question_path protection_question
  rescue Exception => e
    Rails.logger.error e.message
    Rails.logger.error '=' * 200
    Rails.logger.error e.backtrace.join "\n"
    flash[:success] = t('controllers.questions.create.error')
    redirect_to protection_questions_path
  end

  def show

  end

  def destroy
      @protection_question.destroy
      flash[:success] = t('controllers.questions.destroy.success')
      redirect_to protection_questions_path
  end

  protected

  def find_question
    @protection_question = ProtectionQuestion.find_by_id(params[:id])
    if @protection_question.nil?
      flash[:error] = t('controllers.questions.before_filter.not_found')
      redirect_to protection_questions_path
    end
  end
end
