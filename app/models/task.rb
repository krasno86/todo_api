class Task < ApplicationRecord
  belongs_to :project, dependent: :destroy
end
