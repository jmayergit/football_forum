class Status < ActiveRecord::Base
  # associations
  belongs_to :user
  # validations
  validates :value, presence: true, value: true

  def banned?
    self.value == "banned"
  end

  def mod?
    self.value == "moderator"
  end
end
