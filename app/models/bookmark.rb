class Bookmark < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  validates :user_id, association: true
  validates :post_id, association: true
end
