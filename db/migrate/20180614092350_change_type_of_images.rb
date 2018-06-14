class ChangeTypeOfImages < ActiveRecord::Migration[5.0]
  def change
    remove_column :orders, :images

    add_column :orders ,:images ,:json
  end
end
