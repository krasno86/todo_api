class CommentPolicy
  attr_reader :user, :comment

  def initialize(user, comment)
    @user = user
    @comment = comment
  end

  def create?
    comment.user == user
  end

  def destroy?
    comment.user == user
  end
end