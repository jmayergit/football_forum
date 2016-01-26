class Avatar < ActiveRecord::Base
  belongs_to :user

  mount_uploader :image, ImageUploader

  validates :image, file_size: { less_than_or_equal_to: 200.kilobytes }
end
