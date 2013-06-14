class ProtectionAnswer < ActiveRecord::Base
  TIME_FOR_ANSWER = 7.3
  TIME_FOR_PAGE_LOAD = 3

  DX = 0
  DY = 1

  belongs_to :protection_quiz
  belongs_to :protection_question
  has_many :protection_answered_positions, :dependent => :destroy

  #scope :correct, joins(:choice).where(:choices => { :is_correct => true })
  scope :opened, where(:answered_at => nil)

  validates :protection_question, :presence => true
  #validate :choice_relation, :if => :choice_id

  def positions= coords
    coords.each { |coord|
      self.protection_answered_positions.build :dx => coord[DX], :dy => coord[DY]
    }
  end

  def answered?
    !!answered_at
  end

  def correct?
    correct_positions_count = 0
    protection_answered_positions.each { |aposition|
      protection_question.protection_correct_positions.each { |cposition|
        correct_positions_count += 1 if cposition.dx == aposition.dx && cposition.dy == aposition.dy
      }
    }
    correct_positions_count >= 3
  end

  def time_out?
    false
  end

  def spent_time
    if closed?
      answered_at - (started_at + TIME_FOR_PAGE_LOAD + protection_question.sec)
    end
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
