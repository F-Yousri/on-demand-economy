class ChangeLongitudeAndLatitudeForOrdersModel < ActiveRecord::Migration[5.0]
  def change
    remove_column :orders, :from
    remove_column :orders, :to 

    add_column :orders ,:src_latitude ,:float
    add_column :orders ,:src_longitude ,:float
    add_column :orders ,:dest_latitude ,:float
    add_column :orders ,:dest_longitude ,:float
  end
end
