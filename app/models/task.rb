class Task < ApplicationRecord
  has_many :comments
  belongs_to :project

  validates :name, presence: true, uniqueness: true

  def display_deadline
    try(:deadline).strftime("%d/%m/%Y")
  end
end
