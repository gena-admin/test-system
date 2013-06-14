class ProtectionQuiz < ActiveRecord::Base
  QUESTIONS_COUNT = 15

  belongs_to :user
  has_many :protection_answers, :dependent => :destroy, :order => :id
  attr_accessible :finished_at
  validates :user, :presence => true

  def closed?
    !!finished_at
  end

  def close!
    self.finished_at = Time.now
    self.protection_answers.opened.each { |a| a.close! }
    save
  end

  def full?
    protection_answers.count >= QUESTIONS_COUNT
  end

  def spent_time
    (finished_at - created_at).round if closed?
  end

  def next_answer!
    protection_question_ids = protection_answers.map(&:protection_question_id)
    result = self.protection_answers.build
    result.protection_question = random_question protection_question_ids
    result.save!
    result
  end

  def correct_answers
    @correct_protection_answers ||= protection_answers.select { |a| a.correct? }
  end

  def correct_answers_part
    correct_answers.count * 100 / QUESTIONS_COUNT
  end

  def avg_answer_time
    return @avg_answer_time unless @avg_answer_time.nil?
    spent_times = protection_answers.closed.map &:spent_time
    @avg_answer_time = spent_times.inject {|sum, spent_time|  sum += spent_time } / spent_times.count
  end

  private

  def random_question exclude_question_ids
    if exclude_question_ids.empty?
      questions_offset = rand ProtectionQuestion.count
      ProtectionQuestion.first(:offset => questions_offset)
    else
      questions_offset = rand ProtectionQuestion.where('id NOT IN (?)', exclude_question_ids).count
      ProtectionQuestion.where('id NOT IN (?)', exclude_question_ids).first(:offset => questions_offset)
    end
  end
end
