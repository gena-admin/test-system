class Answer < ActiveRecord::Base
  TIME_FOR_ANSWER = 7.3
  TIME_FOR_PAGE_LOAD = 3

  belongs_to :quiz
  belongs_to :question
  belongs_to :choice
  scope :correct, joins(:choice).where(:choices => { :is_correct => true })
  validates :question, :presence => true
  validate :choice_relation, :if => :choice_id

  def answered?
    !!answered_at
  end

  def correct?
    !!choice && choice.is_correct
  end

  def time_out?
    spent_time >= TIME_FOR_ANSWER
  end

  def spent_time
    answered_at - (started_at + TIME_FOR_PAGE_LOAD + question.sec)
  end

  def close!
    self.answered_at = Time.now
    save
  end

  private

  def choice_relation
    q = question.choices.find_by_id(choice_id)
    errors.add(:choice, 'invalid') if q.nil?
  end
end
