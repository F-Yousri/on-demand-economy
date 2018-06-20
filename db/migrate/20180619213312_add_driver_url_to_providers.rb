class AddDriverUrlToProviders < ActiveRecord::Migration[5.0]
  def change
    add_column :providers, :driver_url, :string
  end
end
