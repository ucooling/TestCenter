class CreateVersions < ActiveRecord::Migration
  def change
    create_table :versions do |t|
      t.string :work_year
      t.string :identifer

      t.timestamps
    end
  end
end
