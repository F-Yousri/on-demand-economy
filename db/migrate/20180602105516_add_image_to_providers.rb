class AddImageToProviders < ActiveRecord::Migration[5.0]
  def change
    add_column :providers, :image, :string
  end
end
