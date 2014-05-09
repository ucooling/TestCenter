class CreateDivisors < ActiveRecord::Migration
  def change
    create_table :divisors do |t|
      t.string :divisor_name
      t.integer :factor_id

      t.timestamps
    end
  end
end
