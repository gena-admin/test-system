class Choice < ActiveRecord::Base
  belongs_to :question
  attr_accessible :is_correct, :title
  validates :title, :question, :presence => true
  validates :is_correct, :inclusion => [true, false]
end
