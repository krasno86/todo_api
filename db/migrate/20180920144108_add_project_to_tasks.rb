class AddProjectToTasks < ActiveRecord::Migration[5.1]
  def change
    add_reference :tasks, :task, foreign_key: true
  end
end
