class User < ActiveRecord::Base
  ADMINS = ['surzhkoyevhen@gmail.com', 'gena.admin@gmail.com']
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  def admin?
    ADMINS.include? email
  end
end
