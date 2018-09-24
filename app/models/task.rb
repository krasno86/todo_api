class Task < ApplicationRecord
  belongs_to :project

  attr_accessor :id, :name
end
