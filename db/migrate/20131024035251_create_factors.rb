class CreateFactors < ActiveRecord::Migration
  def change
    create_table :factors do |t|
      t.string :factor_name
      t.integer :test_file_id

      t.timestamps
    end
  end
end
