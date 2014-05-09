class CreateEvidences < ActiveRecord::Migration
  def change
    create_table :evidences do |t|
      t.integer :project_id
      t.integer :test_file_id
      t.integer :example_id
      t.integer :evidence_id

      t.timestamps
    end
  end
end
