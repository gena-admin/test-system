class Group < ActiveRecord::Base
  has_many :questions, :dependent => :restrict
  attr_accessible :name
end
