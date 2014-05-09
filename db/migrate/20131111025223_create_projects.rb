class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :project_name
      t.string :description
      t.string :test_file_id

      t.timestamps
    end
  end
end
