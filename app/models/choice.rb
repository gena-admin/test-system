class Choice < ActiveRecord::Base
  has_many :answers
  belongs_to :question
  attr_accessible :is_correct, :title_uk, :title_ru, :title_en
  validates :title_uk, :title_ru, :title_en, :question, :presence => true
  validates :is_correct, :inclusion => [true, false]

  def to_s
    title
  end

  def title locale = I18n.locale
    self.try(:"title_#{locale}")
  end

  def title locale = I18n.locale
    self.try(:"title_#{locale}")
  end
end
