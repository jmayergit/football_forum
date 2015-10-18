class Forum < ActiveRecord::Base
  validates :name, presence: true
  validates :private, presence: true
end
