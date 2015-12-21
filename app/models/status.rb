class Status < ActiveRecord::Base
  # associations
  belongs_to :user
  # validations
  validates :value, presence: true, value: true

  def banned?
    self.value == "banned"
  end

  def moderator?
    self.value == "moderator"
  end

  def unsanctioned?
    self.value == "unsanctioned"
  end

  def sanctioned?
    self.value == "sanctioned"
  end
end
