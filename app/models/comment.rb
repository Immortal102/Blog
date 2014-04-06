class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  attr_accessible :body, :post_id
  validates :body, presence: true

 def owner?(user)
   user_id == user.id
 end	
end
