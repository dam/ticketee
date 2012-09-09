class User < ActiveRecord::Base
  has_many :tickets
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :admin

  def to_s
    "#{email} (#{admin? ? "Admin" : "User"})"
  end
end
