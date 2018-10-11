class TaskPolicy
  attr_reader :user, :task, :project

  def initialize(user, task, project)
    @user = user
    @task = task
    @project = project
  end

  def index?
    task.project.user == user
  end

  def show?
    task.project.user == user
  end

  def create?
    task.project.user == user
  end

  def update?
    task.project.user == user
  end

  def destroy?
    task.project.user == user
  end
end