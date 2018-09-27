class Task < ApplicationRecord
  has_many :comments
  belongs_to :project

  def display_deadline
    self.deadline.strftime("%d/%m/%Y")
  end

  def completed?

  end
end
