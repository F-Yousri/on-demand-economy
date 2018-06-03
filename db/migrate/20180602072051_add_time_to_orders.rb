class AddTimeToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :time, :time
    add_column :orders, :title, :string
  end
end
