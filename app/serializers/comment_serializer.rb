class CommentSerializer
  include FastJsonapi::ObjectSerializer
  attributes :file, :text

  belongs_to :user
  belongs_to :task
end
