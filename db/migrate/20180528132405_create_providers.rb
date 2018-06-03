class CreateProviders < ActiveRecord::Migration[5.0]
  def change
    create_table :providers do |t|
      t.string :url
      t.string :name
      t.integer :rate

      t.timestamps
    end
  end
end
