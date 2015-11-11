class Topic < ActiveRecord::Base
  belongs_to :forum
  belongs_to :user
  has_many :posts, dependent: :destroy

  accepts_nested_attributes_for :posts

  validates :subject, presence: true, uniqueness: true
end
