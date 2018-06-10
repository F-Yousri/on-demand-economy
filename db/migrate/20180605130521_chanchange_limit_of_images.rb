class ChanchangeLimitOfImages < ActiveRecord::Migration[5.0]
  def change
    change_column :orders, :images, :text, :limit => 4294967295

  end
end
