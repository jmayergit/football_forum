class User < ActiveRecord::Base
  # unread
  acts_as_reader
  # active record callback
  before_create :assign_unsanctioned_status
  # associations
  has_one :status, dependent: :destroy
  has_many :memberships
  has_many :posts
  # validations
  validates :username, presence: true, username: true, uniqueness: true, length: { in: 4..12 }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable


  def has_status?
    self.status ? true : false
  end

  def banned?
    if self.has_status?
      return self.status.banned?
    end

    true
  end

  def moderator?
    if self.has_status?
      return self.status.moderator?
    end

    false
  end

  def sanctioned?
    if self.has_status?
      return self.status.sanctioned?
    end

    false
  end

  def member?(forum)
    memberships = self.memberships.pluck(:forum_id)
    return memberships.include?(forum.id)
  end

  def is_topic?(resource)
    resource.class.name == "Topic"
  end

  def is_post?(resource)
    resource.class.name == "Post"
  end

  def owns?(resource)
    raise ArgumentError unless (self.is_topic?(resource) || self.is_post?(resource))

    return self.id == resource.user_id
  end



  # Devise checks if your model is active by calling model.active_for_authentication?
  # overwritten to include special condition, banned
  def active_for_authentication?
    super && !banned?
  end

  # Whenever active_for_authentication? returns false, Devise asks the reason why your model is inactive using
  # the inactive_message method.
  def inactive_message
    !banned? ? super : "You have been banned"
  end

  private

  def assign_unsanctioned_status
    self.status = Status.create()
  end


end
