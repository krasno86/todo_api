class Comment < ApplicationRecord

  belongs_to :user
  belongs_to :project

  mount_uploader :file, AvatarUploader
end
