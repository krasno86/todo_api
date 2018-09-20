class AddProjectToComments < ActiveRecord::Migration[5.1]
  def change
    add_reference :comments, :project, foreign_key: true
  end
end
