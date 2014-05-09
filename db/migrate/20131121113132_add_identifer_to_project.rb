class AddIdentiferToProject < ActiveRecord::Migration
  def change
    add_column :projects, :identifer, :string
  end
end
