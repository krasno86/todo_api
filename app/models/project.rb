class Project < ApplicationRecord
  has_many :tasks
  belongs_to :user, dependent: :destroy

  attr_accessor :id, :name, :user_id
end
