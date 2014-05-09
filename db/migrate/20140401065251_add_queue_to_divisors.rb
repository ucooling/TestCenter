class AddQueueToDivisors < ActiveRecord::Migration
  def change
    add_column :divisors, :queue, :integer
  end
end
