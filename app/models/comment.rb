class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  attr_accessible :body, :post_id
  validates :body, presence: true
  # todo flash messages if not valid
 def owner?(user)
   user_id == user.id
   # todo can be better use active_record
 end	
end
