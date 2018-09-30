# frozen_string_literal: true

class Comment < ApplicationRecord
  include Swagger::Blocks

  swagger_schema :Comment do
    key :required, [:id, :text]
    property :id do
      key :type, :integer
      key :format, :int64
    end
    property :text do
      key :type, :string
    end
    property :file do
      key :type, :string
    end
  end

  swagger_schema :CommentInput do
    allOf do
      schema do
        key :'$ref', :Comment
      end
      schema do
        key :required, [:text]
        property :id do
          key :type, :integer
          key :format, :int64
        end
      end
    end
  end

  belongs_to :user
  belongs_to :task

  mount_uploader :file, AvatarUploader

  validates :text, presence: true, length: { minimum: 10,
                                             too_short: "%{count} characters is the minimum allowed",
                                             maximum: 256,
                                             too_long: "%{count} characters is the maximum allowed" }
  validates :file, file_size: { less_than_or_equal_to: 10.megabyte, message: 'file should be less than %{count}' },
                   file_content_type: { allow: ['image/jpg', 'image/png'] }
end
