class Answer < ActiveRecord::Base
  belongs_to :quiz
  belongs_to :question
  belongs_to :choice
  validates :question, :presence => true
end
