class ProtectionQuestion < ActiveRecord::Base
  has_many :protection_initial_positions, :dependent => :destroy, :order => :id
  has_many :protection_correct_positions, :dependent => :destroy, :order => :id
  has_many :protection_answers, :dependent => :restrict
  attr_accessible :hint_uk, :hint_ru, :hint_en, :sec, :title_uk, :title_ru, :title_en, :video_url
  validates :title_uk, :title_ru, :title_en, :video_url, :sec, :hint_uk, :hint_ru, :hint_en, :presence => true
  validates :video_url,
            :format => /https?:\/\/www\.youtube\.com\/watch\?v=[a-zA-Z\d\-_]*/,
            :allow_blank => true
  validates :sec,
            :numericality => { :greater_than => 0 },
            :allow_blank => true

  def to_s
    title
  end

  def title locale = I18n.locale
    self.try(:"title_#{locale}")
  end

  def hint locale = I18n.locale
    self.try(:"hint_#{locale}")
  end

  def youtube_code
      video_url[/v=([^&]+)/, 1]
  end
end
