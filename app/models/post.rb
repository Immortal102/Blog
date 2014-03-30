class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  attr_accessible :description, :title

def owner?(user)
   user_id == user.id
end	

end
