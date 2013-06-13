class ProtectionAnsweredPosition < ActiveRecord::Base
  belongs_to :protection_answer
  attr_accessible :alignment, :color, :dx, :dy, :is_highlighted
  validates :color, :dx, :dy, :question, :presence => true
  validates :is_highlighted, :inclusion => [true, false]
  validates :alignment, :inclusion => %w(left center right), :allow_blank => true
  validates :dx, :numericality => { :greater_than_or_equal_to => -6, :less_than_or_equal_to => 6}
  validates :dy, :numericality => { :greater_than_or_equal_to =>  1, :less_than_or_equal_to => 6}
end
