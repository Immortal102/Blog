class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  after_create :send_greeting_email

  private

    def send_greeting_email
    	UserMailer.new_user(self).deliver 
    end
end
