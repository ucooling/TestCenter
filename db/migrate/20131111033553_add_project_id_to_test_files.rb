class AddProjectIdToTestFiles < ActiveRecord::Migration
  def change
    add_column :test_files, :project_id, :integer
  end
end
