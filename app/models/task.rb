class Task < ApplicationRecord
  belongs_to :project, dependent: :destroy

  attr_accessor :id, :name
end
