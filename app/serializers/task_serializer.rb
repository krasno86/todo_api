class TaskSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :text

  has_many :comments
  belongs_to :project
end
