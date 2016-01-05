class Post < ActiveRecord::Base
  # unread
  acts_as_readable on: :created_at

  belongs_to :topic
  belongs_to :user
  has_many :bookmarks

  # I created the custom validation before stumbling upon
  # the built in railsy way of validating the associations
  # however I kept my custom due to its descriptive error msg
  validates :topic_id, association: true
  # validates_presence_of :topic
  validates :user_id, association: true

  private

  def to_s
    return "Post"
  end
end
