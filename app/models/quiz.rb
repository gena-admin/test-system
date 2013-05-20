class Quiz < ActiveRecord::Base
  belongs_to :user
  attr_accessible :finished_at
  validates :user, :presence => true

  def finished?
    !finished_at
  end
end
