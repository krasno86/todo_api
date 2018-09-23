class ProjectSerializer
  include FastJsonapi::ObjectSerializer
  set_id :user_id
  attributes :name

  has_many :tasks, if: Proc.new { |record| record.tasks.any? }
  belongs_to :user

end
