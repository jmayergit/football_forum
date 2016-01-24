class Post < ActiveRecord::Base
  # acts_as_votable
  acts_as_votable
  # unread
  acts_as_readable on: :created_at

  belongs_to :topic
  belongs_to :user
  has_many :bookmarks

  after_create :set_last_post_to_now

  # I created the custom validation before stumbling upon
  # the built in railsy way of validating the associations
  # however I kept my custom due to its descriptive error msg
  validates :topic_id, association: true
  # validates_presence_of :topic
  validates :user_id, association: true

  self.per_page = 5

  def set_last_post_to_now
    topic = self.topic.update(last_post: self.created_at)
  end

  private

  def to_s
    return "Post"
  end
end
