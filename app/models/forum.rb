class Forum < ActiveRecord::Base
  has_many :topics, dependent: :destroy
  has_many :memberships

  validates :name, presence: true
end
