class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  attr_accessible :description, :title
  validates :title, :description, presence: true
  validates :title, length: { in: 3..51 }
def owner?(user)
   user_id == user.id
   # todo can be better use active_record
end	

end
