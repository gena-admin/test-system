class Question < ActiveRecord::Base
  has_many :choices, :dependent => :destroy, :order => :id
  has_many :positions, :dependent => :destroy, :order => :id
  has_many :answers, :dependent => :restrict
  attr_accessible :hint, :sec, :title, :video_url
  validates :title, :video_url, :sec, :hint, :presence => true
  validates :video_url,
            :format => /https?:\/\/www\.youtube\.com\/watch\?v=[a-zA-Z\d\-_]*/,
            :allow_blank => true
  validates :sec,
            :numericality => { :greater_than => 0 },
            :allow_blank => true

  def to_s
    title
  end

  def youtube_code
      video_url[/v=([^&]+)/, 1]
  end
end
