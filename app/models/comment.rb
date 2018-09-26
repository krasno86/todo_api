class Comment < ApplicationRecord

  belongs_to :user
  belongs_to :project

  mount_uploader :file, AvatarUploader

  validates :text, presence: true, length: { minimum: 10,
                                             too_short: "%{count} characters is the minimum allowed",
                                             maximum: 256,
                                             too_long: "%{count} characters is the maximum allowed" }
  validates :file, file_size: { less_than_or_equal_to: 10.megabyte, message: 'file should be less than %{count}' },
                   file_content_type: { allow: ['image/jpg', 'image/png'] }
end
