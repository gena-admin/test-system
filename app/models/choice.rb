class Choice < ActiveRecord::Base
  has_many :answers
  belongs_to :question
  attr_accessible :is_correct, :title
  validates :title, :question, :presence => true
  validates :is_correct, :inclusion => [true, false]
end
