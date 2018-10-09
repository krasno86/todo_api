# frozen_string_literal: true

class Task < ApplicationRecord
  include Swagger::Blocks

  swagger_schema :Task do
    key :required, [:id, :name]
    property :id do
      key :type, :integer
      key :format, :int64
    end
    property :name do
      key :type, :string
    end
  end

  swagger_schema :TaskInput do
    allOf do
      schema do
        key :'$ref', :Task
      end
      schema do
        key :required, [:name]
        property :id do
          key :type, :integer
          key :format, :int64
        end
      end
    end
  end

  has_many :comments
  belongs_to :project

  validates :name, presence: true, uniqueness: true

end
