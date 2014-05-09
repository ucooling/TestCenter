class CreateTestFiles < ActiveRecord::Migration
  def change
    create_table :test_files do |t|
      t.string :test_file_name

      t.timestamps
    end
  end
end
