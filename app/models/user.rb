class User < ActiveRecord::Base
  ADMINS = ['surzhkoyevhen@gmail.com', 'gena.admin@gmail.com']
  LOCALES = ["en","ru","uk"]
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :quizzes
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
  attr_accessible :full_name, :birthday, :locale

  validates :is_admin, :inclusion => [true, false]
  validates :locale, :inclusion => LOCALES, :allow_blank => true

  def to_s
    full_name.blank? ? email : full_name
  end

  def admin?
    ADMINS.include?(email) || is_admin
  end
end
