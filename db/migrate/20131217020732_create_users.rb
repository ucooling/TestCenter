class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.integer :authority_id, :default=>3

      t.timestamps
    end
  end
end
