class Answer < ActiveRecord::Base
  TIME_FOR_ANSWER = 7.3
  TIME_FOR_PAGE_LOAD = 3

  belongs_to :quiz
  belongs_to :question
  belongs_to :choice

  scope :correct, joins(:choice).where(:choices => { :is_correct => true })
  scope :opened, where(:answered_at => nil)

  validates :question, :presence => true
  validate :choice_relation, :if => :choice_id

  after_create :init_started_at!, :unless => :started_at

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
    if closed?
      answered_at - (started_at + TIME_FOR_PAGE_LOAD + question.sec)
    end
  end

  def close!
    self.answered_at = Time.now
    save
  end

  def closed?
    !!self.answered_at
  end

  private

  def choice_relation
    q = question.choices.find_by_id(choice_id)
    errors.add(:choice, 'invalid') if q.nil?
  end

  def init_started_at!
    self.started_at = self.created_at
    self.save
  end
end
