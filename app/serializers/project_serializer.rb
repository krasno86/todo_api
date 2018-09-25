class ProjectSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name

  has_many :tasks
  belongs_to :user
end
