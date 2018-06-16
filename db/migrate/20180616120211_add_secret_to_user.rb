class AddSecretToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :providers, :secret_key, :string
  end
end
