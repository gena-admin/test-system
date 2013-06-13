class ProtectionAnswer < ActiveRecord::Base
  TIME_FOR_ANSWER = 7.3
  TIME_FOR_PAGE_LOAD = 3

  belongs_to :protection_quiz
  belongs_to :protection_question
  has_many :protection_answered_positions
  #scope :correct, joins(:choice).where(:choices => { :is_correct => true })
  validates :protection_question, :presence => true
  #validate :choice_relation, :if => :choice_id

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

  #private
  #
  #def choice_relation
  #  q = protection_questionn.choices.find_by_id(choice_id)
  #  errors.add(:choice, 'invalid') if q.nil?
  #end
end
