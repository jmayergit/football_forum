class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :forum

  validates :user_id, association: true
  validates :forum_id, association: true
end
