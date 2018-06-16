class AddLoginUrlToProviders < ActiveRecord::Migration[5.0]
  def change
    add_column :providers, :login_url, :string
  end
end
