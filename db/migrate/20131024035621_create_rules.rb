class CreateRules < ActiveRecord::Migration
  def change
    create_table :rules do |t|
      t.string :content
      t.integer :test_file_id

      t.timestamps
    end
  end
end
