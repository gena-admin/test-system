class Question < ActiveRecord::Base
  belongs_to :group
  attr_accessible :hint, :sec, :title, :video_url
  validates :group, :title, :video_url, :sec, :hint, :presence => true
  validates :video_url,
            :format => /https?:\/\/www\.youtube\.com\/watch\?v=[a-zA-Z\d\-_]*/,
            :allow_blank => true
  validates :sec,
            :numericality => { :greater_than => 0 },
            :allow_blank => true
end
