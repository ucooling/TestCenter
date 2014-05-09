class CreateExamples < ActiveRecord::Migration
  def change
    create_table :examples do |t|
      t.string :content
      t.string :status
      t.string :affirm
      t.string :result
      t.date :implement_time
      t.string :implement_people
      t.string :remark :default=>"0"
      t.date :again_implement_time
      t.string :again_implement_people
      t.integer :test_file_id

      t.timestamps
    end
  end
end
