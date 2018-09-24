class Project < ApplicationRecord
  has_many :tasks, dependent: :destroy
  belongs_to :user

  attr_accessor :id, :name, :user_id
end
