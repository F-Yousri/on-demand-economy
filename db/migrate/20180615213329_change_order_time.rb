class ChangeOrderTime < ActiveRecord::Migration[5.0]
  def change
    remove_column :orders, :time

    add_column :orders ,:time ,:timestamp
  end
end
