class CommentSerializer
  include FastJsonapi::ObjectSerializer
  set_id :user_id
  attributes :file, :text

  belongs_to :user
  belongs_to :task
end
