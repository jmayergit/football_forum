class User < ActiveRecord::Base
  # active record callback
  before_create :assign_unsanctioned_status
  # associations
  has_one :status, dependent: :destroy
  # validations
  validates :username, presence: true, username: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  def banned?
    self.status.value == "banned"
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
