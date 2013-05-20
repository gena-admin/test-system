class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :choice
  validates :question, :presence => true
  # attr_accessible :title, :body
end
