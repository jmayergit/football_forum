class Topic < ActiveRecord::Base
  belongs_to :forum
  belongs_to :user
  has_many :posts, dependent: :destroy

  validates :subject, presence: true, uniqueness: true
end
