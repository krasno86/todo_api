class ProjectPolicy
  attr_reader :user, :project

  def initialize(user, project)
    @user = user
    @project = project
  end

  def show?
    project.user == user
  end

  def create?
    project.user == user
  end

  def update?
    project.user == user
  end

  def destroy?
    user.role == 'admin' || project.user == user
  end
end