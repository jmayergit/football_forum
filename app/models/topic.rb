class Topic < ActiveRecord::Base
  belongs_to :forum
  belongs_to :user

  validates :subject, presence: true, uniqueness: true
end
