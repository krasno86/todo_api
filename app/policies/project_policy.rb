class ProjectPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def destroy?
    user.role == 'admin'
    # user.role == 'admin' || record.user == user
  end

  def show?
    user.role == 'admin' || record.user == user
  end
end