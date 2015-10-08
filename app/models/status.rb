class Status < ActiveRecord::Base
  # associations
  belongs_to :user
  # validations
  validates :value, presence: true, value: true
end
