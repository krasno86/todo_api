class TaskSerializer
  include FastJsonapi::ObjectSerializer
  set_id :project_id
  attributes :name, :text

  has_many :comments, if: Proc.new { |record| record.comments.any? }
  belongs_to :project
end
