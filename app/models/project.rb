# frozen_string_literal: true

class Project < ApplicationRecord
  include Swagger::Blocks

  swagger_schema :Project do
    key :required, [:id, :name]
    property :id do
      key :type, :integer
      key :format, :int64
    end
    property :name do
      key :type, :string
    end
  end

  swagger_schema :ProjectInput do
    allOf do
      schema do
        key :'$ref', :Project
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

  has_many :tasks, dependent: :destroy
  belongs_to :user

  validates :name, presence: true, uniqueness: true
end
