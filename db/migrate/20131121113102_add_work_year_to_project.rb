class AddWorkYearToProject < ActiveRecord::Migration
  def change
    add_column :projects, :work_year, :string
  end
end
