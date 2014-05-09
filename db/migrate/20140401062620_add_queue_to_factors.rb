class AddQueueToFactors < ActiveRecord::Migration
  def change
    add_column :factors, :queue, :integer
  end
end
