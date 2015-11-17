class Topic < ActiveRecord::Base
  belongs_to :forum
  belongs_to :user
  has_many :posts, dependent: :destroy, validate: false

  accepts_nested_attributes_for :posts

  validates :subject, presence: true, uniqueness: true
  validates :forum_id, association: true
  validates :user_id, association: true

  private

  def to_s
    return "Topic"
  end
end
