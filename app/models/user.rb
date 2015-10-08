class User < ActiveRecord::Base
  # active record callback
  after_save :assign_unsanctioned_status
  # associations
  has_one :status, dependent: :destroy
  # validations
  validates :username, presence: true, username: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable


  private

  def assign_unsanctioned_status
    self.status = Status.create()
  end
end
