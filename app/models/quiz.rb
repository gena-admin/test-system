class Quiz < ActiveRecord::Base
  belongs_to :user
  has_many :answers, :dependent => :destroy
  attr_accessible :finished_at
  validates :user, :presence => true

  def finished?
    !finished_at
  end

  def next_answer!
    question_ids = answers.map(&:question_id)
    result = answers.create
    result.question = random_question question_ids
    result
  end

  private

  def random_question exclude_question_ids
    if exclude_question_ids.empty?
      questions_offset = rand Question.count
      Question.first(:offset => questions_offset)
    else
      questions_offset = rand Question.where('id NOT IN (?)', exclude_question_ids).count
      Question.where('id NOT IN (?)', exclude_question_ids).first(:offset => questions_offset)
    end
  end
end
