class ChangeTypeOfImages < ActiveRecord::Migration[5.0]
  def change
    change_column :orders, :images, :text
  end
end
