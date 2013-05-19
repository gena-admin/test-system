require 'importer/attack'

class Attack::QuestionsController < Attack::ApplicationController
  before_filter :authorize_admin!

  def index
    @questions = Question.all
  end

  def create
    #puts params[:file].methods.join("\n")
    question = Importer::Attack.new(params[:file].path).import!
    redirect_to attack_question_path question, :flash => { :notice => 'Question is successfully parsed' }
  rescue Exception => e
    Rails.logger.error e.message
    Rails.logger.error '=' * 200
    Rails.logger.error e.backtrace.join "\n"
    flash[:error] = 'You have submitted file with incorrect format'
    redirect_to attack_questions_path
  end

  def show
  end

  def destroy
  end
end
