class TaskSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name

  has_many :comments
  belongs_to :project
end
