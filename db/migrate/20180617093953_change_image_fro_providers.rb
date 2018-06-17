class ChangeImageFroProviders < ActiveRecord::Migration[5.0]
  def change
    remove_column :providers,:image
    add_column :providers,:image ,:json
  end
end
