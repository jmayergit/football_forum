class Post < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user

  validates :topic_id, association: true
  validates :user_id, association: true

  private

  def to_s
    return "Post"
  end
end
